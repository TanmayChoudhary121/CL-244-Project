

tic

 u = 7 % breakdown at u = 9 for h = 0.1
 h = 0.1; %breakdown at h = 0.7 for u = 1
    

t=[0:h:20]';
N = length(t);


x = zeros(1,N);
x(1) = 2;
y = zeros(1,N);
y(1) = 0;

h = 0.1; %Step Size



    fx = @(x,y) y;
    fy = @(x,y) u*(1-x*x)*y - 3*x;
    
    % Generating second initial value using 3RK
    k1 = [fx(x(1), y(1));
         fy(x(1), y(1))];
    k2 = [fx(x(1) + (h/2)*k1(1), y(1) + (h/2)*k1(2));
         fy(x(1) + (h/2)*k1(1), y(1) + (h/2)*k1(2))];
    k3 = [fx(x(1) - h*k1(1) + 2*h*k2(1), y(1) - h*k1(2) + 2*h*k2(2));
         fy(x(1) - h*k1(1) + 2*h*k2(1), y(1) - h*k1(2) + 2*h*k2(2))];
    x(2) = x(1) + (h/6)*(k1(1) + 4*k2(1) + k3(1));
    y(2) = y(1) + (h/6)*(k1(2) + 4*k2(2) + k3(2));
    
    % Initiating Adam-Moulton
    for i = 2:N-1
        for k=1:100
            x(i+1) = x(i) + (h/12)*(5*fx(x(i+1),y(i+1)) + 8*fx(x(i),y(i))- fx(x(i-1),y(i-1)));
            y(i+1) = y(i) + (h/12)*(5*fy(x(i+1),y(i+1)) + 8*fy(x(i),y(i))- fy(x(i-1),y(i-1)));
        end
    end

f=@(t,x0) [x0(2), u*(1-x0(1)^2)*x0(2)-3*x0(1)]';
y0=[2;0];
t= [0:0.1:20]';
[t0,x0]=ode45(f,t,y0);
  
f=@(t,x1) [x1(2), u*(1-x1(1)^2)*x1(2)-3*x1(1)]';
[t0,x1]=ode23s(f,t,y0);
hold on
plot(t,x0(:,1),'ro')
plot(t,x1(:,1),'b--')
plot(t,x,'g+')
legend('ode45','ode23s','AM3')
xlabel('Time')
title('Solution Breakdown:u=7.35,h=0.1')
hold off
timetaken=toc







