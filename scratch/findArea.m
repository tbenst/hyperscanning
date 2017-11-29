function a = findArea(width,varargin)
    % example for varargin
    p = inputParser;
    defaultHeight = 1;
    defaultUnits = 'inches';
    defaultShape = 'rectangle';
    expectedShapes = {'square','rectangle','parallelogram'};

    addRequired(p,'width',@isnumeric);
    addOptional(p,'height',defaultHeight,@isnumeric);
    addParameter(p,'units',defaultUnits);
    addParameter(p,'shape',defaultShape,...
                 @(x) any(validatestring(x,expectedShapes)));

    parse(p,width,varargin{:});
    a = p.Results.width .* p.Results.height;
end

function simple(varargin)
    p = inputParser;
    heightDefault = 1;
    addOptional(p,'height',heightDefault);
    parse(p,varargin{:});
    height = p.Results.height
end
