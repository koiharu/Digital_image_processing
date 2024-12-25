function extract_features_from_image(grayImg)

    % 提取直线图像
    lineImg = extract_lines(grayImg);

    % 提取原始图像的LBP特征
    lbpFeaturesOrig = extract_lbp_features(grayImg);

    % 提取直线图像的LBP特征
    lbpFeaturesLine = extract_lbp_features(lineImg);

    % 提取原始图像的HOG特征
    [hogFeaturesOrig, visualizationOrig] = extract_hog_features(grayImg);

    % 提取直线图像的HOG特征
    [hogFeaturesLine, visualizationLine] = extract_hog_features(lineImg);

    % 显示HOG可视化结果
    display_hog_visualization(grayImg, lineImg, visualizationOrig, visualizationLine);

    % 输出特征长度
    disp(['原始图像LBP特征长度: ', num2str(length(lbpFeaturesOrig))]);
    disp(['直线图像LBP特征长度: ', num2str(length(lbpFeaturesLine))]);
    disp(['原始图像HOG特征长度: ', num2str(length(hogFeaturesOrig))]);
    disp(['直线图像HOG特征长度: ', num2str(length(hogFeaturesLine))]);
end