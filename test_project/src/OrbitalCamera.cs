using Godot;

namespace Witchpixels.GodotOmniBuilder.TestProject;


public partial class OrbitalCamera : Node3D
{
    [Export]
    public CameraOrbitComponent CameraOrbitComponent { get; set; }

    public override void _Process(double delta)
    {
        base._Process(delta);
        CameraOrbitComponent.Rotate(this, (float)delta);
    }
}