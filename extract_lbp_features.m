function lbpFeatures = extract_lbp_features(grayImg)
    % 提取LBP特征
    lbpFeatures = extractLBPFeatures(grayImg, 'CellSize', [32 32]);
end
