function [H_LC, P, total_cost, RMSE] = optimize4PointsLie(opt, X, Y, intrinsic, display)
    if ~exist('display', 'var')
        display = 0;
    end
    
    R_v = optimvar('R_v', 1, 3); % 1x3
    T_v = optimvar('T_v', 1, 3);
    prob = optimproblem;
    
    f = fcn2optimexpr(@cost4PointsLie, R_v, T_v, X, Y, intrinsic);
    prob.Objective = f;
    

    R = rotx(opt.rpy_init(1)) * roty(opt.rpy_init(2)) * rotz(opt.rpy_init(3));
    init_Rv = Log_SO3(R);
    x0.R_v = init_Rv;
    x0.T_v = opt.T_init;

    cost_init = cost4PointsLie(x0.R_v, x0.T_v, X, Y, intrinsic)
    options = optimoptions('fmincon', 'MaxIter',5e12, 'TolX', 1e-12, ...
        'Display','off', 'FunctionTolerance', 1e-12, ...
        'MaxFunctionEvaluations', 5e12, 'OptimalityTolerance', 1e-12);
    
    [sol, fval, ~, ~] = solve(prob, x0, 'Options', options);
    H_LC = eye(4);
    H_LC(1:3, 1:3) = Exp_SO3(sol.R_v);
    H_LC(1:3, 4) = sol.T_v';
    P = intrinsic * [eye(3) zeros(3,1)] * H_LC;

    total_cost = fval;
    RMSE = sqrt(fval/size(Y,2));
end