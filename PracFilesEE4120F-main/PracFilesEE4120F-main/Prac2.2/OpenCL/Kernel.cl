
//TODO: set your arguments for the kernel. Note that you have to indicate if the argument is global or local. Global arguments are accessable by both host and this target device. While local can only be accessed by the device running this kernel. eg __global int* inputMatrixA, __local int* groupMemory

__kernel void matrixMultiplication(__global int* matrixA, __global int* matrixB, __global int* Size, __global int* output, __local int* Scratch){
	int workItemNum = get_global_id(0); //Work item ID
	int workGroupNum = get_group_id(0); //Work group ID
	int localGroupID = get_local_id(0); //Work items ID within each work group

	//TODO: program your kernel here
	//uint global_addr = workItemNum;
	int len = *Size;

//	Checking to confirm matrix elements and their corresponding indices in 1D
//	printf("Matrix A, element %d: %d \n",workItemNum,matrixA[workItemNum]);
//	printf("Matrix B, element %d: %d \n",workItemNum,matrixB[workItemNum]);


//	Only Assigned to local memory the respective elements needed for matrix multiplication at associated work group
//	Allocated to Scratch single row elements from matrixA for each work group, proceeded by elements of matrixB
//	Offset from index to matrixB = len
	Scratch[localGroupID] = matrixA[localGroupID + workGroupNum*len];
	for (int k=0; k<len; k++){
		Scratch[(localGroupID+1)*len+k] = matrixB[localGroupID*len + k];
	}
//	Pause operations until memory is fully allocated
	barrier(CLK_LOCAL_MEM_FENCE);


//	Assign to output from local memory
	output[workItemNum] = 0;
	for (int i=0; i<len; i++){
		output[workItemNum] += Scratch[i]*Scratch[(i+1)*len+localGroupID];
	}


//	Code below is original Algorithm implemented prior to seperation of memory overhead and processing
//	output[workItemNum] = 0;
//	for (int i = 0; i < len; i++){
//		output[workItemNum] += matrixA[workGroupNum*len+i]*matrixB[localGroupID+i*len];
//	}

	
}




