function [ Uniform ] = UniformGridCheck3d( X,Y,Z )
% UniformGridCheck3d: Checks X Y and Z grid points to see if these have a
%                   uniform linear spacing and they are shaped as such
%                   (i.e. each row/col increases by a uniform increment).
%                   Gridded data that has been transformed to col vects
%                   does therefore not fit this criteria. 
%
%                   Can be used to check before plotting with different
%                   functions or for using in interpolation. Returns 1 if
%                   true. Can use in if statements i.e.. if uniform spaced
%                   points plot with contourf else use scatter.
%   
% usage #1:
% [ Uniform ] = UniformGridCheck3d( X,Y ,Z )
%
% Arguments: (input)
% X,Y,Z               - Data Points in X Y and Z. 
%
% Arguments: (output)
% Uniform           - Flag to say if the data points in X Y Z are spaced
%                    evenly on a grid ('1' means the data is uniform). 
%
% Example usage (1): Uniform grid
%
% [X,Y,Z]=meshgrid(-2:0.1:2,-2:0.1:2,-2:0.1:2);
% [ Uniform ] = UniformGridCheck3d( X,Y,Z )
% scatter3(X(:),Y(:),Z(:))
% 
% Example usage (2): Not uniform
%
% NumPnts=1000; %number of points, do not have cells , 10000
% xmv=0; ymv=0;  zmv=0;
% x=rand(1,NumPnts);
% y=rand(1,NumPnts);
% z=rand(1,NumPnts);
% X=x+xmv;
% Y=y+ymv;
% Z=z+zmv;
% [ X,Y,Z]=ReshapeData3d( 10,10,10,  X,Y,Z );
% [ Uniform ] = UniformGridCheck3d( X,Y,Z )
% scatter3(X(:),Y(:),Z(:))
% 
%  Author: Tim Davis
%  Copyright 2017, Tim Davis, Potsdam University\The University of Aberdeen


if iscolumn(X) ||  isrow(X)
    
    %If the data is col vecs we skip checking anything else
    flagx=0;
    flagy=0;
    flagz=0;
    
else    
    
    %Just checks gradient between points is 0. 
    flagx = diff(X,[],1)==0;
    flagy = diff(Y,[],2)==0;
    flagz = diff(permute(Z,[3 2 1]),[],2)==0; %Have to rearrange for diff (only does rows and cols)
    
end


Uniform= all(flagx(:)) && all(flagy(:)) && all(flagz(:)); %if the data is a uniform grid this==1


end

