%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP108
% Project Title: Solving Vehicle Routing Problem using Simulated Annealing
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function model=CreateRandomModel(I,J)

    rmin=10;
    rmax=25;
    r=randi([rmin rmax],1,I);
    
    TotalDemand=sum(r);
    cmean=TotalDemand/J;
    cmin=round(cmean);
    cmax=round(1.5*cmean);
    %c=randi([cmin cmax],1,J);
    c=cmax*ones(1,J)
    
    xmin=0;
    xmax=200;
    
    ymin=0;
    ymax=100;
    
    x=randi([xmin xmax],1,I);
    y=randi([ymin ymax],1,I);
    
    alpha_x=0.1;
    xm=(xmin+xmax)/2;
    dx=xmax-xmin;
    x0min=round(xm-alpha_x*dx);
    x0max=round(xm+alpha_x*dx);
    
    alpha_y=0.1;
    ym=(ymin+ymax)/2;
    dy=ymax-ymin;
    y0min=round(ym-alpha_y*dy);
    y0max=round(ym+alpha_y*dy);
    
    x0=randi([x0min x0max]);
    y0=randi([y0min y0max]);
    
    d=zeros(I,I);
    d0=zeros(1,I);
    for i=1:I
        for i2=i+1:I
            d(i,i2)=sqrt((x(i)-x(i2))^2+(y(i)-y(i2))^2);
            d(i2,i)=d(i,i2);
        end
        
        d0(i)=sqrt((x(i)-x0)^2+(y(i)-y0)^2);
    end
    
    eta=0.5;
    
    model.I=I;
    model.J=J;
    model.r=r;
    model.c=c;
    model.xmin=xmin;
    model.xmax=xmax;
    model.ymin=ymin;
    model.ymax=ymax;
    model.x=x;
    model.y=y;
    model.x0=x0;
    model.y0=y0;
    model.d=d;
    model.d0=d0;
    model.eta=eta;

end