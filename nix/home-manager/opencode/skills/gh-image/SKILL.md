---
name: gh-image
description: Upload images/files to GitHub as user-attachments assets and embed them in PRs, issues, comments, or markdown bodies — without installing any gh extension. Replicates drogers0/gh-image's bearer endpoint flow directly with curl. Triggers on "upload image to github", "attach screenshot to PR/issue", "gh image", "embed image in pr body".
---

# Skill: gh-image

Upload files to GitHub's undocumented `user-attachments` asset endpoint using
`curl` + `gh auth token` directly. No browser cookies, no extension install.

## 1. Resolve the target repository

The endpoint requires `repository_id` for a repo **the token can push to**.

- Get the numeric ID: `gh api repos/OWNER/REPO --jq .id`
- **Push access is mandatory.** If the target repo isn't yours (e.g. an upstream
  like `koreader/koreader`), the upload returns `404 Not Found`. Fall back to the
  user's fork (`gh api repos/<origin-owner>/<repo> --jq .id`) — `user-attachments`
  URLs render in markdown anywhere, including PRs on other repos. Visibility
  inherits from the repo they were uploaded to (public fork → public images).

## 2. Upload (single request per file)

```bash
curl -s -X POST \
  "https://uploads.github.com/user-attachments/assets?name=<basename>&content_type=<mime>&repository_id=<id>" \
  -H "Authorization: Bearer $(gh auth token)" \
  -H "Accept: application/json" \
  -H "Content-Type: <mime>" \
  -H "Expect: 100-continue" \
  --data-binary @"<file>"
```

- `content_type`: `image/png`, `image/jpeg`, `image/gif`, `video/mp4`, etc.
  (bearer route is **images and video only**; other file types need the
  browser-session flow — tell the user instead of forcing it).
- Success → JSON `{"url":"https://github.com/user-attachments/assets/<uuid>"}`.
- `404 Not Found` → token can't push to that repo; retry with a repo it can
  push to (see §1).
- `422` → wrong content type or non-image/video file.
- Do NOT set extra `Content-Type`/cache headers beyond the one above.

## 3. Embed in the PR/issue body

- Fetch the current body first, append/patch, then update — never clobber:
  `gh pr view <n> --repo OWNER/REPO --json body --jq .body`
- For side-by-side screenshots in tables, use HTML with explicit width
  (GitHub markdown tables don't resize raw `![]()` images):

  ```markdown
  ### Screenshots

  | Caption A | Caption B |
  |---|---|
  | <img src="https://github.com/user-attachments/assets/<uuid>" width="300"> | <img src="..." width="300"> |
  ```

- Outside tables, `![alt](url)` is fine.
- Update with `gh pr edit <n> --repo OWNER/REPO --body-file <tmpfile>`
  (or `gh issue edit` / `gh pr comment --body-file`).

## 4. Notes

- Auth: `gh auth token` (OAuth token from gh CLI). `GH_SESSION_TOKEN` env var
  (a browser `user_session` cookie) is the alternative for the browser-session
  flow, which is the only way to upload non-media files.
- Multiple files: loop the curl call, one URL per file; keep the order stable
  so table cells map to the right captions.
- Verify the URL renders before embedding (it 404s until finalize, which the
  single bearer request does automatically — a `curl -sI` on the URL should
  return 200).
