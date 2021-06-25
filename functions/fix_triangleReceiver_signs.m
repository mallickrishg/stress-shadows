function newVertices = fix_triangleReceiver_signs(triangleReceiver)
    % due to an undiagnosed bug inside Unicycle, the stresses/displacements
    % generated by a triangleReceiver object will be inconsistent depending
    % on the sense of orientation of the triangle vertices. If your code is
    % failing the 'check_triangleReceiver_signs' assertion and throwing an
    % error, you should run this code to generate a reversed set of
    % vertices for the offending triangles. You can then save this file as
    % a new 'ned' file to be used in the inversion instead of your original
    % file.
    %
    % Eric Lindsey, June 2021
    
    p1 = triangleReceiver.x(triangleReceiver.vertices(:,1),:);
    p2 = triangleReceiver.x(triangleReceiver.vertices(:,2),:);
    p3 = triangleReceiver.x(triangleReceiver.vertices(:,3),:);

    v1 = p2 - p1;
    v2 = p3 - p2;

    cp=cross(v1,v2);
    
    newVertices=[];
    
    for i=1:length(cp)
        if cp(:,3) >= 0 % this is a bad triangle
            newVertices(i,1)=(triangleReceiver.vertices(i,3));
            newVertices(i,2)=(triangleReceiver.vertices(i,2));
            newVertices(i,3)=(triangleReceiver.vertices(i,1));
        else
            newVertices(i,:)=triangleReceiver.vertices(i,:);
        end
    end
   
end