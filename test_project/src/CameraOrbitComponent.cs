using Godot;

namespace Witchpixels.GodotOmniBuilder.TestProject;

[GlobalClass]
public partial class CameraOrbitComponent : Node
{
    [Export] private float _degreesPerSecond;
    [Export] private Node3D _orbitalRoot;
    
    public override void _Process(double delta)
    {
        base._Process(delta);
        _orbitalRoot.RotateY(_degreesPerSecond * (float)delta);
    }
}