close all;

%% Plot of estimated velocity vs actual (in body frame)
figure("Name", "Velocities")
tiledlayout(3,1)

estim_titles = ["dX", "dY", "dZ"];
t = estim.time();

for index = 7:9
    nexttile;
    
    plot(t, estim.signals.values(:,index))
    hold on
    plot(t, states.V_body.Data(3-mod(9,index),:))
    hold off
    
    grid on
    ylabel(estim_titles(3-mod(9,index)) + " $[m/s]$",Interpreter="latex")
    legend(["Estimate", "State"], Location="best",Interpreter="latex")
end
xlabel("Time [s]",Interpreter="latex")

%% Plot of estimated position vs actual
figure("Name", "Position")
tiledlayout(3,1)

estim_titles = ["X", "Y", "Z"];
t = estim.time();

for index = 1:3
    nexttile;
    
    plot(t, estim.signals.values(:,index))
    hold on
    plot(t, states.X_ned.Data(index,:)-states.X_ned.Data(index,1,1))
    hold off
    
    grid on
    ylabel(estim_titles(index) + " $[m]$",Interpreter="latex")
    legend(["Estimate", "State"], Location="best",Interpreter="latex")
end
xlabel("Time [s]",Interpreter="latex")

%% Plot of estimation errors
figure("Name", "Errors")
tiledlayout(3,2)

estim_titles = ["X", "Y", "Z", "dX", "dY", "dZ"];
t = estim.time();

datpos = [1:3, 7:9];

for index = 1:6
    nexttile;
    
    plot(t, estim.signals.values(:,index))
    hold on
    if index < 4
        err = states.X_ned.Data(index,:)-states.X_ned.Data(index,1,1)-estim.signals.values(:,index);
    else
        err = states.V_body.Data(3-index,:)-estim.signals.values(:,3+index);
    end
    
    plot(t, err)
    hold off
    
    grid on
%     ylabel(estim_titles(index) + " $[m]$",Interpreter="latex")
%     legend(["Estimate", "State"], Location="best",Interpreter="latex")
end
% xlabel("Time [s]",Interpreter="latex")