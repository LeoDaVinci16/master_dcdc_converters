model buck_example
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 500)  annotation(
    Placement(transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C(displayUnit = "uF") = 2.5e-4)  annotation(
    Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L(displayUnit = "mH") = 0.12)  annotation(
    Placement(transformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor v_out annotation(
    Placement(transformation(origin = {134, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor icoil annotation(
    Placement(transformation(origin = {8, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 100)  annotation(
    Placement(transformation(origin = {-130, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i_out annotation(
    Placement(transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(width = 60, period (displayUnit = "ms")= 0.001)  annotation(
    Placement(transformation(origin = {-134, 72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i_in annotation(
    Placement(transformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor v_in annotation(
    Placement(transformation(origin = {-162, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(constantVoltage.p, i_in.p) annotation(
    Line(points = {{-130, 20}, {-130, 40}, {-120, 40}}, color = {0, 0, 255}));
  connect(i_in.n, switch.p) annotation(
    Line(points = {{-100, 40}, {-90, 40}}, color = {0, 0, 255}));
  connect(switch.n, inductor.p) annotation(
    Line(points = {{-70, 40}, {-40, 40}}, color = {0, 0, 255}));
  connect(inductor.n, icoil.p) annotation(
    Line(points = {{-20, 40}, {-2, 40}}, color = {0, 0, 255}));
  connect(icoil.n, i_out.p) annotation(
    Line(points = {{18, 40}, {50, 40}}, color = {0, 0, 255}));
  connect(i_out.n, resistor.p) annotation(
    Line(points = {{70, 40}, {90, 40}, {90, 20}}, color = {0, 0, 255}));
  connect(v_out.p, i_out.n) annotation(
    Line(points = {{134, 18}, {134, 40}, {70, 40}}, color = {0, 0, 255}));
  connect(constantVoltage.n, ground.p) annotation(
    Line(points = {{-130, 0}, {-130, -20}, {-90, -20}}, color = {0, 0, 255}));
  connect(ground.p, v_out.n) annotation(
    Line(points = {{-90, -20}, {134, -20}, {134, -2}}, color = {0, 0, 255}));
  connect(diode.n, inductor.p) annotation(
    Line(points = {{-50, 20}, {-50, 40}, {-40, 40}}, color = {0, 0, 255}));
  connect(capacitor.p, icoil.n) annotation(
    Line(points = {{30, 20}, {30, 40}, {18, 40}}, color = {0, 0, 255}));
  connect(diode.p, ground.p) annotation(
    Line(points = {{-50, 0}, {-50, -20}, {-90, -20}}, color = {0, 0, 255}));
  connect(capacitor.n, ground.p) annotation(
    Line(points = {{30, 0}, {30, -20}, {-90, -20}}, color = {0, 0, 255}));
  connect(resistor.n, ground.p) annotation(
    Line(points = {{90, 0}, {90, -20}, {-90, -20}}, color = {0, 0, 255}));
  connect(v_in.p, i_in.p) annotation(
    Line(points = {{-162, 20}, {-162, 40}, {-120, 40}}, color = {0, 0, 255}));
  connect(v_in.n, ground.p) annotation(
    Line(points = {{-162, 0}, {-162, -20}, {-90, -20}}, color = {0, 0, 255}));
  connect(booleanPulse.y, switch.control) annotation(
    Line(points = {{-122, 72}, {-80, 72}, {-80, 52}}, color = {255, 0, 255}));

annotation(
    uses(Modelica(version = "4.1.0")),
  Diagram(coordinateSystem(extent = {{-180, 100}, {160, -40}})),
  version = "");
end buck_example;
