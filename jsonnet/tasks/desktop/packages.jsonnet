local S = import 'split.jsonnet';

// GUI packages — parent desktop/main already gates on gui_workstations.
S.System([
  {
    name: 'Install gui packages',
    package: {
      name: '{{ gui_packages }}',
      state: 'present',
    },
  },
])
