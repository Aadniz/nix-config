{ dotfilesDir }:

{
  ".." =   "cd ..";
  ll =     "ls -aslhpx --group-directories-first";
  ytmp3 =  "yt-dlp -x --audio-format mp3 --no-mtime --add-metadata --xattrs --embed-thumbnail -o '%(title)s.%(ext)s' ";
  yt =     "yt-dlp --add-metadata ";
}
