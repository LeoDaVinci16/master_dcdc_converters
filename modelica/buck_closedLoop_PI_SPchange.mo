model buck_closedLoop_PI_SPchange
  buck buck1 annotation(
    Placement(transformation(origin = {0, 14}, extent = {{-26, -26}, {26, 26}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100) annotation(
    Placement(transformation(origin = {-52, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
    Placement(transformation(origin = {-84, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500) annotation(
    Placement(transformation(origin = {52, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
    Placement(transformation(origin = {82, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  control_antiwindup_PI_SPchange control_antiwindup_PI_SPchange1(Ti = 0.01, Kp = 0.5, setpoint = 60, frequency = 500)  annotation(
    Placement(transformation(origin = {54, -50}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(constantVoltage.p, buck1.buck_input) annotation(
    Line(points = {{-52, 24}, {-52, 32}, {-26, 32}}, color = {0, 0, 255}));
  connect(constantVoltage.n, buck1.buck_gnd_1) annotation(
    Line(points = {{-52, 4}, {-52, -4}, {-26, -4}}, color = {0, 0, 255}));
  connect(v_in.p, buck1.buck_input) annotation(
    Line(points = {{-84, 22}, {-84, 32}, {-26, 32}}, color = {0, 0, 255}));
  connect(v_in.n, buck1.buck_gnd_1) annotation(
    Line(points = {{-84, 2}, {-84, -4}, {-26, -4}}, color = {0, 0, 255}));
  connect(resistor.p, buck1.buck_out) annotation(
    Line(points = {{52, 24}, {52, 32}, {26, 32}}, color = {0, 0, 255}));
  connect(resistor.n, buck1.buck_gnd_2) annotation(
    Line(points = {{52, 4}, {52, -4}, {26, -4}}, color = {0, 0, 255}));
  connect(v_out.n, buck1.buck_gnd_2) annotation(
    Line(points = {{82, 4}, {82, -4}, {26, -4}}, color = {0, 0, 255}));
  connect(v_out.p, buck1.buck_out) annotation(
    Line(points = {{82, 24}, {82, 32}, {26, 32}}, color = {0, 0, 255}));
  connect(v_out.v, control_antiwindup_PI_SPchange1.measure) annotation(
    Line(points = {{94, 14}, {100, 14}, {100, -50}, {66, -50}}, color = {0, 0, 127}));
  connect(control_antiwindup_PI_SPchange1.control_output, buck1.u) annotation(
    Line(points = {{44, -50}, {0, -50}, {0, -18}}, color = {255, 0, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 0.002));
end buck_closedLoop_PI_SPchange;
