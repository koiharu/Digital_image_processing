function [hogFeatures, visualization] = extract_hog_features(grayImg)
    % 提取HOG特征
    [hogFeatures, visualization] = extractHOGFeatures(grayImg, 'CellSize', [8 8]);
end
