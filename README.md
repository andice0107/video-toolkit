# 影片生成軟體包 (Video Generation Toolkit)

給所有 agent 與兩台電腦（macOS / Windows）共用的影片、3D、圖片製作工具清單與安裝方式。
最後更新：2026-11-03。「Mac 狀態」與「Windows 狀態」欄皆為實測結果。
GitHub：https://github.com/andice0107/video-toolkit

## 一、影片 / 3D 工具

| 工具 | 用途 | Mac 安裝 (Homebrew) | Windows 安裝 (winget) | 驗證指令 | Mac 狀態 | Windows 狀態 |
|---|---|---|---|---|---|---|
| Blender (LTS) | 3D 建模、渲染、背景批次輸出 | `brew install --cask blender@lts` | `winget install --id BlenderFoundation.Blender -e` | `blender -b --version` | 5.2.3 LTS 已裝 | 5.2.3 LTS 已裝 |
| FFmpeg | 影音轉檔、剪接、合成 | `brew install ffmpeg` | `winget install --id Gyan.FFmpeg -e` | `ffmpeg -version` | 9.0.2 已裝 | 9.0.1 已裝 |
| Node.js | 執行 Remotion | `brew install node` | `winget install --id OpenJS.NodeJS.LTS -e` | `node -v` | v26.9.0 已裝 | v26.7.0 已裝 |
| Remotion | 用 React 程式碼做動畫影片 | `npx create-video@latest` | 同左 | `npx remotion --version`（在專案內） | 免全域安裝，依專案 | 免全域安裝，依專案（MSI Claw 8 AI+ 已實測，見第九節） |
| yt-dlp | 下載影音素材（僅限有授權的內容） | `brew install yt-dlp` | `winget install --id yt-dlp.yt-dlp -e` | `yt-dlp --version` | 已裝 | 2026.08.19 已裝 |
| gifsicle | GIF 壓縮 | `brew install gifsicle` | `winget install --id Gifsicle.Gifsicle -e`（若找不到改用 scoop） | `gifsicle --version` | 未裝（選用） | 1.97 已裝（winget 無此套件，改用 scoop） |
| SoX | 音訊處理 | `brew install sox` | `winget install --id ChrisBagwell.SoX -e` | `sox --version` | 未裝（選用） | 14.4.2 已裝 |

## 二、圖片工具（不需 GPU，裝了就能用）

| 工具 | 用途 | Mac 安裝 | Windows 安裝 | Mac 狀態 | Windows 狀態 |
|---|---|---|---|---|---|
| ImageMagick | 縮放、裁切、合成、格式轉換 | `brew install imagemagick` | `winget install --id ImageMagick.ImageMagick -e` | 未裝 | 7.1.2-34 已裝 |
| Pillow (Python) | 程式化畫圖、加文字、拼圖 | `pip3 install pillow` | `pip install pillow` | 未裝 | 13.0.0 已裝（`%USERPROFILE%\image-toolkit\venv`；全域 12.3.0） |
| sharp (Node) | 高速圖片處理 | `npm i sharp` | `npm i sharp` | 依專案 | 已裝（`%USERPROFILE%\image-toolkit`） |
| Playwright | 把 HTML/CSS/SVG 排版截成 PNG | `npm i -D playwright && npx playwright install chromium` | 同左 | 未裝 | 已裝（chromium-1248） |
| librsvg | SVG 轉 PNG | `brew install librsvg` | 改用 Inkscape 或 sharp | 未裝 | 未裝（改用 Inkscape／sharp） |
| Inkscape | 向量圖編輯 | `brew install --cask inkscape` | `winget install --id Inkscape.Inkscape -e` | 未裝 | 1.4.4 已裝 |
| Blender | 3D 場景渲染成靜態圖 | 見上表 | 見上表 | 已裝 | 已裝 |

## 三、AI 生圖（需另外評估）

- 雲端：Claude 連接的 Canva 連接器有 `generate-image`，不用裝軟體。
- 本機（Apple Silicon Mac）：可裝 ComfyUI、mflux、DiffusionBee，需要下載數 GB 模型，速度比有 NVIDIA 顯卡的 Windows 慢。
- 本機（Windows）：有 NVIDIA 顯卡時用 ComfyUI 或 diffusers，沒有顯卡不建議。
- Windows 實測（2026-11-03，Intel UHD 770 那台）：僅有 Intel UHD Graphics 770，無 NVIDIA 顯卡（`nvidia-smi` 不存在），未安裝 ComfyUI、未下載模型。
- Windows 實測（2026-11-03，MSI Claw 8 AI+，Intel Arc 140V 內顯）：ComfyUI 能跑，但畫質與速度的 CP 值低，已移除，詳見第九節與 image-toolkit。要做影片優先用第五節的程式化流程（Remotion／Blender）。
- 這類工具會下載外部模型，安裝前請先徵得使用者同意。

## 四、一鍵安裝

- Mac：`bash install-mac.sh`
- Windows（PowerShell）：`.\install-windows.ps1`

腳本只裝核心三件（Blender LTS、FFmpeg、Node.js），已存在就略過。

Windows 腳本補充（2026-11-03 實測）：

- 選用工具 gifsicle 與 SoX 由腳本一併安裝；gifsicle 在 winget 找不到時自動改用 scoop。
- Blender 安裝後不會自動寫入 PATH，腳本會檢查後補進使用者 PATH；已存在就不重複寫入。
- 結尾逐項驗證並印出結果；若顯示找不到指令，重開終端機後再跑一次。

## 五、典型流程

1. Blender 背景渲染：`blender -b scene.blend -o //out/frame_#### -F PNG -a`
2. FFmpeg 合成：`ffmpeg -framerate 30 -i out/frame_%04d.png -c:v libx264 -pix_fmt yuv420p out.mp4`
3. Remotion 疊字幕與動畫：`npx remotion render <入口檔> <composition> out.mp4`

## 六、維護規則（給 agent）

- 新增或移除工具時，同步更新本表與兩個安裝腳本，再更新日期。
- 「狀態」欄只寫實測過的結果，沒測過就寫未驗證。
- Mac 與 Windows 兩欄都要填；Windows 有多台時，欄位內註明是哪一台，新機型另開第九節那樣的小節，不要覆寫舊紀錄。
- 失敗與不實用的嘗試也要記錄（第十一節），並寫明原因與是否已移除。
- 不要在此放金鑰、帳密或個人檔案。

## 七、Linux（雲端 Claude 沙盒）安裝參考（未實測）

- Debian/Ubuntu：`sudo apt install ffmpeg blender nodejs npm`
- Remotion 不需全域安裝，在專案內 `npm i remotion @remotion/cli react react-dom`，首次渲染會自動下載 Chromium。
- 沒有 GPU 時，Blender 用 `-b` 背景模式與 Eevee/CPU 渲染，速度較慢。
- 實際可用性取決於沙盒是否允許連網與 sudo。

## 八、已驗證的範例

good-morning-video：30 秒早安動畫用 Remotion（SVG 動畫）+ numpy 合成音樂 + 內建 FFmpeg 編碼，在 8GB Mac 上約 4 分鐘渲染完成。

hello-video：4 秒打招呼動畫（1280×720、30 幀、120 幀），用 Remotion 的 `spring`／`interpolate` 做彈出與揮手，輸出約 1.3MB 的 MP4，在 MSI Claw 8 AI+ 上渲染成功（見第九節）。

## 九、Windows 實測：MSI Claw 8 AI+（2026-11-03）

機型：Intel Core Ultra 7 258V、Intel Arc 140V 內顯（16GB 共用）、32GB RAM、無 NVIDIA 顯卡。以下皆為這台的實測結果，與上方 Windows 欄（另一台）分開記錄。

| 項目 | 實測版本 / 結果 |
|---|---|
| Blender | 5.2.3 LTS（`blender -b --version` 通過；尚未實際渲染畫面） |
| FFmpeg | 9.0.2 |
| Node.js / npm | v24.22.1 / 11.19.1（winget 另有 26.13.0，跨大版本，未升級；Remotion 在 v24 上可用） |
| Remotion | 4.0.250，專案內安裝，渲染成功 |
| three.js（`@remotion/three`） | 未安裝（需要 3D 影片時在該專案內再裝） |
| yt-dlp / Git / GitHub CLI / pip | 2026.10.26 / 2.56.0.4 / 2.103.3 / 26.3 |

### Remotion 在 Windows 的做法（已驗證）

1. 專案放在本機硬碟（例如 `C:\AI\hello-video`），**不要放在 Google 雲端硬碟同步資料夾**：`node_modules` 有上萬個小檔案，會拖慢同步。
2. `package.json` 的相依套件：`remotion`、`@remotion/cli`、`react`、`react-dom`，Remotion 兩個套件版本要一致（實測 4.0.250）。
3. 結構：`src/index.ts`（`registerRoot`）、`src/Root.tsx`（`<Composition>` 設定長度、fps、尺寸）、`src/Hello.tsx`（畫面）。
4. `npm install` 後執行 `npx remotion render src/index.ts Hello out/hello.mp4`；首次渲染會自動取得所需的瀏覽器元件。
5. 中文字體用 `"Microsoft JhengHei"`，表情符號（如 👋）可正常顯示。
6. 渲染完成後用 `ffmpeg` 抽幾個畫面檢查，再把 MP4 複製到需要的資料夾。

### 本機 AI 影片生成：不建議（Intel Arc 內顯實測）

LTX-Video 2B（v0.9.5，384×256、25 幀、20 步）約 35 秒生成 1 秒影片，但畫面模糊、主體幾乎沒動，只證明流程能跑通，不具實用價值，已移除。要做影片請用上方程式化流程，或使用線上服務。

## 十、給 agent 的最佳建議（含 YouTuber 推薦流程）

**1. 先分清楚使用者說的「生圖／生影片」是哪一種。**

- **A. 程式化生成：** agent 寫程式組出畫面與動畫（Remotion、Blender、three.js、Pillow、Playwright、FFmpeg）。不需顯卡，任何電腦都能跑，成果可重現，改一行設定就能重新渲染。
- **B. AI 生成式影像：** 用模型直接生出寫實圖片或影片（ComfyUI、Sora、Veo、Runway、Canva `generate-image`）。吃算力，品質取決於硬體或雲端服務。
- 使用者曾把兩者混為一談，結果在 MSI Claw 8 AI+ 上裝了約 25GB 的 AI 生成環境，品質差、最後全部移除。**預設先走 A，要走 B 前先跟使用者確認期待。**

**2. YouTuber 推薦的生成方式（使用者提供的截圖整理，影片本身未看過）：**

| 工具 | 負責的事 |
|---|---|
| Remotion | 時間軸、文字、動畫，最後輸出 MP4 |
| three.js（`@remotion/three`） | 直接在 Remotion 裡做 3D 畫面 |
| Blender | 較複雜的 3D 模型或高品質渲染，輸出 glTF 或渲染好的畫面，再交給 Remotion 合成 |
| Node.js／npm | 執行 Remotion 與 three.js |
| FFmpeg | 轉檔、剪接、合成 |

要點：這是「Claude 寫程式來做影片」，不是 AI 生成寫實影像。第一支影片的需求出現後，才依內容建立 Remotion 專案，不必預先建立。
**實測狀態：** Remotion 在 MSI Claw 8 AI+ 上渲染成功（第九節）；Blender 只驗證到版本指令，未實際渲染；three.js 未安裝、未驗證。

**3. 要走 B 之前先查硬體，不要先裝：**

- Windows：`Get-CimInstance Win32_VideoController`、`nvidia-smi`；Mac：確認 Apple Silicon 與記憶體。
- 沒有 NVIDIA 顯卡（含 Intel 內顯）：不要在本機裝 ComfyUI。AI 插圖用 Canva `generate-image` 或線上服務；AI 影片用線上服務（需使用者自己的帳號或金鑰）。
- 模型動輒數 GB，下載前先量剩餘空間並徵得使用者同意。

**4. 工作習慣：**

- Remotion／Node 專案放本機磁碟，不要放在 Google 雲端硬碟同步資料夾（`node_modules` 檔案太多會拖慢同步）。
- 交付影片前用 `ffmpeg` 抽 3–4 個畫面自己看過，再說「品質不錯」；不要把普通的結果說得太好。
- 多台 Windows 的實測結果要分機型記錄，不要用新機器的結果覆寫舊機器的欄位（第九節就是這樣分開）。
- 不用的大型檔案（模型、快取）及時清掉，並把成敗寫回 README。
- 更新軟體前先看清楚是小版本還是大版本：Node.js 24→26 這種跨大版本先不升，除非有需要。

## 十一、安裝紀錄：成功與不成功（MSI Claw 8 AI+，2026-11-03）

**成功**

- 軟體包工具：Blender、FFmpeg、Node.js、yt-dlp、gifsicle、SoX、ImageMagick、Inkscape 皆已安裝可用（版本見第九節）。
- Remotion 4.0.250：打招呼動畫兩支（「哈囉！你好！」「嗨！你好！」），4 秒、1280×720，渲染成功，抽幀檢查文字與表情符號正常。
- 小版本更新：yt-dlp、GitHub CLI、Git、pip。
- ComfyUI＋PyTorch 2.15.0+xpu：偵測到 Arc 140V，SDXL-Turbo 能出圖。

**不成功／不實用（已移除）**

- SDXL-Turbo（512×512、2 步，約 24 秒一張）：能出圖但畫質普通，動物臉部結構容易出錯。我最初評價「品質不錯」說得太好，使用者看了覺得很爛。
- LTX-Video 2B：流程跑通，但畫面模糊、主體幾乎沒動，無實用價值。
- 整套 ComfyUI 約 25GB（PyTorch 套件 5.2GB、模型 17.2GB、pip 快取 2.2GB），CP 值低，使用機會也低，全部刪除。重裝步驟見 image-toolkit 第二節。
- PyTorch XPU 套件下載安裝超過 10 分鐘，會超過單次指令的逾時，需放背景執行。
- `rsvg-convert` 未裝（Windows 本來就改用 Inkscape／sharp）。

**未驗證**

- Blender 實際渲染畫面、three.js／`@remotion/three` 的 3D 影片。
- SDXL 1.0、Flux 在 Arc 內顯上的速度與可行性。

**過程中的錯誤（避免重蹈）**

- 一開始沒先指出「軟體包本來就能做程式化影片」，直接往 AI 生成走，多裝了東西。
- 曾誤把另一台 Windows 的紀錄（Node v26.7.0、Intel UHD 770）當成這台的錯誤；其實是不同機型，所以才在第九節分機型記錄。
