# Project 6
+ 在交大地圖可行走的道路上點任一兩點，找出兩點間的最短路徑，並且以平滑曲線顯示。
## 檔案:
+ *編輯過照片 \*4*
*(原圖網址: http://www.ltc.tw/CN/event/map/mapNCTU.htm)*
+ *project6.m*
+ *node.txt (additional)*
+ *write.py (additional)*
## 使用方法:

## 主要目標: (由低到高)
1. 在此圖上可行走之主要道路上任意點兩點，可找出一條路徑通過，且此路徑在可行走之主要道路上。
2. 路徑上的節點不重複，且此路徑必須為最短路徑。
3. 找出高次多項式逼近路線，使其顯示出來是一條平滑曲線，而非點到點的折線圖。
***
4. 增加一些功能，可能有: 重複執行、一開始顯示可行走的地方、...。
5. 若原地圖有比例尺，可將各邊長度轉換成實際距離，給定一速率並大概推算出，在等速率的狀況下，多久時間內可以抵達。
6. 加入坡度、尖峰離峰時段...等參數當成各邊上的cost，並找出cost最小的路徑，即是更貼近真實情況之最佳路徑。
7. 讓使用者可以選任意n點，在無順序前後的前提下，規劃出一條最佳路徑，以最高效率通過所有點。
8. (待想)
## 實踐方法:
1. 將可行走之主要道路區分成眾多節點和邊，形成一張**simple graph**，並記錄「各編號節點的座標」、「各點距離」。
2. 利用**Dijkstra演算法**，找出一條最短路經。
3. 利用matlab內**polyfit**函式，找出一高次多項次逼近路線，畫出一條「平滑」曲線。
## 作業歷程:
### (109/12/11)
+ 因為這張交大地圖格式簡潔好看，但年代久遠，所以決定做翻新工作，包括將南大門、延三舍、科三、公六等建物補上，並試著簡化道路，同時增加精確度，使其貼近現在學生常走路線。 (~2hr)
+ 將地圖可行走之主要道路分成79個節點，將其編號，並且用**ginput**的方法手動紀錄各節點座標。(1hr)
+ 手動調查各節點相鄰狀況，若有相鄰，則該邊設為1，否則設為零。用79*79的**稀疏矩陣s**紀錄。(1hr)
#### 遭遇問題
1. 用小畫家編輯存檔後畫質變差，但因這次方法實踐和顏色較無關係，所以影響不大。\
   推測可能是因為原圖是.gif檔，再次用.gif檔另存新檔時，在圖片壓縮時發生了錯誤。
2. 手動紀錄數值極為耗時，幸好同學提醒，先建立邊與邊對應關係，用.txt檔儲存，再用python造出sparse的資料，整個貼到matlab上，整個過程快上許多，且容易除錯，修改點數。

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

!!!記得存檔!!!
