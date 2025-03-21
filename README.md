# yt-dlp Docker Image

This Docker image provides a lightweight and automated solution to download videos using **yt-dlp**. It comes pre-configured with **yt-dlp**, **ffmpeg**, and other necessary dependencies. You can use it to download videos with the best quality, automatically merging audio and video streams into a single file.

## Features
- **yt-dlp** (YouTube-DL fork) pre-installed
- Latest **ffmpeg** for video processing
- Automatic update for yt-dlp inside the container
- Easy to use with Docker for video downloads
- Supports custom video name and destination folder

## Usage

### Run yt-dlp to download a video

You can run this container and download videos by specifying a **video URL**, **destination folder**, and **output file name**.

```bash
docker run --rm \
    --user $(id -u):$(id -g) \
    -v "$DESTINATION_FOLDER:/downloads" \
    yt-dlp-auto \
    yt-dlp -f "bv*+ba/b" --merge-output-format mp4 \
    -S "res:2160,codec:h264" \
    -o "/downloads/$OUTPUT_NAME.%(ext)s" "$VIDEO_URL"
