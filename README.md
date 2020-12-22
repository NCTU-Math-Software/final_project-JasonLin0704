# Project 6 - NCTU_MAP
#### 在這張交大地圖可行走之道路上選取任意兩點，找出兩點間的最短路徑，並且以「平滑」曲線顯示。
## 檔案有:
+ *編輯過照片 \*4*
*(原圖網址: http://www.ltc.tw/CN/event/map/mapNCTU.htm)*
+ ***NCTU_MAP.m***
+ *node.txt (additional)*
+ *write.py (additional)*
## 開啟方法:
+ 請將整個資料夾下載後解壓縮，放到文件的matlab資料夾中，**用matlab開啟"NCTU_MAP.m"後執行檔案**即可。\
(雙擊點進NCTU_MAP.m後按run(F5) / 在command line輸入"NCTU_MAP.m" )
## 關閉方法:
+ 執行後，程式就會進入"**等待使用者輸入**"狀態，若要離開，建議按**滑鼠右鍵離開狀態後，再按叉叉關閉**。
## 使用說明:
+ 在「**地圖可行走的道路**」上「**用滑鼠任意點兩點**」，若出現菱形，表示成功選點，選完兩個點，即出現結果。\
**〈注意: 若點完沒反應很可能是選取點離可行走的範圍太遠，盡量點在交叉路上，會有很不錯的效果!〉**
+ **重複執行** => 按**滑鼠左鍵**即可再次選點。
+ **離開程式** => 按**滑鼠右鍵再按叉叉**。
## 主要目標: (由低到高)
1. 在此圖上可行走之主要道路上任意點兩點，可找出一條路徑通過，且此路徑在可行走之主要道路上。 ***(done)***
2. 路徑上的節點不重複，且此路徑必須為最短路徑。 ***(done)***
3. 找出高次參數多項式逼近路線，使其顯示出來是一條平滑曲線，而非點到點的折線圖。 ***(done)***
4. 增加一些功能，可能有: 重複執行 ***(done)***、一開始顯示可行走的地方、顯示選取的點是否有被接受...。
5. 若原地圖有比例尺，可將各邊長度轉換成實際距離，給定一速率並大概推算出，在等速率的狀況下，多久時間內可以抵達。
6. 加入坡度、尖峰離峰時段...等參數當成各邊上的cost，並找出cost最小的路徑，即是更貼近真實情況之最佳路徑。
7. 讓使用者可以選任意n點，在無順序前後的前提下，規劃出一條最佳路徑，以最高效率通過所有點。
8. (待想)
## 實踐方法:
1. 將可行走之主要道路區分成眾多節點和邊，形成一張**simple connected graph**，並手動記錄「各編號節點的座標」、「各兩點間距離」。
2. 利用**Dijkstra演算法**，找出一條最短路經。
3. 利用matlab內**polyfit**函式，找出一高次多項次逼近路線，畫出一條「平滑」曲線。
## 重點解釋:
1. 每個初始節點位置，是用ginput，分成x,y座標手動紀錄；各節點相鄰狀況也是手動調查，並用python code轉成s(a,b)=0 or 1的形式。
---
2. **dijkstra演算法:「給定一個source點，可以求出所有其他節點到source的最短距離及所找路線前一個節點。」**
+ 假設source為A。 D(A, i)表示A,i目前最短距離。 predecessor(i)為i的最短路徑的前一個節點。 節點數為n。
+ 先找離A最近的node，當作current node，並對該點的所有鄰居判斷，若D(A, current) + D(current, 鄰居) < D(A, 鄰居)，則更新鄰居的最短距離及前一個節點。
+ A到current的最短距離是確定的，因此在迴圈最後，將D(A, current)存到final_D(A, current)，並將D(A, current)改成9999。
+ 之後的每次迴圈都找出一個current node，做同樣的判斷及更新，在所有D(A, i)都=9999時，就代表找到A到其他n-1個節點的最短距離了，即可跳出迴圈。 (理論上，應該跑n-1次迴圈即可)
---
3. 要顯示A到B的最短路線，只需要從B開始依序查詢predecessor，直到是A，全部連線即可。
4. polyfit的部分是在所找路徑上的n個節點中，插入更多的點，並用高次多項式去逼近。
   一般來說，都是平均塞點，但我這裡是不平均塞點: 轉折處多塞點，線段中間處正常塞，如此一來可解決多項式在轉折處會不夠靠近的問題。
## 作業歷程: (>25hr)
### (109/12/11)
+ 因為這張交大地圖格式簡潔好看，但年代久遠，所以決定做翻新工作，包括將南大門、研三舍、科三、工六等建物補上，並試著簡化道路，同時增加精確度，使其貼近現在學生常走路線。 (~2hr)
+ 將地圖可行走之主要道路分成79個節點，將其編號，並且用**ginput**的方法手動紀錄各節點座標。(1hr)
+ 手動調查各節點相鄰狀況，若有相鄰，則該邊設為1，否則設為零。用79*79的**稀疏矩陣s**紀錄。(1hr)
#### 遭遇問題
1. 用小畫家編輯存檔後畫質變差，但因這次方法實踐和顏色較無關係，所以影響不大。\
   推測可能是因為原圖是gif檔，再次用gif檔另存新檔時，在圖片壓縮時發生了錯誤。
2. 手動紀錄數值極為耗時，幸好同學提醒，先建立邊與邊對應關係，用txt檔儲存，再用python造出sparse的資料，整個貼到matlab上，整個過程快上許多，且容易除錯，修改點數。

### (109/12/12)
+ 更進一步初始化: 若兩點a, b相鄰，將s(a,b)改為ab圖上距離;若不相鄰，則設成9999。(10mins)
+ 使用者點的兩點會自動對應到「距離最近且夠靠近」的節點，用兩節點即為路徑端點。(25mins)
+ 設A,B為起終點編號，D及final_D為一維向量，用來記錄「A到該點當前最短距離」及「不再變動之確定最短距離」，predecessor為一維向量，表示「最短路徑的前一節點編號」，前置準備工作完成。
+ 實踐**Dijkstra演算法**，求出「A到各點的最短距離」&「最短路徑前一項」。
+ 套用之前所學**polyfit**，將原本的折線圖換成平滑曲線來顯示。(20mins)
#### 遭遇問題
1. 這邊卡了非常久，主要是在想該怎麼實踐dijkstra algorithm，不知道該怎麼存取變數，最終才想出其實用D和predecessor兩個一維陣列即可，但因為D可能會不斷更新，直到他是目前佇列中最短的，值    才會確定，因此多了一個**final_D**用來存「確定結果」。另外，關於如何判定全部找完也想了很久，最後是用「如果D(ii)值確定後，則改用final_D(ii)存，並將D(ii)改成9999，之後每次迴圈檢查    是否D(ii)==9999，for all 1<=i<=79即可。
2. 過程中一直遇到「無窮迴圈的問題」還有「路徑顯示很奇怪」，經檢查所有矩陣資料變動情況，得知皆是一開始s(a,b)打錯導致的，幸好有用文字檔+python設定s初始值，修改下來省力許多...。

### (109/12/13)
+ 更新了點的資料: 增加到了83點，並改了一些點的位置，讓路線比較平滑，更貼近現實情況。

### (109/12/18)
+ 更新README，統一文字格式(中文)。
+ 新增程式註解(英文)。

### (109/12/19)
+ 將"節點座標"、"兩點相鄰與否"的資料隱藏起來，讓畫面不會那麼雜亂。(利用code folding)
+ 修正某些不合理路線。
+ 加上**重複執行**功能。
+ 每次重複執行會**更改線條顏色**。

### (109/12/22)
+ README增加「重點解釋」。
+ 將設定視窗大小的部分，改成直接**全螢幕**，解決每台電腦解析度不同，視窗位置會變的問題。

!!!記得存檔!!!
