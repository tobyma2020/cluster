function [  ] = circle( x,y,r )
%这个函数是用来画二维圆圈的，输入参数为圆心坐标和半径，输出为图形
%这里我将其命名为circle，你也可以自己调用。
%Copyright@西楚霸王1990

rectangle('Position',[x-r,y-r,2*r,2*r],'Curvature',[1,1],'edgecolor','r'),axis equal
%为了修饰曲线的颜色，宽度，圆盘填充颜色等，可以设置其他参数等，例如：
%'edgecolor','b' ，其中edgecolor表示边框颜色，后面的b是颜色参数值；
%'facecolor','r' ，其中facecolor表示内部填充颜色，后面的r是颜色参数值。

end

