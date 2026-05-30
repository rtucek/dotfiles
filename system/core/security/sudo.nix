{
  # Switch to sudo-rs
  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  # Limit to %wheel group
  security.sudo-rs.execWheelOnly = true;

  # Demand passwords
  security.sudo-rs.wheelNeedsPassword = true;
}
