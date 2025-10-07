% Define the PTZ camera and target initial positions
ptz_position = [5 5 5];
target_position = [0 0 0];

% Define the target trajectory (a helix for this example)
theta = linspace(0, 4*pi, 100); % theta for helix
radius = 3;
z_step = linspace(0, 10, 100); % height increase for helix
target_trajectory = [radius*cos(theta) + 5; radius*sin(theta) + 5; z_step]';

figure;
hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');
xlim([0 10]); ylim([0 10]); zlim([0 10]);
grid on;
view(3); % 3D view

% Create initial plot objects for PTZ and target
h_ptz = plot3(ptz_position(1), ptz_position(2), ptz_position(3), 'bo', 'MarkerSize', 10);
h_target = plot3(target_position(1), target_position(2), target_position(3), 'ro', 'MarkerSize', 8);
h_line = plot3([ptz_position(1), target_position(1)], ...
               [ptz_position(2), target_position(2)], ...
               [ptz_position(3), target_position(3)], '-k');

% Define image plane for the PTZ camera (assuming 4x4 dimensions)
plane_z = ptz_position(3) + 1; % 1 unit in front of the camera
image_x = [ptz_position(1)-2, ptz_position(1)+2, ptz_position(1)+2, ptz_position(1)-2];
image_y = [ptz_position(2)-2, ptz_position(2)-2, ptz_position(2)+2, ptz_position(2)+2];
image_z = [plane_z, plane_z, plane_z, plane_z];

% Plot the image plane (in blue color)
fill3(image_x, image_y, image_z, 'b', 'FaceAlpha', 0.2);

% Loop for the moving target
for t = 1:length(target_trajectory)
    % Update target position
    target_position = target_trajectory(t,:);
    
    % Project target position onto the image plane
    projected_point = [target_position(1), target_position(2), plane_z];
    
    % Check if the projected point lies within the image boundaries
    inImage = inpolygon(projected_point(1), projected_point(2), image_x, image_y);
    if inImage
        disp('Target is within the image!');
    else
        disp('Target is outside the image.');
    end
    
    % Visualize the projection as a green dot
    h_proj = plot3(projected_point(1), projected_point(2), projected_point(3), 'go', 'MarkerSize', 6);
    
    % Update PTZ camera focus
    set(h_target, 'XData', target_position(1), 'YData', target_position(2), 'ZData', target_position(3));
    set(h_line, 'XData', [ptz_position(1), target_position(1)], ...
                'YData', [ptz_position(2), target_position(2)], ...
                'ZData', [ptz_position(3), target_position(3)]);
    
    drawnow; % Update the plot
    if exist('h_proj', 'var')
        delete(h_proj); % Remove the previous projection point for clarity
    end
    pause(0.05); % Wait for visualization
end
