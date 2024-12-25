function hogFeatures = extractHOGFeaturesCustom(image, cellSize)
    % 手动实现 HOG 特征提取
    % 输入:
    %   image - 灰度图像
    %   cellSize - 每个单元格的大小 (如 [8, 8])
    % 输出:
    %   hogFeatures - HOG 特征向量

    % 默认单元格大小
    if nargin < 2
        cellSize = [8, 8];
    end

    % 转换为灰度图
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % 梯度计算
    [Gx, Gy] = imgradientxy(double(image));
    [magnitude, angle] = imgradient(Gx, Gy);

    % 将角度限制在 [0, 180)
    angle = mod(angle, 180);

    % 图像大小
    [rows, cols] = size(image);
    numBins = 9; % 梯度方向分为 9 个 bin
    binEdges = linspace(0, 180, numBins + 1);

    % 初始化 HOG 特征向量
    numCellsX = floor(cols / cellSize(2));
    numCellsY = floor(rows / cellSize(1));
    hogFeatures = zeros(numCellsY * numCellsX * numBins, 1);

    % 遍历每个单元格
    idx = 1;
    for i = 1:numCellsY
        for j = 1:numCellsX
            % 当前单元格的像素范围
            rowStart = (i-1) * cellSize(1) + 1;
            rowEnd = i * cellSize(1);
            colStart = (j-1) * cellSize(2) + 1;
            colEnd = j * cellSize(2);

            % 提取单元格的梯度大小和方向
            cellMagnitude = magnitude(rowStart:rowEnd, colStart:colEnd);
            cellAngle = angle(rowStart:rowEnd, colStart:colEnd);

            % 计算单元格的直方图
            cellHist = histcounts(cellAngle(:), binEdges, ...
                                  'Weights', cellMagnitude(:), ...
                                  'Normalization', 'none');
            % 存储特征
            hogFeatures(idx:idx+numBins-1) = cellHist(:);
            idx = idx + numBins;
        end
    end

    % L2 归一化
    hogFeatures = hogFeatures / norm(hogFeatures + 1e-6);
end
