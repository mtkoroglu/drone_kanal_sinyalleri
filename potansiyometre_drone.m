clear all; clc;

s = serialport('COM7', 57600); flush(s);
kanal = uint8(zeros(1,4));
i = 0; % paket numarası - her paket {'h', kanal(1), kanal(2), kanal(3), kanal(4)}
n = 4; % kanal sayısı
stopTime = 15; % saniye
tic;
while (true)
    if ( read(s, 1, 'uint8') == 'h') % paket başladı
        i = i + 1;
        zaman(i) = toc;
        for j=1:n
            kanal(j, i) = read(s, 1, 'uint8');
        end
    end
        fprintf('Paket#%i  Kanal 1 = %i  Kanal 2 = %i  Kanal 3 = %i  Kanal 4 = %i  ', ...
            i, kanal(1,i), kanal(2,i), kanal(3,i), kanal(4,i));
        fprintf('Zaman = %.2f  Bytes on buffer = %i\n', zaman(i), s.NumBytesAvailable);
    if (zaman(i) > stopTime)
        break;
    end
end
delete(s);
%%
figure(1);
hold on;
plot(zaman, kanal(1,:), 'r-');
plot(zaman, kanal(2,:), 'b-');
plot(zaman, kanal(3,:), 'g-');
plot(zaman, kanal(4,:), 'k-');
legend('kanal 1', 'kanal 2', 'kanal 3', 'kanal 4');
set(legend, 'location', 'northwest');
xlabel('zaman (s)');
ylabel('kanal sinyali');
axis([0 zaman(end) -10 265]);
grid on;
hold off;

figure(2);
subplot(2,2,1);
plot(zaman, kanal(1,:), 'r-');
xlabel('zaman (s)');
ylabel('kanal 1 sinyali');
axis([0 zaman(end) -10 315]);
grid on;
subplot(2,2,2);
plot(zaman, kanal(2,:), 'b-');
xlabel('zaman (s)');
ylabel('kanal 2 sinyali');
axis([0 zaman(end) -10 315]);
grid on;
subplot(2,2,3);
plot(zaman, kanal(3,:), 'g-');
xlabel('zaman (s)');
ylabel('kanal 3 sinyali');
axis([0 zaman(end) -10 315]);
grid on;
subplot(2,2,4);
plot(zaman, kanal(4,:), 'k-');
xlabel('zaman (s)');
ylabel('kanal 4 sinyali');
axis([0 zaman(end) -10 315]);
grid on;