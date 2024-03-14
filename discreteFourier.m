% Prepare the environment
clc
close all
clear all

% 1. Creating Discrete Signal
while true
    sys = input('Choose input signal type:\n1.Continuous\n2.Discrete\n');
    if sys == 1
        % a. Converting continuous signal to discrete
        xn = ip_continuous();
        N = length(xn);
        break;
    elseif sys == 2
        % b. Using discrete values
        [xn,N] = ip_discrete();
        break;
    else
        clc
        disp('Error: Invalid input. Please enter choice number')
    end 
end

% 2. Applying DFT to input signal
[Xk] = calcdft(xn,N);

% 3. Plotting DFT Magnitude and phase
mgXk = abs(Xk); 
phaseXk = angle(Xk); 
k = 0:N-1; 

figure('Name','Discrete Fourier Transform','NumberTitle','off');
subplot (2,1,1); 
stem(k, mgXk, 'r'); 
title ('DFT sequence: '); 
xlabel('Frequency'); 
ylabel('Magnitude'); 
subplot(2,1,2); 
stem(k, phaseXk, 'r'); 
title('Phase of the DFT sequence'); 
xlabel('Frequency'); 
ylabel('Phase');

% Function Declarations
function[xn] = ip_continuous()
    t = 0:1:10;
    t2 = 0:0.001:10;
    iptype = lower(input('Input desired function: \n(Sine, Cosine, Ramp, Exponential)\n','s'));
    disp('Input desired parameters:');
    f = input('Frequency = ');
    A = input('Amplitude = ');
    switch iptype
        case 'sine'
            xn = A*sin(2*pi*f*t);
            xn_cont = A*sin(2*pi*f*t2);
        case 'cosine'
            xn = A*cos(2*pi*f*t);
            xn_cont = A*cos(2*pi*f*t2);
        case 'ramp'
            xn = A*t;
            xn_cont = A*t2;
        case 'exponential'
            xn = A*exp(f*t);
            xn_cont = A*exp(f*t2);
        otherwise
            error('Invalid Function')
    end
    figure('Name','Predefined Input Signal','NumberTitle','off')
    hold on;
    plot(t2, xn_cont, 'r--')
    stem(t, xn, 'k*')
    hold off;
    title('Discrete Sampled Signal')
    xlabel('Time')
    ylabel('Amplitude')
end

function[xn,N] = ip_discrete()
    while true
        str = input('Input sequence: ','s');
        nums = strsplit(str);
        xn = str2double(nums);
        N = length(xn);
        if length(xn) > 11
            disp("Error: Current system doesn't support more than 11 sample points")
        else
            break;
        end
    end
    figure('Name','Predefined Input Signal','NumberTitle','off')
    stem(0:length(xn)-1, xn, 'k*')
    title('Discrete Sampled Signal')
    xlabel('Time')
    ylabel('Amplitude')
end

function[Xk] = calcdft(xn,N)
    while true
        L = length(xn);
        if(N<L) 
            disp('Error: N must be greater than or equal to L!!') 
        else
            break;
        end
    end
    x1 = [xn, zeros(1,N-L)];
    for k = 0:1:N-1
        for n = 0:1:N-1
            p = exp(-1i*2*pi*n*k/N);
            W(k+1,n+1) = p;
        end
    end 
    Xk=W*(x1.');
end