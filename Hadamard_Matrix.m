clear
close all
clc

n = 7;
N = 2^(2*n);

H = hadamard(N);

figure
imagesc(H)
colormap gray
% axis image






% % HADAMARD_MATRIX_GPU - Script unificado con soporte CPU/GPU
% clear
% close all
% clc
% 
% %% Configuración inicial
% disp('=== Generador de Matrices de Hadamard con soporte GPU ===');
% 
% %% Verificar capacidades de GPU
% useGPU = false;
% if gpuDeviceCount > 0
%     try
%         gpu = gpuDevice();
%         useGPU = true;
%         disp(['GPU detectada: ' gpu.Name]);
%         disp(['Memoria total disponible: ', num2str(gpu.TotalMemory/1e9), ' GB']);
%     catch
%         warning('Error al acceder a la GPU. Usando CPU por defecto.');
%         useGPU = false;
%     end
% else
%     disp('No se detectaron GPUs compatibles. Usando CPU.');
% end
% 
% %% Entrada del usuario con validación
% while true
%     n = input('\nIngrese el orden n (entero >= 1): ');
%     if isnumeric(n) && isscalar(n) && n >= 1 && mod(n,1) == 0
%         break
%     else
%         disp('Error: n debe ser un entero positivo. Intente nuevamente.');
%     end
% end
% 
% N = 4^n;
% fprintf('\nGenerando matriz de Hadamard de orden %dx%d\n', N, N);
% 
% %% Generación de la matriz
% try
%     if useGPU
%         fprintf('Intentando generación en GPU...\n');
% 
%         % Método optimizado para GPU
%         tic;
%         H = parallel.gpu.GPUArray.ones(N, 'int8');
%         H = 2*H - 1;  % Convertir 1 a 1, 1 a -1 según necesidad
%         gpuTime = toc;
% 
%         H_cpu = gather(H); % Transferir a CPU para visualización
%     else
%         error('GPU no disponible');
%     end
% catch
%     fprintf('Usando CPU para generación...\n');
%     tic;
%     H_cpu = hadamard(N);
%     cpuTime = toc;
%     gpuTime = NaN;
% end
% 
% %% Visualización
% figure('Name', 'Matriz de Hadamard', 'NumberTitle', 'off', 'Color', 'white')
% imagesc(H_cpu)
% colormap gray
% axis image
% colorbar
% title(sprintf('Matriz de Hadamard %dx%d', N, N))
% xlabel('Columnas')
% ylabel('Filas')
% 
% %% Métricas de rendimiento
% fprintf('\n=== Métricas de rendimiento ===\n');
% if useGPU
%     fprintf('Tiempo de cálculo en GPU: %.2f ms\n', gpuTime*1000);
%     try
%         % Para versiones modernas (R2020a+)
%         memoria_usada = gpu.AvailableMemory;
%         fprintf('Memoria disponible restante: %.2f GB\n', memoria_usada/1e9);
%     catch
%         % Método compatible con versiones antiguas
%         memoria_total = gpu.TotalMemory;
%         memoria_libre = gpu.FreeMemory;
%         fprintf('Memoria usada en GPU: %.2f MB\n', (memoria_total - memoria_libre)/1e6);
%     end
% else
%     fprintf('Tiempo de cálculo en CPU: %.2f ms\n', cpuTime*1000);
% end
% 
% fprintf('Valores únicos: %d (solo contiene 1 y -1)\n', numel(unique(H_cpu)));
% disp('=================================');
