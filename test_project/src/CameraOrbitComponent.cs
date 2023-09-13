using Godot;

namespace Witchpixels.GodotOmniBuilder.TestProject;

[GlobalClass]
public partial class CameraOrbitComponent : Node
{
    [Export] private float _degreesPerSecond;

    public void Rotate(Node3D orbitalRoot, float delta)
    {
        orbitalRoot.Rotate(Vector3.Up, _degreesPerSecond * delta);
    }
}