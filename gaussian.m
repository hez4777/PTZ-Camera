% Define grid size
N = 100;
[x, y] = meshgrid(linspace(-1, 1, N), linspace(-1, 1, N));

% Calculate distance from center
r = sqrt(x.^2 + y.^2);

% Define Gaussian function
sigma = 0.5; % Adjust this value to change the spread of the Gaussian
p = exp(-r.^2 / (2 * sigma^2));

% Normalize to have values between 0.5 and 1
%p = 0.5 + 0.5 * p;

% Plot 3D surface
surf(x, y, p);
colorbar;
title('3D Gaussian Distribution');
xlabel('x');
ylabel('y');
zlabel('Probability');
axis equal;
shading interp; % Smooth shading

%%
% Define grid size
N = 100;
[x, y] = meshgrid(linspace(-1, 1, N), linspace(-1, 1, N));

% Original Gaussian function
sigma = 0.5;
p_original = 0.5 + 0.5 * exp(- (x.^2 + y.^2) / (2 * sigma^2));

% Introduce Gaussian noise and evaluate the function
noise_levels = [0.01, 0.05, 0.1]; % Different standard deviations for noise
p_noisy = zeros(N, N, length(noise_levels));

for i = 1:length(noise_levels)
    epsilon_x = noise_levels(i) * randn(N, N);
    epsilon_y = noise_levels(i) * randn(N, N);
    p_noisy(:,:,i) = 0.5 + 0.5 * exp(- ((x+epsilon_x).^2 + (y+epsilon_y).^2) / (2 * sigma^2));
end

% Plot original and noisy functions
figure;
subplot(2,2,1);
imagesc(p_original); colorbar; title('Original');
for i = 1:length(noise_levels)
    subplot(2,2,i+1);
    imagesc(p_noisy(:,:,i)); colorbar; title(['Noise \sigma = ', num2str(noise_levels(i))]);
end
