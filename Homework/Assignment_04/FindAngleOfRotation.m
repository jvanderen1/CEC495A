%% FindAngleOfRotation

function angle = FindAngleOfRotation(I)
    [H, theta, rho] = hough(I);

    P = houghpeaks(H, 1);
    lines = houghlines(I, theta, rho, P);

    angle = 90 + lines(1).theta;
end