---
layout: defaults/page
permalink: index.html
narrow: true
title: This is Fanshi Meng
---

<style>
.cover-container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 60vh;
  gap: 40px;
}
.cover-left {
  max-width: 50%;
}
.cover-title {
  font-size: 2.8em;
  font-weight: bold;
  color: #222;
  text-shadow: 2px 2px 8px #d17b7b88, 0 2px 4px #0002;
  margin-bottom: 0.2em;
}
.cover-subtitle {
  font-size: 2em;
  color: #d17b7b;
  font-weight: bold;
  text-shadow: 1px 1px 6px #d17b7b44, 0 1px 2px #0002;
  margin-bottom: 1em;
}
.cover-btn {
  display: inline-block;
  background: #d17b7b;
  color: #fff;
  padding: 12px 32px;
  border-radius: 20px;
  box-shadow: 0 4px 16px #d17b7b44;
  font-weight: bold;
  text-decoration: none;
  margin-top: 24px;
  transition: background 0.2s;
}
.cover-btn:hover {
  background: #b15c5c;
}
.cover-socials a {
  display: inline-block;
  margin-right: 18px;
  margin-bottom: 10px;
  color: #d17b7b;
  font-size: 1.8em;
  transition: color 0.2s;
}
.cover-socials a:hover {
  color: #b15c5c;
}
.cover-photo {
  width: 320px;
  border-radius: 18px;
  box-shadow: 0 8px 32px #0002, 0 2px 8px #d17b7b44;
  object-fit: cover;
}
@media (max-width: 900px) {
  .cover-container { flex-direction: column; align-items: flex-start; }
  .cover-photo { width: 100%; max-width: 320px; margin-top: 32px; }
  .cover-left { max-width: 100%; }
}
</style>

<div class="cover-container">
  <div class="cover-left">
    <h2 style="margin-bottom: 0.5em;">Hello, It's Me</h2>
    <div class="cover-title">Li He 贺力</div>
    <div class="cover-subtitle">I'm a Web DI</div>
    <p style="font-size: 1.1em; margin-bottom: 1.5em;">
      I am currently pursuing a Master of Science in Computer Science at the Georgia Institute of Technology.<br>
    </p>
    <div class="cover-socials" style="margin: 20px 0;">
      <a href="#" title="Facebook"><i class="fa fa-facebook-official"></i></a>
      <a href="#" title="LinkedIn"><i class="fa fa-linkedin-square"></i></a>
      <a href="mailto:your@email.com" title="Email"><i class="fa fa-envelope"></i></a>
      <a href="#" title="GitHub"><i class="fa fa-github"></i></a>
    </div>
    <a href="/about.html" class="cover-btn">More About Me</a>
  </div>
  <div>
    <img src="/theme/img/portrait.JPG" alt="profile" class="cover-photo">
  </div>
</div>
