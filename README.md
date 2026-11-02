# 影片生成軟體包 (Video Generation Toolkit)

給所有 agent 與兩台電腦（macOS / Windows）共用的影片、3D、圖片製作工具清單與安裝方式。
最後更新：2026-11-03。「狀態」欄為 Mac 實測結果。

## 一、影片 / 3D 工具

| 工具 | 用途 | Mac 安裝 (Homebrew) | Windows 安裝 (winget) | 驗證指令 | Mac 狀態 |
|---|---|---|---|---|---|
| Blender (LTS) | 3D 建模、渲染、背景批次輸出 | `brew install --cask blender@lts` | `winget install --id BlenderFoundation.Blender -e` | `blender -b --version` | 5.2.3 LTS 已裝 |
| FFmpeg | 影音轉檔、剪接、合成 | `brew install ffmpeg` | `winget install --id Gyan.FFmpeg -e` | `ffmpeg -version` | 9.0.2 已裝 |
| Node.js | 執行 Remotion | `brew install node` | `winget install --id OpenJS.NodeJS.LTS -e` | `node -v` | v26.9.0 已裝 |
| Remotion | 用 React 程式碼做動畫影片 | `npx create-video@latest` | 同左 | `npx remotion --version`（在專案內） | 免全域安裝，依專案 |
| yt-dlp | 下載影音素材（僅限有授權的內容） | `brew install yt-dlp` | `winget install --id yt-dlp.yt-dlp -e` | `yt-dlp --version` | 已裝 |
| gifsicle | GIF 壓縮 | `brew install gifsicle` | `winget install --id Gifsicle.Gifsicle -e`（若找不到改用 scoop） | `gifsicle --version` | 未裝（選用） |
| SoX | 音訊處理 | `brew install sox` | `winget install --id ChrisBagwell.SoX -e` | `sox --version` | 未裝（選用） |

## 二、圖片工具（不需 GPU，裝了就能用）

| 工具 | 用途 | Mac 安裝 | Windows 安裝 | Mac 狀態 |
|---|---|---|---|---|
| ImageMagick | 縮放、裁切、合成、格式轉換 | `brew install imagemagick` | `winget install --id ImageMagick.ImageMagick -e` | 未裝 |
| Pillow (Python) | 程式化畫圖、加文字、拼圖 | `pip3 install pillow` | `pip install pillow` | 未裝 |
| sharp (Node) | 高速圖片處理 | `npm i sharp` | `npm i sharp` | 依專案 |
| Playwright | 把 HTML/CSS/SVG 排版截成 PNG | `npm i -D playwright && npx playwright install chromium` | 同左 | 未裝 |
| librsvg | SVG 轉 PNG | `brew install librsvg` | 改用 Inkscape 或 sharp | 未裝 |
| Inkscape | 向量圖編輯 | `brew install --cask inkscape` | `winget install --id Inkscape.Inkscape -e` | 未裝 |
| Blender | 3D 場景渲染成靜態圖 | 見上表 | 見上表 | 已裝 |

## 三、AI 生圖（需另外評估）

- 雲端：Claude 連接的 Canva 連接器有 `generate-image`，不用裝軟體。
- 本機（Apple Silicon Mac）：可裝 ComfyUI、mflux、DiffusionBee，需要下載數 GB 模型，速度比有 NVIDIA 顯卡的 Windows 慢。
- 本機（Windows）：有 NVIDIA 顯卡時用 ComfyUI 或 diffusers，沒有顯卡不建議。
- 這類工具會下載外部模型，安裝前請先徵得使用者同意。

## 四、一鍵安裝

- Mac：`bash install-mac.sh`
- Windows（PowerShell）：`.\install-windows.ps1`

腳本只裝核心三件（Blender LTS、FFmpeg、Node.js），已存在就略過。

## 五、典型流程

1. Blender 背景渲染：`blender -b scene.blend -o //out/frame_#### -F PNG -a`
2. FFmpeg 合成：`ffmpeg -framerate 30 -i out/frame_%04d.png -c:v libx264 -pix_fmt yuv420p out.mp4`
3. Remotion 疊字幕與動畫：`npx remotion render <入口檔> <composition> out.mp4`

## 六、維護規則（給 agent）

- 新增或移除工具時，同步更新本表與兩個安裝腳本，再更新日期。
- 「狀態」欄只寫實測過的結果，沒測過就寫未驗證。
- Mac 與 Windows 兩欄都要填。
- 不要在此放金鑰、帳密或個人檔案。

## 七、Linux（雲端 Claude 沙盒）安裝參考（未實測）

- Debian/Ubuntu：`sudo apt install ffmpeg blender nodejs npm`
- Remotion 不需全域安裝，在專案內 `npm i remotion @remotion/cli react react-dom`，首次渲染會自動下載 Chromium。
- 沒有 GPU 時，Blender 用 `-b` 背景模式與 Eevee/CPU 渲染，速度較慢。
- 實際可用性取決於沙盒是否允許連網與 sudo。

## 八、已驗證的範例

good-morning-video：30 秒早安動畫用 Remotion（SVG 動畫）+ numpy 合成音樂 + 內建 FFmpeg 編碼，在 8GB Mac 上約 4 分鐘渲染完成。
