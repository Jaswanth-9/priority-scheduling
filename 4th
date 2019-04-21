#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main()
{
    int burst_time[10],Process_no[10],wait_time[10],turn_a_time[10],remBT[10],ct[10],l,k,m,tok;
    int arri_time[10],Prior[10],i,j,Number_of_Process,tot=0,flag,temp,count=0;
	float avg_wait_time,avg_turn_a_time;
	int cswitch = 0;	
    printf("Enter Number of Process:");
    scanf("%2d",&Number_of_Process);
    for( i = 0 ; i < Number_of_Process ; i++ )
    {
        printf("\n\n P[%d] :",(i+1));
        printf("\n Enter Burst Time: ");
        scanf("%2d",&burst_time[i]);
		remBT[i] = burst_time[i];
        printf("\n Enter Arrival Time: ");
        scanf("%2d",&arri_time[i]);
        printf("\n Enter Priority: ");
        scanf("%2d",&Prior[i]);
        Process_no[i]=i+1;
	ct[i]=0;
    }
     for(i = 0; i < Number_of_Process; i++)
    {
		if(arri_time[i] != 0 && cswitch!=0 && ct[i]==0)
		{
	  		for(l = 0; l < arri_time[i]; l++)
	  		{
				count++	;
	  		}
	  		ct[i] = arri_time[i];
	  		printf("\n\n %3ds <----\tNO PROCESS\t----> %3ds",0,count);
		}
		for(k = i+1; k < Number_of_Process ; k++)
		{
			if( arri_time[i] == 0 && arri_time[k] == 0 && !cswitch)
			{		
				if(Prior[i] <= Prior[k])
				{
					for(l = 0 ; l < burst_time[i+1] ; l++)
					{
						count++;
							remBT[i]--;
						if((count%2)==0)
						{
							Prior[k]--;
						}
					}
				  	printf("\n\n %3ds <----\tP[%d]\t---->%3ds",arri_time[i],i+1,count);
				  	ct[i] = arri_time[i] + count;
				}
				else if(Prior[k] < Prior[i])
				{
						for(l = 0 ; l < burst_time[k+1] ; l++)
					{
						count++;
						remBT[k]--;
						if((count%2)==0)
						{
							Prior[i]--;
						}
					}
				  	printf("\n\n %3ds <----\tP[%d]\t---->%3ds",arri_time[k],k+1,count);
					ct[i] = arri_time[k] + count;
				}
			}
			else if(arri_time[i] == 0 && !cswitch)
			{
				for(l = 0 ; l < burst_time[i+1] ; l++)
				{
					count++;
					remBT[i]--;
					if(count==arri_time[l])
					{		
						if(Prior[i] <= Prior[k])
						{
							cswitch = 0;
							for(l = 0 ; l < burst_time[i+1] ; l++)
							{
								count++;
								remBT[i]--;
								if((count%2)==0)
								{
									Prior[l]--;
						 		}
				 			}
					  		printf("\n\n %3ds <----\tP[%d]\t---->%3ds",arri_time[i],i+1,count);
							ct[i] = arri_time[i] + count;
							break;
						}
						else if(Prior[k] < Prior[i])
						{
							cswitch = 1;
							sleep(2);
							for(l = 0 ; l < burst_time[i+1] ; l++)
							{
								count++;
								remBT[l]--;
								if((count%2)==0)
								{
									Prior[i]--;
								}
 						 	}
 						printf("\n\n %3ds <----\tP[%d]\t---->%3ds",arri_time[k],k+1,count);
						ct[i] = arri_time[k] + count;
						break;
						}
					}
				}
				printf("\n\n %3ds <----\tP[%d]\t---->%3ds",arri_time[i],i+1,count);
				ct[i] = arri_time[i] + count;
		}
		else if(arri_time[i]!=0 && ct!=0)
		{
			for(l = 0 ; l < arri_time[i+1] ; l++)
			{
					count++;
					remBT[i]--;
					if(count==arri_time[l])
					{		
						if(Prior[i] <= Prior[k])
						{
							cswitch = 0;
							for(m = 0 ; m < burst_time[i+1] ; m++)
							{
								count++;
								remBT[i]--;
								if((count%2)==0)
								{
									Prior[l]--;
						 		}
				 			}
					  		printf("\n\n %3ds <----\tP[%d]\t---->%3ds",arri_time[i],i+1,count);
							ct[i] = arri_time[i] + count;
							break;
						}
	
						else if(Prior[k] < Prior[i])
						{
							cswitch = 1;
							sleep(2);
							for(l = 0 ; l < burst_time[i+1] ; l++)
							{
								count++;
								remBT[l]--;
								if((count%2)==0)
								{
									Prior[i]--;
								}
 							}
 							printf("\n\n %3ds <----\tP[%d]\t---->%3ds",arri_time[k],k+1,count);
							ct[i] = arri_time[k] + count;
							break;
						}
					}
				}
				printf("\n\n %3ds <----\tP[%d]\t---->%3ds",arri_time[i],i+1,count);
				ct[i] = arri_time[i] + count;
			}
			
		}
    }
    for(i=0;i<Number_of_Process;i++)
    {
        flag=i;
        for(j=i+1;j<Number_of_Process;j++)
        {
            if(Prior[j]<Prior[flag])
            flag=j;
        }
        temp=Prior[i];
        Prior[i]=Prior[flag];
        Prior[flag]=temp;
        temp=burst_time[i];
        burst_time[i]=burst_time[flag];
        burst_time[flag]=temp;
        temp=arri_time[i];
        arri_time[i]=arri_time[flag];
        arri_time[flag]=temp;
        temp=Process_no[i];
        Process_no[i]=Process_no[flag];
        Process_no[flag]=temp;
    }

	    for(i=1;i<Number_of_Process;i++)
	    {
		wait_time[i]=0;
		for(j=0;j<i;j++){
		  	wait_time[i]+=burst_time[j];
		}
		tot+=wait_time[i];
	    }
	    avg_wait_time = tot/Number_of_Process;
	    turn_a_time[0]=0;
	    tot=0;
	    for(i=1;i<Number_of_Process;i++)
	    {
		turn_a_time[i]=0;
		for(j=0;j<i;j++)
		    turn_a_time[i]+=ct[j]-arri_time[j];
		tot+=turn_a_time[i];
	    }
	    avg_turn_a_time = tot/Number_of_Process; 
	    wait_time[0]=0;  
