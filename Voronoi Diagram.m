%读入中国地图
map_path = shaperead('C:/Users/voidpassion/Pictures/SVM/shP/china_basic_map/bou2_4l.shp');

%给定范围画图并投影成Miller投影，并将坐标控制在一定区域内
map_X= [map_path(:).X];
map_Y = [map_path(:).Y];
m_proj('Miller','lon',[70, 137],'lat',[15,55]) 

m_plot(map_X,map_Y) 
m_grid;
hold on;
           
%45个站点的经纬度，并将数字坐标换成经纬度坐标
filename = 'C:/Users/voidpassion/Documents/China.xls';
lonstation=xlsread(filename,'F1:F45');
latstation=xlsread(filename,'E1:E45');
%lonstation=[121.55,126.46,88.05,81.20,89.12,82.57,75.59,79.56,90.51,101.04,97.02,103.06,97.22,103.53,110.26,114,105.45,109.42,118.04,122.16,116.17,121.38,91.08,89.05,92.26,98.13,104.55,100,99.06,104.01,94.28,102.15,102.41,107.08,109.02,114.08,106.29,112.52,106.43,118.48,117.14,121.26,120.1,116.39,114.06];
%latstation=[48.46,45.45,47.44,43.57,42.56,41.43,39.28,37.08,38.15,41.57,40.16,38.46,37.22,36.03,41.42,41.54,39.47,38.14,43.36,43.36,39.56,38.54,29.4,27.44,34.13,34.55,33.24,31.37,30,30.4,29.34,26.39,25.01,34.21,32.43,30.37,29.31,28.14,26.35,32,31.52,31.1,30.14,27.35,22.33];

%将经纬度的数字坐标转换成投影坐标（相当于做一个基变换后的坐标）
[xstation,ystation]=m_ll2xy(lonstation,latstation);
%加边界【目前不用】
%v=[15 70;15 137;55 137;55 70];
%P=polytope(v);
%Options.P=P;

%画出voronoi图，将线和生成点都画成蓝色
%mpt_voronoi([x' y'],Options);
[vx,vy]=voronoi(xstation,ystation);
plot(xstation,ystation,'b+',vx,vy,'b-');

%画出voronoi工具，暂时不用
%v=[0 0;0 100;60 100;60 0];
%P=polytope(v);
%Options.pbound=P;
%mpt_voronoi([x',y'],'bound',P);

%输入想测地点的经纬度
latpredict=input('please input the latitude of the station:');
lonpredict=input('please input the lontitude of the station:');
[xpredict,ypredict]=m_ll2xy(lonpredict,latpredict);
hold on
%将该待预测地点在图中用黑色圆圈标出
plot(xpredict,ypredict,'ko');

%找出离该待预测地点最近的站点
s1=power(latpredict-latstation(),2)+power(lonpredict-lonstation(),2);
a1=find(s1==min(s1));
x1=lonstation(a1);
y1=latstation(a1);
fprintf('the coordinate is %d %d\n', x1,y1);
fprintf('the location of this station is %d\n',a1);

%给该最近的风站做标记，红色圆圈
hold on;
plot(xstation(a1),ystation(a1),'ro');
hold on;

%获得该最近风站的相邻凸包是哪些，其中v表示顶点数组，c表示元胞数组
[v,c]=voronoin([xstation';ystation']');
%fprintf('各顶点坐标为：%d %d\n',[(v(c{a},1))'; (v(c{a},2))']);
Apt=[(v(c{a1},1))'; (v(c{a1},2))'];
fprintf('各顶点坐标为：%d %d\n',Apt);
plot(Apt(1,:),Apt(2,:),'*','MarkerFaceColor','r');
hold on;
[M,N]=size(Apt);
fprintf('%d %d\n',M,N);

%求出45个站点中与最近风站相邻的站点
nearlon=[];
nearlat=[];
label=[];
k=0;
epsilon=0.00000001;
for i=1:N
    if Apt(1,i)<=90 && Apt(2,i)<=180
        r1=power(Apt(1,i)-xstation(a1),2)+power(Apt(2,i)-ystation(a1),2);
        for j=1:45
            r2=power(Apt(1,i)-xstation(j),2)+power(Apt(2,i)-ystation(j),2);
            if abs(r1-r2)<epsilon && (j~=a1)
                k=k+1;
                label(k)=j;
                nearlon(k)=lonstation(j);
                nearlat(k)=latstation(j);
            end
        end
    end
end

%删除重复项并用绿色实心圆表示相邻的风站
label=unique(label)
number=length(label);
hold on;
[xnear,ynear]=m_ll2xy(nearlon,nearlat);
plot(xnear,ynear,'go','MarkerFaceColor','g');
hold on;

%找出相邻元胞中最远的点
s2=power(xstation(a1)-xnear(),2)+power(ystation(a1)-ynear(),2);
a2=find(s2==max(s2));
x2=lonstation(a2);
y2=latstation(a2);
fprintf('the coordinate is %d %d\n', x2,y2);
fprintf('the location of this station is %d\n',a2);
plot(xnear(a2),ynear(a2),'ro');

%将该元胞内所有的风站都囊括进来
label2=[];
xcircle=[];
ycircle=[];
k1=0;
for i=1:45
        d1=power(xstation(a1)-xstation(i),2)+power(ystation(a1)-ystation(i),2);
        max(s2);
        if d1<=max(s2)&&d1>=0.00000001
            k1=k1+1;
            label2(k1)=i;
            xcircle(k1)=lonstation(i);
            ycircle(k1)=latstation(i);
        end
end

label2=unique(label2)
number2=length(label2);

label3=[];
k2=0;
x3circle=[];
y3circle=[];
for i=1:number2
    k3=0;
    for j=1:number
        if abs(label(j)-label2(i))<epsilon
            k3=1;
        end 
    end
    
    if k3==0
       k2=k2+1;
       label3(k2)=label2(i);
       x3circle(k1)=xcircle(i);
       y3circle(k1)=ycircle(i);
    end
            
end
            
hold on;
[x3circle1,y3circle1]=m_ll2xy(x3circle,y3circle);
plot(x3circle1,y3circle1,'bo','MarkerFaceColor','b');
hold on;




