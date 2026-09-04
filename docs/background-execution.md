# Background execution decision

Background execution is **not applicable** to the current Declarative
Migrations Flutter application on Android or iOS. This client only renders an
on-demand connection-status surface. It has no durable local migration queue,
sensor, location, media, Bluetooth, push-processing, or periodic maintenance
event that the Flutter process must own.

Migration planning and execution are server/CLI responsibilities. Adding an
Android foreground service, WorkManager task, iOS background fetch, silent
push, wake lock, or background permission here would duplicate those
boundaries, consume battery, and risk continuing a database operation without
the user's active review.

The repository currently contains Android and web runners only. iOS and
desktop background work is structurally unavailable until those runners exist;
an eventual iOS UI must keep the same on-demand behavior unless a reviewed
product event demonstrates otherwise.

Cross-device/offline data remains blocked until an approved immutable
`opto-sync` Dart artifact can be resolved through `zed-pkg`, tracked by
[`opto-sync-clients#104`](https://github.com/opto-sync/opto-sync-clients/issues/104).
The app must not add direct Git/path wiring or a competing sync queue while
that release gate is open.
