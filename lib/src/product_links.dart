enum DeclmigProductDestination { status, unsupported }

DeclmigProductDestination resolveProductLink(Uri uri) {
  const sensitiveQueryKeys = {
    'access_token',
    'code',
    'id_token',
    'refresh_token',
    'token',
  };
  final safeEnvelope = uri.scheme.toLowerCase() == 'https' &&
      uri.host.isNotEmpty &&
      uri.userInfo.isEmpty &&
      !uri.hasFragment &&
      !uri.queryParameters.keys.any(
        (key) => sensitiveQueryKeys.contains(key.toLowerCase()),
      );
  if (!safeEnvelope || uri.pathSegments.length != 2) {
    return DeclmigProductDestination.unsupported;
  }
  return uri.pathSegments.first == 'u' && uri.pathSegments.last == 'status'
      ? DeclmigProductDestination.status
      : DeclmigProductDestination.unsupported;
}
