using Godot;

namespace Witchpixels.GodotOmniBuilder.TestProject;


public partial class OrbitalCamera : Node3D
{
    private CameraOrbitComponent _cameraOrbitComponent;

    public override void _Ready()
    {
        _cameraOrbitComponent = GetNode<CameraOrbitComponent>("components/CameraOrbitComponent");
    }
    
    public override void _Process(double delta)
    {
        base._Process(delta);
        _cameraOrbitComponent.Rotate(this, (float)delta);
    }
}