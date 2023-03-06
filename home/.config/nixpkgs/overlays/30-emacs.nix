self: super:
rec {
  emacs = super.emacs.override {
    withGTK3 = true;
    withGTK2 = false;
    withXwidgets = true;
  }
}
