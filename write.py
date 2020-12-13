# 讀取檔案
f1 = open("node.txt", 'r')
text = f1.readlines()  # 以list的方式儲存
cnt = 0
for i in range(83):
    text[i] = text[i].split('\n')[0]  # 去掉跳行號
    t = text[i].split(' ')
    for t1 in t[1:]:
        print("s(", i+1, ",", int(t1), ")=1;", sep='', end=' ')
        cnt = cnt+1
        if cnt == 5:
            print()
            cnt = 0

f1.close()
