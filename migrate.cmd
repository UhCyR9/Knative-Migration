@echo off

set KUBECONFIG_SOURCE=%USERPROFILE%\.kube\source.yml
set KUBECONFIG_DESTINATION=%USERPROFILE%\.kube\dest.yml

:loop
echo Migracja z source do destination...

rem Migracja z source do destination
kn migration migrate --namespace default --destination-namespace default --kubeconfig %KUBECONFIG_SOURCE% --destination-kubeconfig %KUBECONFIG_DESTINATION% --force --delete

echo Migracja z source do destination zakończona.

rem Oczekiwanie 3 minut
timeout /T 180 /NOBREAK

echo Migracja z destination do source...

rem Migracja z destination do source
kn migration migrate --namespace default --destination-namespace default --kubeconfig %KUBECONFIG_DESTINATION% --destination-kubeconfig %KUBECONFIG_SOURCE% --force --delete

echo Migracja z destination do source zakończona.

rem Oczekiwanie 3 minut
timeout /T 180 /NOBREAK

goto loop
