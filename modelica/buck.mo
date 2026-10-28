model buck
  parameter Modelica.Units.SI.Capacitance C(displayUnit="uF") = 250e-6;
  parameter Modelica.Units.SI.Inductance L(displayUnit="mH") = 120e-3;
  parameter Real R_L = 0.00001 "Inductor series resistance losses (Ohm)";
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-86, -72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C= C) annotation(
    Placement(transformation(origin = {34, -32}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = L) annotation(
    Placement(transformation(origin = {-32, -2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor icoil annotation(
    Placement(transformation(origin = {20, -2}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i_out annotation(
    Placement(transformation(origin = {64, -2}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(transformation(origin = {-46, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(transformation(origin = {-76, -2}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor i_in annotation(
    Placement(transformation(origin = {-106, -2}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = R_L) annotation(
    Placement(transformation(origin = {-6, -2}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput u annotation(
    Placement(transformation(origin = {-76, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput y_i_in annotation(
    Placement(transformation(origin = {-88, 22}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-74, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput y_i_coil annotation(
    Placement(transformation(origin = {38, 22}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput y_i_out annotation(
    Placement(transformation(origin = {82, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {82, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Interfaces.PositivePin buck_input annotation(
    Placement(transformation(origin = {-136, -2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin buck_gnd_2 annotation(
    Placement(transformation(origin = {112, -62}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin buck_out annotation(
    Placement(transformation(origin = {112, -2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin buck_gnd_1 annotation(
    Placement(transformation(origin = {-130, -62}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, -70}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(i_in.n, switch.p) annotation(
    Line(points = {{-96, -2}, {-86, -2}}, color = {0, 0, 255}));
  connect(switch.n, inductor.p) annotation(
    Line(points = {{-66, -2}, {-42, -2}}, color = {0, 0, 255}));
  connect(icoil.n, i_out.p) annotation(
    Line(points = {{30, -2}, {54, -2}}, color = {0, 0, 255}));
  connect(diode.n, inductor.p) annotation(
    Line(points = {{-46, -22}, {-46, -2}, {-42, -2}}, color = {0, 0, 255}));
  connect(capacitor.p, icoil.n) annotation(
    Line(points = {{34, -22}, {34, -2}, {30, -2}}, color = {0, 0, 255}));
  connect(diode.p, ground.p) annotation(
    Line(points = {{-46, -42}, {-46, -62}, {-86, -62}}, color = {0, 0, 255}));
  connect(capacitor.n, ground.p) annotation(
    Line(points = {{34, -42}, {34, -62}, {-86, -62}}, color = {0, 0, 255}));
  connect(inductor.n, resistor1.p) annotation(
    Line(points = {{-22, -2}, {-16, -2}}, color = {0, 0, 255}));
  connect(resistor1.n, icoil.p) annotation(
    Line(points = {{4, -2}, {10, -2}}, color = {0, 0, 255}));
  connect(switch.control, u) annotation(
    Line(points = {{-76, -14}, {-76, -44}}, color = {255, 0, 255}));
  connect(i_out.i, y_i_out) annotation(
    Line(points = {{64, 9}, {64, 19}, {82, 19}}, color = {0, 0, 127}));
  connect(icoil.i, y_i_coil) annotation(
    Line(points = {{20, 9}, {20, 21}, {38, 21}}, color = {0, 0, 127}));
  connect(buck_input, i_in.p) annotation(
    Line(points = {{-136, -2}, {-116, -2}}, color = {0, 0, 255}));
  connect(ground.p, buck_gnd_2) annotation(
    Line(points = {{-86, -62}, {112, -62}}, color = {0, 0, 255}));
  connect(i_out.n, buck_out) annotation(
    Line(points = {{74, -2}, {112, -2}}, color = {0, 0, 255}));
  connect(ground.p, buck_gnd_1) annotation(
    Line(points = {{-86, -62}, {-130, -62}}, color = {0, 0, 255}));
  connect(i_in.i, y_i_in) annotation(
    Line(points = {{-106, 10}, {-106, 22}, {-88, 22}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-160, 40}, {140, -80}}), graphics),
    version = "",
    uses(Modelica(version = "4.1.0")),
  Icon(graphics = {Text(origin = {-35, -80}, extent = {{-63, 20}, {63, -20}}, textString = "Buck"), Line(points = {{-100, -100}, {100, 100}, {100, 100}}, thickness = 1.5), Rectangle(lineThickness = 1.5, extent = {{-100, 100}, {100, -100}}), Text(origin = {-40, 50}, extent = {{-40, 30}, {40, -30}}, textString = "DC"), Text(origin = {40, -50}, extent = {{-40, 30}, {40, -30}}, textString = "DC"), Text(origin = {0, 8},textColor = {0, 0, 255}, extent = {{-150, 148}, {150, 108}}, textString = "%name")}));
end buck;
