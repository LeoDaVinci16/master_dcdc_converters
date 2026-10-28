model control_antiwindup_PI
  parameter Real Ti = 1 "Time Constant (Ti>0 required)"; 
  parameter Real Kp = 1 "Proportional gain";
  parameter Modelica.Units.SI.Frequency frequency = 10000
  "Switching frequency";
  parameter Modelica.Units.SI.Time period = 1/frequency;
  parameter Real setpoint = 1 "Setpoint of the controler";
  Modelica.Blocks.Interfaces.RealInput measure annotation(
    Placement(transformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Sources.SawTooth sawTooth(period = period)  annotation(
    Placement(transformation(origin = {-10, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.Greater greater annotation(
    Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanOutput control_output annotation(
    Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const(k = setpoint)  annotation(
    Placement(transformation(origin = {-66, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LimPID PID(k = Kp, Ti = Ti, yMax = 1, yMin = 0, controllerType = Modelica.Blocks.Types.SimpleController.PI, y_start = 0.6)  annotation(
    Placement(transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(sawTooth.y, greater.u2) annotation(
    Line(points = {{2, -50}, {12, -50}, {12, -8}, {28, -8}}, color = {0, 0, 127}));
  connect(greater.y, control_output) annotation(
    Line(points = {{52, 0}, {90, 0}}, color = {255, 0, 255}));
  connect(PID.y, greater.u1) annotation(
    Line(points = {{-5, 0}, {28, 0}}, color = {0, 0, 127}));
  connect(PID.u_m, measure) annotation(
    Line(points = {{-16, -12}, {-16, -30}, {-100, -30}}, color = {0, 0, 127}));
  connect(const.y, PID.u_s) annotation(
    Line(points = {{-55, 0}, {-28, 0}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.1.0")),
  Icon(graphics = {Rectangle(lineColor = {255, 0, 255}, lineThickness = 3, extent = {{-100, 100}, {100, -100}}), Text(textColor = {255, 0, 255}, extent = {{-100, 100}, {100, -100}}, textString = "PI*"), Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 148}, {150, 108}}, textString = "%name")}),
  Diagram(graphics),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end control_antiwindup_PI;
