model buck_closedLoop
  buck buck1 annotation(
    Placement(transformation(origin = {28, -14}, extent = {{-26, -26}, {26, 26}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100) annotation(
    Placement(transformation(origin = {-24, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
    Placement(transformation(origin = {-56, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500)  annotation(
    Placement(transformation(origin = {80, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
    Placement(transformation(origin = {110, -14}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  control_antiwindup control_antiwindup1(Kp = 0.05, setpoint = 40, Ti = 0.01, frequency = 500)  annotation(
    Placement(transformation(origin = {52, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  connect(constantVoltage.p, buck1.buck_input) annotation(
    Line(points = {{-24, -4}, {-24, 4}, {2, 4}}, color = {0, 0, 255}));
  connect(constantVoltage.n, buck1.buck_gnd_1) annotation(
    Line(points = {{-24, -24}, {-24, -32}, {2, -32}}, color = {0, 0, 255}));
  connect(v_in.p, buck1.buck_input) annotation(
    Line(points = {{-56, -6}, {-56, 4}, {2, 4}}, color = {0, 0, 255}));
  connect(v_in.n, buck1.buck_gnd_1) annotation(
    Line(points = {{-56, -26}, {-56, -32}, {2, -32}}, color = {0, 0, 255}));
  connect(resistor.p, buck1.buck_out) annotation(
    Line(points = {{80, -4}, {80, 4}, {54, 4}}, color = {0, 0, 255}));
  connect(resistor.n, buck1.buck_gnd_2) annotation(
    Line(points = {{80, -24}, {80, -32}, {54, -32}}, color = {0, 0, 255}));
  connect(v_out.n, buck1.buck_gnd_2) annotation(
    Line(points = {{110, -24}, {110, -32}, {54, -32}}, color = {0, 0, 255}));
  connect(v_out.p, buck1.buck_out) annotation(
    Line(points = {{110, -4}, {110, 4}, {54, 4}}, color = {0, 0, 255}));
  connect(v_out.v, control_antiwindup1.measure) annotation(
    Line(points = {{122, -14}, {126, -14}, {126, -78}, {64, -78}}, color = {0, 0, 127}));
  connect(buck1.u, control_antiwindup1.control_output) annotation(
    Line(points = {{28, -45.2}, {28, -78.2}, {42, -78.2}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.1.0")),
  experiment(StartTime = 0, StopTime = 0.5, Tolerance = 1e-06, Interval = 0.001),
  Diagram(coordinateSystem(extent = {{-140, 60}, {140, -120}})),
  version = "");
end buck_closedLoop;
