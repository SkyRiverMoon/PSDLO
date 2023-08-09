clc
clear
% echoudp("off")
% echoudp("on",4040)
global Index Individual
Index=1;

u = udpport("datagram","LocalPort",3031);
disp("Open port 3031")
disp("Receiving Python data ...")
configureCallback(u,"datagram",1,@readUDPData)
% write(u,1:30,"localhost",4040)
while(1)
    pause(0.1)
end

function readUDPData(src,~)
    src.UserData = src.UserData + 1;
    data = read(src,1,"uint8");
    x=str2num(char(data.Data));
    disp("Receive: ")
    disp(x)
    disp("COMSOL starts the calculation ...")
    m=Model(x);
    disp("Send COMSOL results to Python...")
    disp(m)
    write(src,m,"double","localhost",3030)
end
