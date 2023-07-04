#define STRICT
#include <windows.h> 
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <process.h>
#include <conio.h>
#include <math.h>
#include <Wingdi.h>
//#include <phylip.h>


#include "threshold.h"
#define namelength      10   /* number of characters max. in species name    */
#define smoothings      4    
#define epsilonf        0.000001   
#define down            2
#define over            60


/*typedef double *vectorftch;
typedef short *intvectftch;

typedef struct fitchnode {
  struct fitchnode *next, *back;
  boolean tip, iter;
  short number;
  short int nayme;
  vectorftch d, w;
  double v, dist;
  short xcoord, ycoord, ymin, ymax;
} fitchnode;

typedef struct fitchtree {
  fitchnode **fitchnodep;
  double likelihood;
  fitchnode *start;
} fitchtree;*/
/*typedef struct node {
  struct node *next, *back;
  boolean tip;
  long number;
  short int nayme;
  double v;
  long xcoord, ycoord, ymin, ymax;
} node;

typedef struct tree {
  node **nodep;
  node *start;
} tree;*/



typedef float *vector;
typedef long *intvector;

//static fitchtree curfitchtree, priorfitchtree, besfitchtree, besfitchtree2;
static tree curtree;


struct nodex_struct{
  
  int neighbourindex;
  struct nodex_struct *next;
};

typedef struct nodex_struct nodex;




int FAR pascal pair_score( short int *alignment,  int *site_states,int char_a, int char_b, int num_sites, int num_taxa)
{
  /* Keep both list & matrix - one for quick adding, other for quick DFS */
  nodex **adjacency_list;
  char **adjacency_matrix;
  nodex *cur_nodex,*new_nodex,*next_nodex;
  int char_a_states = site_states[char_a];
  int char_b_states = site_states[char_b];
  int total_states = char_a_states+char_b_states;
  int char_a_val,char_b_val,i,j,edge_count;
   int MAX_STATE;
   MAX_STATE=100;
  /* For DFS */
  nodex **DFS_adjacency;
  int* array_stack;
  char* marked;
  int potential_neighbour;
  char has_valid_neighbour;
  int comp_count;
  int top=0,cur_vertex=0;
  
  /* For score */
  
  int inc_score=-1;
  
  
  /* Initialize list and matrix */
  adjacency_list=(nodex **)malloc(total_states * sizeof(nodex *));
  for(i=0;i<total_states;i++)
    adjacency_list[i]=NULL;
  
  adjacency_matrix=(char **)malloc(total_states * sizeof(char *) );
  for(i=0;i<total_states;i++)
    {
      adjacency_matrix[i]=(char *)malloc(total_states * sizeof(char));
    }
  
  
  
  
  
  
  
  for(i=0;i<total_states;i++)
    {
      for(j=0;j<total_states;j++)
	{
	  adjacency_matrix[i][j]=0;
	}
    }

  
  /* Initialize stuff for DFS... */
  DFS_adjacency=(nodex **)malloc(total_states * sizeof(nodex *) );
  array_stack=(int *)malloc(  (total_states) * sizeof(int));
  marked=(char *)malloc(total_states * sizeof(char) );
  int os1, os2;
  os1 = (num_taxa+1)*char_a;//num_sites+1;
  os2 = (num_taxa+1)*char_b;
  /* Build adjacency list */
  edge_count=0;


  for(i=0;i<num_taxa;i++)
    {
      char_a_val=(int)(alignment[ i + os1]);
      /* Number vertices [0...char_a_states-1] then [char_a_states..total_states] */
      char_b_val=(int)(alignment[i+os2]);
      /* Add the edge - if necessary */
      
      if((char_a_val < total_states) && (char_b_val <= total_states) && (char_a_val >= 0) && (char_b_val >= 0))
	{
	  /* Increase index to "global index" */
	  char_b_val=char_b_val+char_a_states;
	

	  if(adjacency_matrix[char_a_val][char_b_val]==0)
	    {
	
	      /* Update symmetric adjacency matrix (undirected graph)*/
	      adjacency_matrix[char_a_val][char_b_val]=1;
	      adjacency_matrix[char_b_val][char_a_val]=1;
	      edge_count++;
	      
	      /* Add to adjacency lists */
	      cur_nodex=adjacency_list[char_a_val];
	      new_nodex=(nodex *)malloc(sizeof(nodex) );
	      new_nodex->neighbourindex=char_b_val;
	      new_nodex->next=cur_nodex;
	      adjacency_list[char_a_val]=new_nodex;

	      /* And other list */
	      cur_nodex=adjacency_list[char_b_val];
	      new_nodex=(nodex *)malloc(sizeof(nodex) );
	      new_nodex->neighbourindex=char_a_val;
	      new_nodex->next=cur_nodex;
	      adjacency_list[char_b_val]=new_nodex;
	      
	      
	    }
	}
    }
  /* Now do DFS to count components */
  
  for(i=0;i<total_states;i++)
    {
      marked[i]=0;
      DFS_adjacency[i]=adjacency_list[i];
    }

  top=-1;

  comp_count=0;

  for(i=0;i<total_states;i++)
    {
      if(!marked[i])
	{

	  comp_count++;
	  /* "push" index onto stack */
	  array_stack[++top]=i;

	  while(top >= 0)
	    {
	      cur_vertex=array_stack[top];
	      marked[cur_vertex]=1;
	      has_valid_neighbour=0;
	      while((DFS_adjacency[cur_vertex] != NULL) && (has_valid_neighbour == 0))
		{
		  potential_neighbour=(DFS_adjacency[cur_vertex])->neighbourindex;
		  if(marked[potential_neighbour]==0)
		    {

		      array_stack[++top]=potential_neighbour;
		      has_valid_neighbour=1;
		    }
		  else
		    {
		      DFS_adjacency[cur_vertex]=DFS_adjacency[cur_vertex]->next;
		    }
		}
	      
	      if(has_valid_neighbour == 0)
		{
		  top--;
		}

	    }
	}
    }


  /* De allocate adjacency list */
  for(i=0;i<total_states;i++)
    {

      cur_nodex=adjacency_list[i];
      
      while(cur_nodex!=NULL)
	  {
	    next_nodex=cur_nodex->next;
	    free(cur_nodex);
	    cur_nodex=next_nodex;
	  }
      /*   free(cur_nodex); ? */
      free(adjacency_matrix[i]); 
    }
  
  free(adjacency_list);
  free(DFS_adjacency);
  free(adjacency_matrix);
  
  free(marked);
  free(array_stack);
  
  /* For the pairwise incompatibility */
  
  inc_score=edge_count-total_states+comp_count;

  return inc_score;
}

int FAR pascal pair_score2( short int *alignment,  int *site_states,int char_a, int num_sites, int num_taxa, unsigned char *inc_matrix)
{
  /* Keep both list & matrix - one for quick adding, other for quick DFS */
  nodex **adjacency_list;
  char **adjacency_matrix;
  nodex *cur_nodex,*new_nodex,*next_nodex;
  
  int char_b;
  int char_a_states;
  int char_b_states;
  int total_states ;
  int char_a_val,char_b_val,i,j,edge_count;
   int MAX_STATE;
   MAX_STATE=100;
  /* For DFS */
  nodex **DFS_adjacency;
  int* array_stack;
  char* marked;
  int potential_neighbour;
  char has_valid_neighbour;
  int comp_count;
  int top,cur_vertex;
  int inc_score,os;

  os = num_sites+1;
  /* For score */
  inc_matrix[char_a + char_a*os] = 0;
  char_a_states = site_states[char_a];
	int os1, os2;
	os1 = (num_taxa+1)*char_a;//num_sites+1;

  for (char_b  = char_a+1; char_b<num_sites; char_b++){
		  
		
		char_b_states = site_states[char_b];
		total_states = char_a_states+char_b_states;
		inc_score=-1;
		  //top=0;
		  cur_vertex=0;
		  inc_score=-1;
		  /* Initialize list and matrix */
		  adjacency_list=(nodex **)malloc(total_states * sizeof(nodex *));
		  for(i=0;i<total_states;i++)
			adjacency_list[i]=NULL;
  
		  adjacency_matrix=(char **)malloc(total_states * sizeof(char *) );
		  for(i=0;i<total_states;i++)
			{
			  adjacency_matrix[i]=(char *)malloc(total_states * sizeof(char));
			}
  
  
  
  
  
  
  
		  for(i=0;i<total_states;i++)
			{
			  for(j=0;j<total_states;j++)
			{
			  adjacency_matrix[i][j]=0;
			}
			}

  
		  /* Initialize stuff for DFS... */
		  DFS_adjacency=(nodex **)malloc(total_states * sizeof(nodex *) );
		  array_stack=(int *)malloc(  (total_states) * sizeof(int));
		  marked=(char *)malloc(total_states * sizeof(char) );
		  
		  os2 = (num_taxa+1)*char_b;
		  /* Build adjacency list */
		  edge_count=0;


		  for(i=0;i<num_taxa;i++)
			{
			  char_a_val=(int)(alignment[ i + os1]);
			  /* Number vertices [0...char_a_states-1] then [char_a_states..total_states] */
			  char_b_val=(int)(alignment[i+os2]);
			  /* Add the edge - if necessary */
      
			  if((char_a_val < total_states) && (char_b_val <= total_states) && (char_a_val >= 0) && (char_b_val >= 0))
			{
			  /* Increase index to "global index" */
			  char_b_val=char_b_val+char_a_states;
			

			  if(adjacency_matrix[char_a_val][char_b_val]==0)
				{
			
				  /* Update symmetric adjacency matrix (undirected graph)*/
				  adjacency_matrix[char_a_val][char_b_val]=1;
				  adjacency_matrix[char_b_val][char_a_val]=1;
				  edge_count++;
				  
				  /* Add to adjacency lists */
				  cur_nodex=adjacency_list[char_a_val];
				  new_nodex=(nodex *)malloc(sizeof(nodex) );
				  new_nodex->neighbourindex=char_b_val;
				  new_nodex->next=cur_nodex;
				  adjacency_list[char_a_val]=new_nodex;

				  /* And other list */
				  cur_nodex=adjacency_list[char_b_val];
				  new_nodex=(nodex *)malloc(sizeof(nodex) );
				  new_nodex->neighbourindex=char_a_val;
				  new_nodex->next=cur_nodex;
				  adjacency_list[char_b_val]=new_nodex;
				  
				  
				}
			}
			}
		  /* Now do DFS to count components */
  
		  for(i=0;i<total_states;i++)
			{
			  marked[i]=0;
			  DFS_adjacency[i]=adjacency_list[i];
			}

		  top=-1;

		  comp_count=0;

		  for(i=0;i<total_states;i++)
			{
			  if(!marked[i])
			{

			  comp_count++;
			  /* "push" index onto stack */
			  array_stack[++top]=i;

			  while(top >= 0)
				{
				  cur_vertex=array_stack[top];
				  marked[cur_vertex]=1;
				  has_valid_neighbour=0;
				  while((DFS_adjacency[cur_vertex] != NULL) && (has_valid_neighbour == 0))
				{
				  potential_neighbour=(DFS_adjacency[cur_vertex])->neighbourindex;
				  if(marked[potential_neighbour]==0)
					{

					  array_stack[++top]=potential_neighbour;
					  has_valid_neighbour=1;
					}
				  else
					{
					  DFS_adjacency[cur_vertex]=DFS_adjacency[cur_vertex]->next;
					}
				}
				  
				  if(has_valid_neighbour == 0)
				{
				  top--;
				}

				}
			}
			}


		  /* De allocate adjacency list */
		  for(i=0;i<total_states;i++)
			{

			  cur_nodex=adjacency_list[i];
      
			  while(cur_nodex!=NULL)
			  {
				next_nodex=cur_nodex->next;
				free(cur_nodex);
				cur_nodex=next_nodex;
			  }
			  /*   free(cur_nodex); ? */
			  free(adjacency_matrix[i]); 
			}
  
		  free(adjacency_list);
		  free(DFS_adjacency);
		  free(adjacency_matrix);
  
		  free(marked);
		  free(array_stack);
  
		  /* For the pairwise incompatibility */
  
		  inc_matrix[char_a + char_b*os] = edge_count-total_states+comp_count;
		  inc_matrix[char_b + char_a*os] = inc_matrix[char_a + char_b*os];
		}
  return (1);
}


int FAR pascal get_f_and_g(unsigned char *inc_matrix,int *num_states,int num_chars, double *f_values,double *g_values)
 {
   int i,j, os;
   double fscore=0.0,gscore=0.0;
   double val;
   os = num_chars+1;
   for(i=0;i<num_chars;i++)
     {
       fscore=0.0;
       gscore=0.0;
       f_values[i]=0.0;
       g_values[i]=0.0;

       for(j=0;j<num_chars;j++)
		 {
		   val=((double)((int)inc_matrix[i+j*os]));
		   fscore=fscore+val;
		   gscore=gscore+val*val;

		 }
       f_values[i]=fscore;
       g_values[i]=gscore;
     }
   return(1);
 }


int FAR pascal GetDScore(int NumTaxa, int i, int J, int *SqScore, short int *char_alignment, unsigned char *PairsMatrix){
	int A, B, D, char_a, char_b, osa, osb;
	
	osa = i*(NumTaxa+1);
	osb = J*(NumTaxa+1);
	for (A=0; A <16; A++)
		PairsMatrix[A]=0;
	
    for (A = 0; A < NumTaxa; A++){
        char_a = char_alignment[A + osa];
        
        if (char_a > -1 ){
			char_b = char_alignment[A + osb];
            if (char_b > -1)
                PairsMatrix[char_a + char_b*4] = 1;
            
		}
    }
  
    D = 0;
    for (A = 0; A < 4; A++){
        for (B = 0; B< 4; B++){
           if (PairsMatrix[A + B*4] == 1 )
                D = D + SqScore[A + B*4];
           
           
        }
    }

	return(D);
}

int FAR pascal MakeNewAlignment(int num_taxa, int num_sites, int UBNA, int UBA, int *state_map, unsigned char *Alignment, short int *new_alignment){
	
	int J, i, cur_state,  state_count, K, os1, os2, os3, char_a;
	
	os1 = UBA+1;
	os3 = UBNA+1;
	for (J = 0; J < num_sites; J++){
      
        for (K = 0; K < 100; K++)
            state_map[K] = -1;
        
        state_count = 0;
		os2 = os1*J;
		
        for (i = 0; i < num_taxa; i++){
       
            char_a = Alignment[i + os2];
            
           
			if (char_a > 46){
              
                if (state_map[char_a] < 0){
              
                    state_map[char_a] = state_count;
                    cur_state = state_count;
                    state_count++;
                
				}
                else
              
                    cur_state = state_map[char_a];
                
			}
            else
              cur_state = -1;
            
            new_alignment[i + J*os3] = cur_state;
        }
        
      
    }

	return(1);

}


int FAR pascal CopyColumn(int J, int UBNA, int UBSN, int num_taxa, int site_count, short int *SeqNum, unsigned char *new_alignment){
	int i, os1, os2;
	os1 = UBSN+1;
	os2 = (UBNA+1)*site_count;
	for (i = 0; i < num_taxa; i++)
              
		new_alignment[i + os2] = (unsigned char)(SeqNum[J + i*os1]);
            

	return(1);
}


int FAR pascal MakeStateMap(int num_taxa,int J, int UBSN1, short int *SeqNum, int *state_map,  int *gap_char){
	int i, state_count, char_a, os1;
	for (i = 0; i < 100; i++)
		state_map[i] = 0;
    
	

	os1 = UBSN1+1;
	state_count = 0;
	*gap_char = 0;
	
	for (i = 0; i < num_taxa; i++){
    
          char_a = SeqNum[J + i*os1];
    
		  if (char_a > 46){
            
            
			  if (state_map[char_a] <= 0){
            
                    state_count++;
                    state_map[char_a]++;
              
			  }
                else
                    state_map[char_a]++;
                
		  }
          
          else if (char_a == 46)
            
              *gap_char = 1;
    }


	return (state_count);
}

int FAR pascal FillIncMatrix(int i, int num_inf, int NumTaxa, int *inf_states,unsigned char *PairsScores, short int *char_alignment, unsigned char *PairsMatrix, int *SqScore, unsigned char *inc_matrix){
	
	int os1, J, D, os2;
	int NewEntry;
	NewEntry = 0;
	os1 = num_inf+1;
	os2 = os1*i;
	inc_matrix[i+ i*os1] = 0;
    for (J = i + 1; J < num_inf; J++){
        
                
                  
        D = GetDScore(NumTaxa, i, J, SqScore, char_alignment, PairsMatrix);
        
        if (PairsScores[D] == 255){
            PairsScores[D] = pair_score(char_alignment, inf_states, i, J, num_inf, NumTaxa);
            NewEntry = 1;
        
        }
        
        inc_matrix[i + J*os1] = PairsScores[D];
     
        inc_matrix[J + os2] = PairsScores[D];
                  
	}

	return(NewEntry);
}

double zip(double q, double i, int j, double b, double LINK)
{
  double k;
  double zz = 1.0;
  double z;

  z = zz;
  k = i;
  while (k <= j) {
    zz = zz * q * k / (k - b);
    z += zz;
    k += 2;
  }
  return z;
}

double buzz(double t, int n, double LINK){
  double rt,fk,ek,dk;
  t = fabs(t);
  rt = t / sqrt(n);
  fk = atan(rt);
  if (n == 1)
    return (1 - fk / LINK);
  else {
    ek = sin(fk);
    dk = cos(fk);
    return (1 - ek * zip(dk * dk, 1.0, n - 3, -1.0, LINK));
  }

}

double FAR pascal ttestprob(double t, int df){

	double V;
	double pi = 4.0 * atan(1.0);
	V = pi / 2;
	return (1.0 - buzz(t, df, V) / 2.0);
}

double ttestprob2(double t, int df){

	double V;
	double pi = 4.0 * atan(1.0);
	V = pi / 2;
	return (1.0 - buzz(t, df, V) / 2.0);
}

void hookup(node *p, node *q)
{
  /* hook together two nodes */
  p->back = q;
  q->back = p;
  
}  /* hookup */

void treeout(node *p, char *otreex, short int nj,int *tpos, int nlen) {
  /* write out file with representation of final tree */
  int   x2, x3, n2, n3, mod;
  float x;
	if (p->tip) {
		*tpos = *tpos +1;
		*(otreex + *tpos) = 83;
		
		mod = nlen;
		n2 = p->nayme;
		n3 = (int)(n2/mod);
		*tpos = *tpos +1;
		*(otreex + *tpos) = (char)(48 + n3);
		while (mod > 1){
			
			n2 -= n3*mod;
			n3 = (int)(n2/(mod/10));
			*tpos = *tpos +1;
			*(otreex + *tpos) = (char)(48 + n3);
			mod /= 10;
		}
	} else {
		
		//putc('(', treefile);
		*tpos = *tpos +1;
		*(otreex + *tpos) = 40;
		//col++;
		
		treeout(p->next->back, otreex, nj, tpos, nlen);
		//putc(',', treefile);
		*tpos = *tpos +1;
		*(otreex + *tpos) = 44;
		//col++;
		
		treeout(p->next->next->back, otreex, nj, tpos, nlen);
		if (p == curtree.start && nj == 1) {
			//putc(',', treefile);
			*tpos = *tpos +1;
			*(otreex + *tpos) = 44;
			treeout(p->back, otreex, nj, tpos, nlen);
		}
		//putc(')', treefile);
		*tpos = *tpos +1;
		*(otreex + *tpos) = 41;
		//col++;
	}
	
	x = p->v;
		//fprintf(treefile, ":%*.5f", (int)(w + 7), x);
		*tpos = *tpos +1;
		*(otreex+ *tpos) = 58;
		if (x < 0.0){
			x *= -1;
			*tpos = *tpos +1;
			*(otreex+ *tpos) = 45;
		}
		if (x < 1.0){
			*tpos = *tpos +1;
			*(otreex + *tpos) = 48;
			*tpos = *tpos +1;
			*(otreex + *tpos) = 46;
		}
		else{
			*tpos = *tpos +1;
			*(otreex + *tpos) = (int)(x) + 48;
			*tpos = *tpos +1;
			*(otreex + *tpos) = 46;
		}

		x -= (int)(x);

		mod = 100000;
		x2 = (int)(x*mod); 
		x3 = (int)(x2/(mod/10));
		while (mod > 10){
			*tpos = *tpos +1;
			*(otreex + *tpos) = char(48 + x3);
			mod /= 10;	
			x2 -= x3*mod;
			x3 = x2 / (mod/10);
			//if (x2/10000000 < 1 && (double)(x2/10000000) > 0.1){
			//	tpos++;
			//	*(otree + tpos) = 46;
			//}
		}
		
	//return(tps);
}  /* treeout */



int FAR pascal NEIGHBOUR(short int njoin, short int jumble, int nseed, int outgrno, int numsp, float *x, char *ot, float *coltotals, float *tarray)
{
	
	
	int nlen, k, s,numsp2, numsp1, off1, off2;
	long  i, j, nc, nextnode, mini, minj, ia, ja, ii, jj, nude, iter, mini2,minj2;
	float diq, djq, dij, fotu2, total, tmin, dio, djo, bi, bj, bk, dmin, da;
	long el[3];
	vector av;
	intvector oc;
	/* initialize a tree */
  
  //tree *curtree;	
  int tpos, subi, subj;
  char *otreex;
  long *enterorder;
  node *p, *q;
  node **cluster;
  node **pq;
  
  tpos = 0;
  numsp1 = numsp + 1;
  numsp2 = numsp * 2 - 2;
  srand(nseed);
  
  enterorder = (long *)malloc(numsp*sizeof(long));
  cluster = (node **)malloc(numsp*sizeof(node *));
  pq = (node  **)malloc(numsp2*4*sizeof(node *));
  curtree.nodep = (node **)malloc((numsp2+1)*sizeof(node *));
  //setuptree(&curtree, numsp2 ,numsp);
  
	  for (s = 0; s < numsp; s++) {
		curtree.nodep[s] = (node *)malloc(sizeof(node));
		curtree.nodep[s]->tip = true;
		curtree.nodep[s]->number = s + 1;
		curtree.nodep[s]->nayme = s;
		curtree.nodep[s]->v = 0.0;
		pq[s*4] = curtree.nodep[s]; 
	  }

	
	 /* for (i = numsp1; i <= numsp2; i++) {
		q = NULL;
		for (j = 1; j <= 3; j++) {
		  if (j > 1)
			  free(p);
		  p = (node *)malloc(10*sizeof(node));
		  p->tip = false;
		  p->number = i;
		  p->next = q;
		  q = p;
		}
		p->next->next->next = p;
		curtree.nodep[i - 1] = p;
		
	  }
	  q = NULL;
	  for (j = 1; j <= 2; j++) {
		free(p);
		p = (node *)malloc(10*sizeof(node));
		p->tip = false;
		p->number = numsp2 + 1;
		p->next = q;
		q = p;
	  }
	  p->next->next = p;
	  curtree.nodep[numsp2] = p;
	  curtree.start = curtree.nodep[0];*/
	  //p = (node *)malloc(10*sizeof(node));
	  
	  for (i = numsp1; i <= numsp2; i++) {
		q = NULL;
		for (j = 1; j <= 3; j++) {
		  //It allocates memory 3 times why if it only adds the last one onto curtree?????
		  p = (node *)malloc(sizeof(node));
		  p->tip = false;
		  p->number = i;
		  p->next = q;
		  q = p;
		  pq[j+i*4] = p;

		}

		p->next->next->next = p;
		curtree.nodep[i - 1] = p;
	  }
	  q = NULL;
	  for (j = 1; j <= 2; j++) {
		
		p = (node *)malloc(sizeof(node));
		p->tip = false;
		p->number = numsp2 + 1;
		p->next = q;
		q = p;
		pq[j]=p;
	  }
	  p->next->next = p;
	  curtree.nodep[numsp2] = p;
	  curtree.start = curtree.nodep[0];
	  
	  for (i = 1; i <= numsp; i++)
		enterorder[i - 1] = i;

	  if (jumble == 1) {
    
		for (i = 0; i < numsp; i++) {
		  //j = (long)(randum(seed) * numsp) + 1;
		  j =  (int)((rand() / RAND_MAX)*numsp +1);
		  k = enterorder[j - 1];
		  enterorder[j - 1] = enterorder[i];
		  enterorder[i] = k;
		}
	  }
	  for (i = 0; i < numsp; i++)
		cluster[i] = curtree.nodep[i];
  
	  /* First initialization */
	  fotu2 = (float)(numsp - 2.0);
	  nextnode = numsp + 1;
	  av = (vector)malloc(numsp*sizeof(float));
	  oc = (intvector)malloc(numsp*sizeof(long));


	  for (i = 0; i < numsp; i++) {
		av[i] = 0.0;
		oc[i] = 1;
	  }
	
	  /* Enter the main cycle */
	  if (njoin == 1)
		iter = numsp - 3;
	  else
		iter = numsp - 1;


	  //Calculate column totals
	  for (i = 0; i < numsp; i++) {
		  for (j = 0; j < numsp; j++) 
				coltotals[i] = coltotals[i] + x[(i) + (j)*numsp];
	  }
	  
	  
//******************************************
	  if(njoin==1){
	  
			for (nc = 1; nc <= iter; nc++) {
				
				for (j = 1; j < numsp; j++) {
					off1= j*numsp;
					for (i = 0; i < j; i++)
						x[j + i*numsp] = x[i + off1];

				}
				for (i = 0; i < numsp; i++) {
					off1 = i*numsp;
					if (cluster[i] != NULL){
						coltotals[i] = 0.0;
						for (j = 0; j < numsp; j++)
							coltotals[i] = coltotals[i] + x[j + off1];
					}
				}
			
				tmin = 99999.0;
			
				/* Compute sij and minimize */
				for (ja = 2; ja <= numsp; ja++) {
					jj = enterorder[ja - 1]-1;
					
					if (cluster[jj] != NULL) {
						off1 = jj*numsp;
						for (ia = 0; ia <= ja - 2; ia++) {
							ii = enterorder[ia]-1;
							if (cluster[ii] != NULL) {
							
								
								dij = x[ii + off1];
								//Total the ii and jj columns of the distance matrix
								diq = coltotals[ii];
								djq = coltotals[jj];
									
									//fotu2 = number of columns remaining in the distance matrix - 2
									//total = sij, the rate corrected distance between taxa i and j
								total = fotu2 * dij - diq - djq;
						
							//remember the smallest total - only the i & j with the lowest sij 
							//is of interest
								if (total < tmin) {
									tmin = total;
									mini = ii;
									minj = jj;
								}
							}
						}
					}
				}
			
			    mini2 = mini;
				minj2 = minj;
				mini++;
				minj++;
				/* compute lengths and print */
			
				dio = 0.0;
				djo = 0.0;
				//recalculate the totals of the winning i and j columns - this is pretty dumb
				//they should be stored
				subi = 0;
				subj = 0;
				off1 = (mini2)*numsp;
				off2 = (minj2)*numsp;
				for (i = 0; i < numsp; i++) {
				
					dio += x[(i) + off1];
					djo += x[(i) + off2];
				
				}

				//calculate the branch lengths between taxa i and j and the newly created node
			  
				dmin = *(x + (mini2) + off2);
				dio = (dio - dmin) / fotu2;
				djo = (djo - dmin) / fotu2;
				bi = (float)((dmin + dio - djo) * 0.5);
				bj = dmin - bi;
				bi -= av[mini2];
				bj -= av[minj2];
			
				//actaully "draw" the tree using this info 
				hookup(curtree.nodep[nextnode - 1]->next, cluster[mini2]);
				hookup(curtree.nodep[nextnode - 1]->next->next, cluster[minj2]);
			
				cluster[mini2]->v = bi;
				cluster[minj2]->v = bj;
				cluster[mini2]->back->v = bi;
				cluster[minj2]->back->v = bj;

				//row i of the distance matrix inherits distance info for the new node and
				//row j is deleted.
				cluster[mini2] = curtree.nodep[nextnode - 1];
				cluster[minj2] = NULL;
				nextnode++;

				av[mini2] = (float)(dmin * 0.5);
				

//***************How is the newly created column effected by coltotals?

				/* re-initialization */
				fotu2 -= 1.0;
				for (j = 0; j < numsp; j++) {
						//coltotals[j] = coltotals[j] - x[(mini2) + (j)*numsp] - x[(minj2) + (j)*numsp];
						if (cluster[j] != NULL) {
							da = (float)((x[(mini2) + (j)*numsp] + x[(minj2) + (j)*numsp]) * 0.5);
							
						  
							//if (j != mini2){
							//	coltotals[j] = coltotals[j] - da;
								if (mini - j - 1 < 0)
									x[(mini2) + (j)*numsp] = (float)(da);
								else if (mini - j - 1 > 0)
									x[(j) + (mini2)*numsp] = (float)(da);
							//}
					//		else{
					//			for (i = 0; i < numsp; i++){
					//				if (i != mini2 && i != j)
					//					coltotals[j] = coltotals[j] + x[(j) + (i)*numsp];
					//			}
					//			
					//		}


						

					
						}
				}
			
				//delete all values from the minj column - is this necessary?
				//coltotals[minj-1] =0.0;
				for (j = 0; j < numsp; j++) {
					x[(minj2) + j*numsp] = 0.0;
					x[j + (minj2)*numsp] = 0.0;
					
				}
		
				//keep track of how many taxa are now decendents of the node represented by culumn mini
				oc[mini2] += oc[minj2];
			}
		}
	
	//******************************************
		else{
			for (nc = 1; nc <= iter; nc++) {
				for (j = 2; j <= numsp; j++) {
					for (i = 0; i <= j - 2; i++)
						x[(j-1) + (i)*numsp] = x[i + (j-1)*numsp];
				}
				tmin = 99999.0;
			
				/* Compute sij and minimize */
				for (ja = 2; ja <= numsp; ja++) {
					jj = enterorder[ja - 1]-1;
					if (cluster[jj] != NULL) {
						off1 = jj*numsp;
						for (ia = 0; ia <= ja - 2; ia++) {
							ii = enterorder[ia]-1;
							if (cluster[ii] != NULL) {
								//remember the smallest total - only the i & j with the lowest sij 
								//is of interest
								if (x[ii + off1] < tmin) {
									tmin = x[ii + off1];
									mini = ii;
									minj = jj;
								}
							}
						}
					}
				}
			
			
				mini2=mini;
				minj2=minj;
				mini++;
				minj++;
				/* compute lengths and print */
			
				bi = (float)(*(x + (mini2) + (minj2)*numsp) / 2.0 - av[mini2]);
				bj = (float)(*(x + (mini2) + (minj2)*numsp) / 2.0 - av[minj2]);
				av[mini2] += bi;
		
			
				//actaully "draw" the tree using this info 
				hookup(curtree.nodep[nextnode - 1]->next, cluster[mini2]);
				hookup(curtree.nodep[nextnode - 1]->next->next, cluster[minj2]);
			
				cluster[mini2]->v = bi;
				cluster[minj2]->v = bj;
				cluster[mini2]->back->v = bi;
				cluster[minj2]->back->v = bj;
			
				//row i of the distance matrix inherits distance info for the new node and
				//row j is deleted.
				cluster[mini2] = curtree.nodep[nextnode - 1];
				cluster[minj2] = NULL;
				nextnode++;

				/* re-initialization */
				fotu2 -= 1.0;
				for (j = 0; j < numsp; j++) {
					if (cluster[j] != NULL) {
				
						da = *(x + (mini2) + (j)*numsp) * oc[mini2] + *(x + (minj-1) + (j)*numsp) * oc[minj2];
						da /= oc[mini2] + oc[minj2];
						*(x + (mini2) + (j)*numsp) = (float)(da);
						*(x + (j) + (mini2)*numsp) = (float)(da);
			
					}
				}
			
				//delete all values from the minj column - is this necessary?
				for (j = 0; j < numsp; j++) {
					x[(minj2) + j*numsp] = 0.0;
					x[j + (minj2)*numsp] = 0.0;
				}
		
				//keep track of how many taxa are now decendents of the node represented by culumn mini
				oc[mini2] += oc[minj2];

			}
		
		}
		
	  /* the last cycle */
		


	  nude = 1;
	  for (i = 1; i <= numsp; i++) {
		if (cluster[i - 1] != NULL) {
		  el[nude - 1] = i;
		  nude++;
		}
	  }
	  
	  if (njoin == 0) {
		//curtree.start = cluster[el[0] - 1];
		curtree.start = cluster[el[0] - 1];
		//return (1);
	  }
	  else {
			subi=0;
			bi=0;
			//bi = (x[el[0] - 1][el[1] - 1] + x[el[0] - 1][el[2] - 1] - x[el[1] - 1][el[2] - 1]) * 0.5;
			bi =  (float)((*(x + (el[0] - 1) + (el[1] - 1)*numsp) + *(x + (el[0] - 1) + (el[2] - 1)*numsp) - *(x + (el[1] - 1) + (el[2] - 1)*numsp))*0.5);
			bj = *(x + (el[0] - 1) + (el[1] - 1)*numsp) - bi;
			bk = *(x + (el[0] - 1) + (el[2] - 1)*numsp) - bi;
			bi -= av[el[0] - 1];
			bj -= av[el[1] - 1];
			bk -= av[el[2] - 1];
		  
				
		  hookup(curtree.nodep[nextnode - 1], cluster[el[0] - 1]);
		  hookup(curtree.nodep[nextnode - 1]->next, cluster[el[1] - 1]);
		  hookup(curtree.nodep[nextnode - 1]->next->next, cluster[el[2] - 1]);
		  cluster[el[0] - 1]->v = bi;
		  cluster[el[1] - 1]->v = bj;
		  cluster[el[2] - 1]->v = bk;
		  cluster[el[0] - 1]->back->v = bi;
		  cluster[el[1] - 1]->back->v = bj;
		  cluster[el[2] - 1]->back->v = bk;
		  //curtree.start = cluster[el[0] - 1]->back;
		  curtree.start = cluster[el[0] - 1]->back;
		  free(av);
		  free(oc);
		}
  



	//}  /* jointree */
		if (outgrno > 0)
			curtree.start = curtree.nodep[outgrno - 1]->back;
		
		
		//nj = njoin;
		if (numsp < 100)
			nlen = 10;
		else if (numsp < 1000)
			nlen = 100;
		else
			nlen = 1000;
		tpos = 0;
		otreex = (char *)malloc(numsp*40*sizeof(char));
		treeout(curtree.start, otreex, njoin, &tpos, nlen);
		//tpos -= 7;
		for(i = 1; i <= tpos; i++)//{
			*(ot + i) = *(otreex + i);

		*(ot + 1 + tpos) = 59;
		
		free(otreex);
		//free (pq[1]);
	  //free(p);
		free(enterorder);
		free(cluster);
			  
		/*for (s = 0; s <= numsp; s++) {
				//free(curtree.nodep[s]->next);
				free(curtree.nodep[s]);
			  }*/
		
		//free(pq[1]);
		for (s = 0; s < numsp; s++) {
				//free(curtree.nodep[s]->next);
				free(pq[s*4]);
			  }
		
		for (i = numsp1; i <= numsp2; i++) {
			
			for (j = 1; j <= 3; j++) {
			  
			  free(pq[j+i*4]);

			}
		}
		
		free (pq[1]);
		free (pq[2]);
		
		free (pq);
		free (curtree.nodep);
 return(tpos+1);
}  /* setuptree */

int FAR pascal NEIGHBOUR2(short int njoin, short int jumble, int nseed, int outgrno, int numsp, float *x, short int *ot, double *coltotals, float *tarray)
{
	
	
	int nlen, k, s,numsp2, numsp1, off1, off2;
	long  i, j, nc, nextnode, mini, minj, ia, ja, ii, jj, nude, iter, mini2,minj2;
	mini=0;
	minj=0;
	float  fotu2, total, tmin, dio, djo, bi, bj, bk, dmin, da;
	long el[3];
	vector av;
	intvector oc;
	/* initialize a tree */
  
  //tree *curtree;	
  int tpos, subi, subj;
  char *otreex;
  long *enterorder;
  node *p, *q;
  node **cluster;
  node **pq;
  
  tpos = 0;
  numsp1 = numsp + 1;
  numsp2 = numsp * 2 - 2;
  srand(nseed);
  
  enterorder = (long *)malloc(numsp*sizeof(long));
  cluster = (node **)malloc(numsp*sizeof(node *));
  pq = (node  **)malloc(numsp2*4*sizeof(node *));
  curtree.nodep = (node **)malloc((numsp2+1)*sizeof(node *));
  //setuptree(&curtree, numsp2 ,numsp);
  
	  for (s = 0; s < numsp; s++) {
		curtree.nodep[s] = (node *)malloc(sizeof(node));
		curtree.nodep[s]->tip = true;
		curtree.nodep[s]->number = s + 1;
		curtree.nodep[s]->nayme = s;
		curtree.nodep[s]->v = 0.0;
		pq[s*4] = curtree.nodep[s]; 
	  }

	
	 /* for (i = numsp1; i <= numsp2; i++) {
		q = NULL;
		for (j = 1; j <= 3; j++) {
		  if (j > 1)
			  free(p);
		  p = (node *)malloc(10*sizeof(node));
		  p->tip = false;
		  p->number = i;
		  p->next = q;
		  q = p;
		}
		p->next->next->next = p;
		curtree.nodep[i - 1] = p;
		
	  }
	  q = NULL;
	  for (j = 1; j <= 2; j++) {
		free(p);
		p = (node *)malloc(10*sizeof(node));
		p->tip = false;
		p->number = numsp2 + 1;
		p->next = q;
		q = p;
	  }
	  p->next->next = p;
	  curtree.nodep[numsp2] = p;
	  curtree.start = curtree.nodep[0];*/
	  //p = (node *)malloc(10*sizeof(node));
	  
	  for (i = numsp1; i <= numsp2; i++) {
		q = NULL;
		for (j = 1; j <= 3; j++) {
		  //It allocates memory 3 times why if it only adds the last one onto curtree?????
		  p = (node *)malloc(sizeof(node));
		  p->tip = false;
		  p->number = i;
		  p->next = q;
		  q = p;
		  pq[j+i*4] = p;

		}

		p->next->next->next = p;
		curtree.nodep[i - 1] = p;
	  }
	  q = NULL;
	  for (j = 1; j <= 2; j++) {
		
		p = (node *)malloc(sizeof(node));
		p->tip = false;
		p->number = numsp2 + 1;
		p->next = q;
		q = p;
		pq[j]=p;
	  }
	  p->next->next = p;
	  curtree.nodep[numsp2] = p;
	  curtree.start = curtree.nodep[0];
	  
	  for (i = 1; i <= numsp; i++)
		enterorder[i - 1] = i;

	  if (jumble == 1) {
    
		for (i = 0; i < numsp; i++) {
		  //j = (long)(randum(seed) * numsp) + 1;
		  j =  (int)((rand() / RAND_MAX)*numsp +1);
		  k = enterorder[j - 1];
		  enterorder[j - 1] = enterorder[i];
		  enterorder[i] = k;
		}
	  }
	  for (i = 0; i < numsp; i++)
		cluster[i] = curtree.nodep[i];
  
	  /* First initialization */
	  fotu2 = (float)(numsp - 2.0);
	  nextnode = numsp + 1;
	  av = (vector)malloc(numsp*sizeof(double));
	  oc = (intvector)malloc(numsp*sizeof(long));


	  for (i = 0; i < numsp; i++) {
		av[i] = 0.0;
		oc[i] = 1;
	  }
	
	  /* Enter the main cycle */
	  if (njoin == 1)
		iter = numsp - 3;
	  else
		iter = numsp - 1;


	  //Calculate column totals
	  for (i = 0; i < numsp; i++) {
		  for (j = 0; j < numsp; j++) 
				coltotals[i] = coltotals[i] + x[(i) + (j)*numsp];
	  }
	  
	  
//******************************************
	  if(njoin==1){
	  
			for (nc = 1; nc <= iter; nc++) {
				
				for (j = 1; j < numsp; j++) {
					off1= j*numsp;
					for (i = 0; i < j; i++)
						x[j + i*numsp] = x[i + off1];

				}
				
			
				tmin = 99999.0;
				for (i = 0; i < numsp; i++)
					coltotals[i] = 0.0;
				 for (ja = 2; ja <= numsp; ja++) {
					jj = enterorder[ja - 1]-1;
					off1 = jj*numsp;
					if (cluster[jj - 1] != NULL) {
					  for (ia = 0; ia <= ja - 2; ia++) {
						ii = enterorder[ia]-1;
						if (cluster[ii] != NULL) {
						  coltotals[ii] += x[ii + off1];
						  coltotals[jj] += x[ii + off1];
						}
					  }
					}
				  }
				/* Compute sij and minimize */
				for (ja = 2; ja <= numsp; ja++) {
					jj = enterorder[ja - 1]-1;
					
					if (cluster[jj] != NULL) {
						off1 = jj*numsp;
						for (ia = 0; ia <= ja - 2; ia++) {
							ii = enterorder[ia]-1;
							if (cluster[ii] != NULL) {
							
								
								//dij = x[ii + off1];
								//Total the ii and jj columns of the distance matrix
								//diq = coltotals[ii];
								//djq = coltotals[jj];
									
									//fotu2 = number of columns remaining in the distance matrix - 2
									//total = sij, the rate corrected distance between taxa i and j
								total = (float)( fotu2 * x[ii + off1] - coltotals[ii] - coltotals[jj]);
						
							//remember the smallest total - only the i & j with the lowest sij 
							//is of interest
								if (total < tmin) {
									tmin = total;
									mini = ii;
									minj = jj;
								}
							}
						}
					}
				}
			
			    mini2 = mini;
				minj2 = minj;
				mini++;
				minj++;
				/* compute lengths and print */
			
				dio = 0.0;
				djo = 0.0;
				//recalculate the totals of the winning i and j columns - this is pretty dumb
				//they should be stored
				subi = 0;
				subj = 0;
				off1 = (mini2)*numsp;
				off2 = (minj2)*numsp;
				for (i = 0; i < numsp; i++) {
				
					dio += x[(i) + off1];
					djo += x[(i) + off2];
				
				}

				//calculate the branch lengths between taxa i and j and the newly created node
			  
				dmin = *(x + (mini2) + off2);
				dio = (dio - dmin) / fotu2;
				djo = (djo - dmin) / fotu2;
				bi = (float)((dmin + dio - djo) * 0.5);
				bj = dmin - bi;
				bi -= av[mini2];
				bj -= av[minj2];
			
				//actaully "draw" the tree using this info 
				hookup(curtree.nodep[nextnode - 1]->next, cluster[mini2]);
				hookup(curtree.nodep[nextnode - 1]->next->next, cluster[minj2]);
			
				cluster[mini2]->v = (float)(bi);
				cluster[minj2]->v = bj;
				cluster[mini2]->back->v = bi;
				cluster[minj2]->back->v = bj;

				//row i of the distance matrix inherits distance info for the new node and
				//row j is deleted.
				cluster[mini2] = curtree.nodep[nextnode - 1];
				cluster[minj2] = NULL;
				nextnode++;

				av[mini2] = (float)(dmin * 0.5);
				

//***************How is the newly created column effected by coltotals?

				/* re-initialization */
				fotu2 -= 1.0;
				for (j = 0; j < numsp; j++) {
						//coltotals[j] = coltotals[j] - x[(mini2) + (j)*numsp] - x[(minj2) + (j)*numsp];
						if (cluster[j] != NULL) {
							da = (float)((x[(mini2) + (j)*numsp] + x[(minj2) + (j)*numsp]) * 0.5);
							
						  
							//if (j != mini2){
							//	coltotals[j] = coltotals[j] - da;
								if (mini - j - 1 < 0)
									x[(mini2) + (j)*numsp] = (float)(da);
								else if (mini - j - 1 > 0)
									x[(j) + (mini2)*numsp] = (float)(da);
							//}
					//		else{
					//			for (i = 0; i < numsp; i++){
					//				if (i != mini2 && i != j)
					//					coltotals[j] = coltotals[j] + x[(j) + (i)*numsp];
					//			}
					//			
					//		}


						

					
						}
				}
			
				//delete all values from the minj column - is this necessary?
				//coltotals[minj-1] =0.0;
				for (j = 0; j < numsp; j++) {
					x[(minj2) + j*numsp] = 0.0;
					x[j + (minj2)*numsp] = 0.0;
					
				}
		
				//keep track of how many taxa are now decendents of the node represented by culumn mini
				oc[mini2] += oc[minj2];
			}
		}
	
	//******************************************
		else{
			for (nc = 1; nc <= iter; nc++) {
				for (j = 2; j <= numsp; j++) {
					for (i = 0; i <= j - 2; i++)
						x[(j-1) + (i)*numsp] = x[i + (j-1)*numsp];
				}
				tmin = 99999.0;
			
				/* Compute sij and minimize */
				for (ja = 2; ja <= numsp; ja++) {
					jj = enterorder[ja - 1]-1;
					if (cluster[jj] != NULL) {
						off1 = jj*numsp;
						for (ia = 0; ia <= ja - 2; ia++) {
							ii = enterorder[ia]-1;
							if (cluster[ii] != NULL) {
								//remember the smallest total - only the i & j with the lowest sij 
								//is of interest
								if (x[ii + off1] < tmin) {
									tmin = x[ii + off1];
									mini = ii;
									minj = jj;
								}
							}
						}
					}
				}
			
			
				mini2=mini;
				minj2=minj;
				mini++;
				minj++;
				/* compute lengths and print */
			
				bi = (float)(*(x + (mini2) + (minj2)*numsp) / 2.0 - av[mini2]);
				bj = (float)(*(x + (mini2) + (minj2)*numsp) / 2.0 - av[minj2]);
				av[mini2] += bi;
		
			
				//actaully "draw" the tree using this info 
				hookup(curtree.nodep[nextnode - 1]->next, cluster[mini2]);
				hookup(curtree.nodep[nextnode - 1]->next->next, cluster[minj2]);
			
				cluster[mini2]->v = bi;
				cluster[minj2]->v = bj;
				cluster[mini2]->back->v = bi;
				cluster[minj2]->back->v = bj;
			
				//row i of the distance matrix inherits distance info for the new node and
				//row j is deleted.
				cluster[mini2] = curtree.nodep[nextnode - 1];
				cluster[minj2] = NULL;
				nextnode++;

				/* re-initialization */
				fotu2 -= 1.0;
				for (j = 0; j < numsp; j++) {
					if (cluster[j] != NULL) {
				
						da = *(x + (mini2) + (j)*numsp) * oc[mini2] + *(x + (minj-1) + (j)*numsp) * oc[minj2];
						da /= oc[mini2] + oc[minj2];
						*(x + (mini2) + (j)*numsp) = (float)(da);
						*(x + (j) + (mini2)*numsp) = (float)(da);
			
					}
				}
			
				//delete all values from the minj column - is this necessary?
				for (j = 0; j < numsp; j++) {
					x[(minj2) + j*numsp] = 0.0;
					x[j + (minj2)*numsp] = 0.0;
				}
		
				//keep track of how many taxa are now decendents of the node represented by culumn mini
				oc[mini2] += oc[minj2];

			}
		
		}
		
	  /* the last cycle */
		


	  nude = 1;
	  for (i = 1; i <= numsp; i++) {
		if (cluster[i - 1] != NULL) {
		  el[nude - 1] = i;
		  nude++;
		}
	  }
	  
	  if (njoin == 0) {
		//curtree.start = cluster[el[0] - 1];
		curtree.start = cluster[el[0] - 1];
		//return (1);
	  }
	  else {
			subi=0;
			bi=0;
			//bi = (x[el[0] - 1][el[1] - 1] + x[el[0] - 1][el[2] - 1] - x[el[1] - 1][el[2] - 1]) * 0.5;
			bi =  (float)((*(x + (el[0] - 1) + (el[1] - 1)*numsp) + *(x + (el[0] - 1) + (el[2] - 1)*numsp) - *(x + (el[1] - 1) + (el[2] - 1)*numsp))*0.5);
			bj = *(x + (el[0] - 1) + (el[1] - 1)*numsp) - bi;
			bk = *(x + (el[0] - 1) + (el[2] - 1)*numsp) - bi;
			bi -= av[el[0] - 1];
			bj -= av[el[1] - 1];
			bk -= av[el[2] - 1];
		  
				
		  hookup(curtree.nodep[nextnode - 1], cluster[el[0] - 1]);
		  hookup(curtree.nodep[nextnode - 1]->next, cluster[el[1] - 1]);
		  hookup(curtree.nodep[nextnode - 1]->next->next, cluster[el[2] - 1]);
		  cluster[el[0] - 1]->v = bi;
		  cluster[el[1] - 1]->v = bj;
		  cluster[el[2] - 1]->v = bk;
		  cluster[el[0] - 1]->back->v = bi;
		  cluster[el[1] - 1]->back->v = bj;
		  cluster[el[2] - 1]->back->v = bk;
		  //curtree.start = cluster[el[0] - 1]->back;
		  curtree.start = cluster[el[0] - 1]->back;
		  free(av);
		  free(oc);
		}
  



	//}  /* jointree */
		if (outgrno > 0)
			curtree.start = curtree.nodep[outgrno - 1]->back;
		
		
		//nj = njoin;
		if (numsp < 100)
			nlen = 10;
		else if (numsp < 1000)
			nlen = 100;
		else
			nlen = 1000;
		tpos = 0;
		otreex = (char *)malloc(numsp*40*sizeof(char));
		treeout(curtree.start, otreex, njoin, &tpos, nlen);
		//tpos -= 7;
		for(i = 1; i <= tpos; i++)//{
			*(ot + i) = *(otreex + i);

		*(ot + 1 + tpos) = 59;
		
		free(otreex);
		//free (pq[1]);
	  //free(p);
		free(enterorder);
		free(cluster);
			  
		/*for (s = 0; s <= numsp; s++) {
				//free(curtree.nodep[s]->next);
				free(curtree.nodep[s]);
			  }*/
		
		//free(pq[1]);
		for (s = 0; s < numsp; s++) {
				//free(curtree.nodep[s]->next);
				free(pq[s*4]);
			  }
		
		for (i = numsp1; i <= numsp2; i++) {
			
			for (j = 1; j <= 3; j++) {
			  
			  free(pq[j+i*4]);

			}
		}
		
		free (pq[1]);
		free (pq[2]);
		
		free (pq);
		free (curtree.nodep);
 return(tpos+1);
}  /* setuptree */

double FAR pascal DistanceCalc(short int nextno,int lenseq,short int *seqnum,float *distance,double *avdst)
{

	int count;
	int valid;
	double count2;
	double valid2;
	double dst, ad;
	double upper=0.0;
	short int s1, s2;
	long xoff, yoff;
	dst = 0.0;
	ad = 0.0;
	for(int x = 0;x < nextno;x++){
		xoff = x*lenseq;
		for (int y = x+1; y<=nextno; y++){
		   yoff = y*lenseq;
		   count = 0;
		   valid = 0;
		   for (int z = 1; z <= lenseq; z++){
			   s1 = *(seqnum + z + xoff);
			   s2 = *(seqnum + z + yoff);
			   if(s1 > 64 && s2 > 64){
				   valid++;
				   if (s1 != s2)
						count++;
			   }
		   }    
		   count2 = count;
		   valid2 = valid;
		   if (valid2 > 0)
				dst = (valid2 - count2)/valid2;
		   else
			   dst = 0;

		   *(distance + x + y*(nextno+1))= (float)(dst);
		   *(distance + y + x*(nextno+1))= (float)(dst);
		   ad = ad + (1.0 - dst);
		   if(dst < upper)
			   upper = dst;
		}
	   upper = (double)(1 - dst);
	}
	*avdst = ad; 
	return(upper);
}


int FAR pascal RebuildSeqNum(int LS, int WinPP, int *RNum, int *BReaks, int *Rlist, short int *SeqNum, short int *tSeqNum){
	int X, Y, off1, off2;
	for (X = 0; X <= RNum[WinPP]; X++){
        off1 =  Rlist[WinPP + X*3]*(LS+1);
		off2 = X*(LS+1);
		if (BReaks[X*2] < BReaks[1 + X*2]){
			for (Y = BReaks[X*2] + 1; Y < BReaks[1 + X*2]; Y++)
				SeqNum[Y + off1] = tSeqNum[Y + off2];
		}
		else{
                  
                  for (Y = BReaks[X*2] + 1; Y <= LS; Y++)
                          SeqNum[Y + off1] = tSeqNum[Y + off2];
                  
                  for (Y = 1; Y < BReaks[1 + X*2]; Y++)
                          SeqNum[Y + off1] = tSeqNum[Y + off2];
		}
	}
	return(1);
}

int FAR pascal MakeTrpScore(int X, int Nextno, float *FAMat,float *SAMat,double *TrpScore,int *NumInGroup, int *Iseqs, int *GroupSeq){
	int Y, Z, GoOn, off1, off2;
	for (Y = 0; Y <= Nextno; Y++){
		off2 = Iseqs[X] + Y*(Nextno+1);
		for (Z = Y + 1; Z <= Nextno; Z++){
			GoOn = 0;
			off1 = Iseqs[X] + Z*(Nextno+1);
            if (FAMat[off1] > FAMat[off2] && SAMat[off1] < SAMat[off2])
				GoOn = 1;
            else if (FAMat[off1]< FAMat[off2] && SAMat[off1] > SAMat[off2])
				GoOn = 1;
            else if (FAMat[off1] == FAMat[off2] && SAMat[off1] != SAMat[off2])
				GoOn = 1;
            else if (FAMat[off1] != FAMat[off2] && SAMat[off1] == SAMat[off2])
				GoOn = 1;
            if (GoOn == 1)
				TrpScore[X] = TrpScore[X] + 1 / (float)(NumInGroup[GroupSeq[Y]] * NumInGroup[GroupSeq[Z]]);
		}
	}
	return(1);
}

int FAR pascal ModSeqNumY(int BPos, int EPos, int LS, int WinPP, int *RNum, int *BReaks, int *Rlist, short int *SeqNum, short int *tSeqNum, unsigned char *missdata){
	int X,Y,off1,off2;
	for (X = 0; X <= RNum[WinPP]; X++){
		off1 =  Rlist[WinPP + X*3]*(LS+1);
		off2 = X*(LS+1);
		//Note that 2 sites of the recombinant region are intentionally left
        //in the background sequence to slightly penalise reading over the BR region
        //when looking for additional recombination.
        if (BReaks[X*2] == 0 && BReaks[1 + X*2] == 0){
			BReaks[X*2] = BPos;
            BReaks[1 + X*2] = EPos;
		}
              if (BReaks[X*2] < BReaks[1 + X*2]){
                  for (Y = BReaks[X*2]; Y <= BReaks[1 + X*2]; Y++){
                          tSeqNum[Y + off2] = SeqNum[Y + off1];
                          SeqNum[Y + off1] = 46;
						  missdata[Y + off1] = 1;
				  }
			  }
              else{
                  
                  for (Y = BReaks[X*2]; Y <= LS; Y++){
                          tSeqNum[Y + off2] = SeqNum[Y + off1];
                          SeqNum[Y + off1] = 46;
						  missdata[Y + off1] = 1;
                  }
                  
				  for (Y = 1; Y <= BReaks[1 + X*2]; Y++){
                          tSeqNum[Y + off2] = SeqNum[Y + off1];
                          SeqNum[Y + off1] = 46;
						  missdata[Y + off1] = 1;
                  }
			  }
			  //missdata[BReaks[X*2] + off1] = 1;
			  //missdata[BReaks[1 + X*2] + off1] = 1;
			  
	}
	return(1);
}

int FAR pascal ModSeqNumB(int BPos, int EPos, int LS, int WinPP, int *RNum, int *BReaks, int *Rlist, short int *SeqNum, short int *tSeqNum){
	int X,Y,off1,off2;
	for (X = 0; X <= RNum[WinPP]; X++){
		off1 =  Rlist[WinPP + X*3]*(LS+1);
		off2 = X*(LS+1);
		//Note that 2 sites of the recombinant region are intentionally left
        //in the background sequence to slightly penalise reading over the BR region
        //when looking for additional recombination.
        if (BReaks[X*2] == 0 && BReaks[1 + X*2] == 0){
			BReaks[X*2] = BPos;
            BReaks[1 + X*2] = EPos;
		}
              if (BReaks[X*2] < BReaks[1 + X*2]){
                  for (Y = BReaks[X*2] + 1; Y < BReaks[1 + X*2]; Y++){
                          tSeqNum[Y + off2] = SeqNum[Y + off1];
                          SeqNum[Y + off1] = 64;
				  }
			  }
              else{
                  
                  for (Y = BReaks[X*2] + 1; Y <= LS; Y++){
                          tSeqNum[Y + off2] = SeqNum[Y + off1];
                          SeqNum[Y + off1] = 64;
                  }
                  
				  for (Y = 1; Y < BReaks[1 + X*2]; Y++){
                          tSeqNum[Y + off2] = SeqNum[Y + off1];
                          SeqNum[Y + off1] = 64;
                  }
			  }
	}
	return(1);
}
int FAR pascal ModSN(int Nextno,int LS, int BPos, int EPos, int WinPP, int *RNum, int *Rlist, int *BReaks, short int *SeqNum, unsigned char *missdata){
	//breaks 1,rnumwinpp
	int X, Y, off1,off2, off3, off4;
	
	
	for (X = 0; X <= RNum[WinPP]; X++){
		off1 = Nextno - RNum[WinPP] + X;
		off2 = off1 * (LS+1);
		off3 = Rlist[WinPP + X*3];
		off4 = off3 * (LS+1);
		//Note that 2 sites of the recombinant region are intentionally left
        //in the background sequence to slightly peanalise reading over the BR region
        //when looking for additional recombination.
		if (BReaks[X*2] == 0 && BReaks[1 + X*2] == 0){
			BReaks[X*2] = BPos;
            BReaks[1 + X*2] = EPos;
		}
        if (BReaks[X*2] < BReaks[1 + X*2]){
            for (Y = 1; Y < BReaks[X*2]; Y++){
                SeqNum[Y + off2] = 46;
				missdata[Y + off2] = 1;
			}

			for (Y = BReaks[X*2]; Y <= BReaks[1 + X*2]; Y++){
                SeqNum[Y + off2] = SeqNum[Y + off4];
                
				
			}
                  
            for (Y = BReaks[1 + X*2]+1; Y<= LS; Y++){
                SeqNum[Y + off2] = 46;
				missdata[Y + off2] = 1;
			}
                 
		}
		else{
                  
			for (Y = BReaks[X*2]; Y <= LS; Y++){
                 SeqNum[Y + off2] = SeqNum[Y + off4];
			}
			for (Y = BReaks[1 + X*2]+1; Y < BReaks[X*2]; Y++){
                  SeqNum[Y + off2] = 46;
				  missdata[Y + off2] = 1;
			}
                 
			for (Y = 1; Y <= BReaks[1 + X*2]; Y++){
                  SeqNum[Y + off2] = SeqNum[Y + off4];
			}
		}
        //SeqNum[BReaks[X*2] + off2] = SeqNum[BReaks[X*2] + off4];
        //SeqNum[BReaks[1 + X*2] + off2] = SeqNum[BReaks[1 + X*2] + off4];
		
		//missdata[BReaks[X*2] + off2] = 1;
		//missdata[BReaks[X*2] + off4] = 1;
		//missdata[BReaks[1 + X*2] + off2] = 1;
		//missdata[BReaks[1 + X*2] + off4] = 1;
	}

	return(1);
}




int FAR pascal MakeDistanceBakB(int Nextno, int UBDB, int UBD, float *Distance, float *distancebak){
	int X, Y, MaxV, off1, off2, off3;
	
	if (UBD <= UBDB)
		MaxV = UBD;
	else
		MaxV=UBDB;

	if (MaxV > Nextno)
		MaxV = Nextno;
	
	off1 = UBDB+1;
	off2 = UBD+1;
	for (X = 0; X <= MaxV; X++){
		off3 = X*off1;
        for (Y = X+1; Y <= MaxV; Y++){
            
            if (Distance[X + Y*off2] > 0){
            
                distancebak[X + Y*off1] = (1 - Distance[X + Y*off2]);
                distancebak[Y + off3] = distancebak[X + Y*off1];
			}
            else{
                distancebak[X + Y*off1] = (float)(0.999);
                distancebak[Y + off3] = (float)(0.999);
             
            }
        }

    }

	return(1);

}

int FAR pascal MakeTots(int Nextno, int UBF, float *Tot, float *FMat, float *SMat, unsigned char *DontUse){
	int X, Y, off1;

	off1 = UBF+1;
	for (X = 0; X < Nextno; X++){
		
		for (Y = X + 1; Y <= Nextno; Y++){
			if (DontUse[X] == 0 && DontUse[Y] == 0){
				if (FMat[X + Y*off1] < 3){
					Tot[0] = Tot[0] + FMat[X + Y*off1];
					Tot[1] = Tot[1] + SMat[X + Y*off1];
				}
			}
		}
	}
	return(1);
}

int FAR pascal MakeDI(int Nextno, int UBDT, int UBF, float *DI, float *FMat, float *SMat, int *DoneThis){
	int X, Y, off1, off2, off3;

	off1 = UBF+1;
	off2 = UBDT+1;
	for (X = 0; X < Nextno; X++){
		off3 = off2*X;
		for (Y = X + 1; Y <= Nextno; Y++){
			if ((DoneThis[off3] == 0 || DoneThis[1 + off3] == 0) && (DoneThis[Y*off2] == 0 || DoneThis[1 + Y*off2] == 0)){
				DI[0] = DI[0] + FMat[X + Y*off1];
				DI[1] = DI[1] + SMat[X + Y*off1];
			}
		}
	}
	return(1);
}

int FAR pascal CopyFloatArray(int Nextno, int UBDB, int UBD, float *Distance, float *distancebak){
	int X, Y, MaxV, off1, off2, off3, off4;
	
	if (UBD <= UBDB)
		MaxV = UBD;
	else
		MaxV=UBDB;

	if (MaxV > Nextno)
		MaxV = Nextno;
	
	off1 = UBDB+1;
	off2 = UBD+1;
	for (X = 0; X <= MaxV; X++){
		off3 = X*off1;
		off4 = X*off2;
        for (Y = 0; Y <= MaxV; Y++)
            distancebak[Y + off3] = Distance[Y + off4];

    }

	return(1);

}

int FAR pascal ModSeqNumZ(int Nextno,int LS, int BPos, int EPos, int WinPP, int *RNum, int *Rlist, int *BReaks, short int *SeqNum, unsigned char *missdata){
	//breaks 1,rnumwinpp
	int X, Y, off1,off2, off3, off4;
	
	
	for (X = 0; X <= RNum[WinPP]; X++){
		off1 = Nextno - RNum[WinPP] + X;
		off2 = off1 * (LS+1);
		off3 = Rlist[X];
		off4 = off3 * (LS+1);
		//Note that 2 sites of the recombinant region are intentionally left
        //in the background sequence to slightly peanalise reading over the BR region
        //when looking for additional recombination.
		if (BReaks[X*2] == 0 && BReaks[1 + X*2] == 0){
			BReaks[X*2] = BPos;
            BReaks[1 + X*2] = EPos;
		}
        if (BReaks[X*2] < BReaks[1 + X*2]){

			for (Y = BReaks[X*2]; Y <= BReaks[1 + X*2]; Y++){
                SeqNum[Y + off4] = 46;
				missdata[Y + off4] = 1;
			}
                  
                 
		}
		else{
                  
			for (Y = BReaks[X*2]; Y <= LS; Y++){
                 
                 SeqNum[Y + off4] = 46;
				 missdata[Y + off4] = 1;
				 
			}
                
			for (Y = 1; Y <= BReaks[1 + X*2]; Y++){
                  
                  SeqNum[Y + off4] = 46;
				  missdata[Y + off4] = 1;
				  
			}
		}
	}

	return(1);
}

int FAR pascal ModSeqNumA(int Nextno,int LS, int BPos, int EPos, int WinPP, int *RNum, int *Rlist, int *BReaks, short int *SeqNum){
	//breaks 1,rnumwinpp
	int X, Y, off1,off2, off3, off4;
	
	
	for (X = 0; X <= RNum[WinPP]; X++){
		off1 = Nextno - RNum[WinPP] + X;
		off2 = off1 * (LS+1);
		off3 = Rlist[WinPP + X*3];
		off4 = off3 * (LS+1);
		//Note that 2 sites of the recombinant region are intentionally left
        //in the background sequence to slightly peanalise reading over the BR region
        //when looking for additional recombination.
		if (BReaks[X*2] == 0 && BReaks[1 + X*2] == 0){
			BReaks[X*2] = BPos;
            BReaks[1 + X*2] = EPos;
		}
        if (BReaks[X*2] < BReaks[1 + X*2]){
            for (Y = 1; Y <= BReaks[X*2]; Y++)
                SeqNum[Y + off2] = 64;

			for (Y = BReaks[X*2] + 1; Y < BReaks[1 + X*2]; Y++){
                SeqNum[Y + off2] = SeqNum[Y + off4];
                SeqNum[Y + off4] = 64;
			}
                  
            for (Y = BReaks[1 + X*2]; Y<= LS; Y++)
                SeqNum[Y + off2] = 64;
                 
		}
		else{
                  
			for (Y = BReaks[X*2] + 1; Y <= LS; Y++){
                 SeqNum[Y + off2] = SeqNum[Y + off4];
                 SeqNum[Y + off4] = 64;
			}
			for (Y = BReaks[1 + X*2]; Y <= BReaks[X*2]; Y++)
                  SeqNum[Y + off2] = 64;
                 
			for (Y = 1; Y < BReaks[1 + X*2] - 1; Y++){
                  SeqNum[Y + off2] = SeqNum[Y + off4];
                  SeqNum[Y + off4] = 64;
			}
		}
        SeqNum[BReaks[X*2] + off2] = SeqNum[BReaks[X*2] + off4];
        SeqNum[BReaks[1 + X*2] + off2] = SeqNum[BReaks[1 + X*2] + off4];
	}

	return(1);
}

int FAR pascal MakeTDiffs(int nextno, int xnextno,float *TDiffs, float *TValid, float *PermDiffs, float *PermValid, int *UnInvolved, int *ActualSeqSize){
	int X, Y;
	for (X = 0; X <= nextno; X++){
                TDiffs[X + X*(nextno+1)] = 0;
                TValid[X + X*(nextno+1)] = (float)(ActualSeqSize[X]);
                for (Y = X + 1; Y <= xnextno; Y++){
                    if (UnInvolved[Y] == 1 && UnInvolved[X] == 1){
                        TDiffs[X + Y*(nextno+1)] = PermDiffs[X + Y*(xnextno+1)];
                        TDiffs[Y + X*(nextno+1)] = PermDiffs[X + Y*(xnextno+1)];
                        TValid[X + Y*(nextno+1)] = PermValid[X + Y*(xnextno+1)];
                        TValid[Y + X*(nextno+1)] = PermValid[X + Y*(xnextno+1)];
					}
				}
	}
	return(1);
}

int FAR pascal MakePermDiffs(int Nextno, int MinSeqSize,float *TDiffs, float *TValid, float *PermDiffs, float *PermValid, float *Distance){
	int X, Y, off1, off2;
	off1 = (Nextno+1);
	for (X = 0; X < Nextno; X++){
		off2 = off1*X;
		for (Y = X + 1; Y <= Nextno; Y++){
			PermValid[X + Y*off1] = TValid[X + Y*off1];
            PermValid[Y + off2] = TValid[X + Y*off1];
            PermDiffs[X + Y*off1] = TDiffs[X + Y*off1];
            PermDiffs[Y + off2] = TDiffs[X + Y*off1];
			//return(1);
            if (PermValid[X + Y*off1] < MinSeqSize){
				Distance[X + Y*off1] = 0.0;
				Distance[Y + off2] = 0.0;
			}
		}
	}
	return(1);
}

double FAR pascal DistanceCalcW(int nextno,int lenseq,float *diffsx,float *validx, short int *seqnum,float *distance,double *avdst, int *involved)
{

	int count, ix, off1;
	int valid;
	float count2;
	float valid2;
	double dst, ad;
	double upper=0.0;
	int s1, x, y ,z;
	dst = 0.0;
	int xoff, yoff, off2;
	ad = 0.0;
	
	off1 = nextno+1;
	
	for(x = 0;x <= nextno;x++){
		*(distance + x + x*(nextno+1))= 1.0;
		xoff = x*lenseq;
		ix = involved[x];
		off2 = x*off1;
		for (y = x+1; y<=nextno; y++){
			if (involved[y] == 0 || ix == 0){
				   yoff = y*lenseq;
				   count = 0;
				   valid = 0;
				   for (z = 1; z < lenseq; z++){
					   
					   s1 = *(seqnum + (z + xoff));
					   
					   if (s1 == *(seqnum + (z + yoff))){
						   if (s1 != 46){
								valid++;
						   }
					   }
					   else if (s1 != 46){
								if (*(seqnum + (z + yoff)) != 46){
									valid++;
									count++;
								}
					   }
				   
				   }
				   count2 = (float)(count);
				   valid2 = (float)(valid);
				   *(validx + x + y*off1)= valid2;
				   *(validx + y + off2)= valid2;
				   *(diffsx + x + y*off1)= count2;
				   *(diffsx + y + off2)= count2;
			}
			else{
				
				count2 = *(diffsx + x + y*off1);
				valid2 = *(validx + x + y*off1);
			}

		   
		   //return(valid2);
		   if (valid2 > 0)
				dst = (valid2 - count2)/valid2;
		   else
			   dst = 0.0;

		   *(distance + x + y*off1)= (float)(dst);
		   *(distance + y + x*off1)= (float)(dst);
		   
		   ad = ad + (1.0 - dst);
		   if(dst < upper)
			   upper = dst;
		}
	   upper = (double)(1 - dst);
	}
	*avdst = ad; 
	return(upper);
}

int FAR pascal CopySeq (int LS, int Nextno, int X, int Y, short int *SeqNum){
	int Z;
	for (Z = 1; Z <= LS; Z++)
		SeqNum[Z + X*(LS+1)] = SeqNum[Z+ Y*(LS+1)];

	return(1);
}

double FAR pascal DistanceCalcX(int nextno,int lenseq,float *diffsx,float *validx, short int *seqnum,float *distance,double *avdst)
{

	int count;
	int valid;
	double count2;
	double valid2;
	double dst, ad;
	double upper=0.0;
	int s1, s2, x, y ,z;
	
	int xoff, yoff,xoff2, yoff2;
	ad = 0.0;
	s2=66;
	dst = 0.0;
	for(x = 0;x < nextno;x++){
		xoff = x*lenseq;
		for (y = x+1; y<=nextno; y++){
		   yoff = y*lenseq;
		   count = 0;
		   valid = 0;
		   for (z = 1; z < lenseq; z++){
			   s1 = seqnum [z + xoff];
			   if (s1 != 46){
					if (s1 == seqnum [z + yoff]){
				   
						valid = valid+1;
				   }
					else if (seqnum [z + yoff] != 46){
							valid = valid +1;
							count=count+1;
						}
			   }
		   
		   }    
		   count2 = count;
		   valid2 = valid;
		   //return(valid2);
		   if (valid2 > 0)
				dst = (valid2 - count2)/valid2;
		   else
			   dst = 0.0;
			
		   xoff2 = x*(nextno+1);
		   yoff2 = y*(nextno+1);
		   distance[x + yoff2]= (float)(dst);
		   distance[y + xoff2] = (float)(dst);
		   validx [x + yoff2]= (float)(valid);
		   validx [y + xoff2]= (float)(valid);
		   diffsx [x + yoff2]= (float)(count);
		   diffsx [y + xoff2]= (float)(count);
		   ad = ad + (1.0 - dst);
		   if(dst < upper)
			   upper = dst;
		}
	   upper = (double)(1 - dst);
	}
	*avdst = ad; 
	return(upper);
}


double FAR pascal TransferDist(int NSeqs, int cr, int Reps, float *tFMat, float *DstMat){

		int Z,A, off0, off1, off2, off3, off4, off5;
		off0 = Reps+1;
		off1 = NSeqs+1;
		off2 = off0*off1;
		
		for (Z = 0; Z < NSeqs; Z++){
			off4 = Z*off2;
			off3 = Z*off1;
			
			for (A = Z + 1; A <= NSeqs; A++){
					off5 = A*off1;
                    tFMat[Z + off5] = DstMat[cr + A*off0 + off4];
                    tFMat[A + off3] = tFMat[Z + off5];
			}
		}
	return (1);
}



double FAR pascal FastDistA(int ISDim, int Nextno, int UBX, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB)
{

	int X,A, Y, B, C, Valid, Diffs;	
    double dX, v1, d1;    
    int off2, off1, off3;    
	for (X = 0; X <= Nextno; X++){
        
		off1 = (ISDim+1)*X;
		for (A = 1; A <= UBX; A++)
			
			XCVal[A] = IntegerSeq[A + off1];
		
		
		for (Y = X + 1; Y <= Nextno; Y++){
                Valid = 0;
                Diffs = 0;
				off2 = (ISDim+1)*Y;
                for (A = 1; A <= UBX; A++){
                    
                    
                    C = IntegerSeq[A+off2];
                   
                    B = XCVal[A]; 
                    
                    off3 = B+626*C;
                    Valid = Valid + CompressValid[off3];
                    
					if (B != C) 
                        
                        Diffs = Diffs + CompressDiffs[off3];
                        
                    
                }
				v1 = (double)(Valid);
				d1 = (double)(Diffs);
                if (v1 > 0)
					dX = double(d1 / v1);
                else
					dX = 3.0;

                DistCheckB[X + Y*(Nextno+1)] = (float)(dX);
                DistCheckB[Y + X*(Nextno+1)] = (float)(dX);
		}
	}


	return(1);
}


int FAR pascal ExtraRemovals(int Nextno, int UBF, int UBS, int *ISeqs, int *ExtraRemove, float *FMat, float *SMat){

	int MaxRemove, Z, X, Y, osf, oss, WinX;

	osf=UBF+1;
	oss=UBS+1;

	for (Z = 0; Z <= Nextno; Z++){
        if (FMat[Z + Z*osf] < 3){
			for (X = 0; X<= Nextno; X++)
				ExtraRemove[X] = 0;
        
       
			for (X = 0; X<= Nextno; X++){
                
				if (FMat[X + X*osf] < 3){
					for (Y = X + 1; Y <= Nextno; Y++){
						if (FMat[Y + Y*osf] < 3){
							if (FMat[X + Y*osf] >= 3){
								ExtraRemove[X] = ExtraRemove[X] + 1;
								ExtraRemove[Y] = ExtraRemove[Y] + 1;
							}
               
							if (SMat[X + Y*oss] >= 3){
								ExtraRemove[X] = ExtraRemove[X] + 1;
								ExtraRemove[Y] = ExtraRemove[Y] + 1;
							}
						}
					}
				}
            
			}
        
			MaxRemove = 0;
        
			WinX = -1;
			for (X = 0; X<= Nextno; X++){
				if (FMat[X + X*osf] < 3){
					if (ExtraRemove[X] > MaxRemove){
						if (X != ISeqs[0] && X != ISeqs[1] && X != ISeqs[2]){
               
							   MaxRemove = ExtraRemove[X];
							   WinX = X;
                      
						}
               
					}
				}
			}
			if (WinX == -1) 
				break;
       
			if (MaxRemove > 0){
				FMat[WinX + WinX*osf] = float(3.0);
				SMat[WinX + WinX*oss] = float(3.0);
			}
		}
        
	}

	return(1);
}

int FAR pascal ExtraRemovals2(int Nextno, int UBF, int UBS, int *ISeqs, int *ExtraRemove, float *FMat, float *SMat){

	int MaxRemove, Z, X, Y, osf, oss, WinX, osx;

	osf=UBF+1;
	oss=UBS+1;


	WinX = 0;

	for (X = 0; X<= Nextno; X++)
				ExtraRemove[X] = 0;
        
       
	for (X = 0; X < Nextno; X++){
        osx = X*osf;
		if (FMat[X + osx] < 3){
			for (Y = X + 1; Y <= Nextno; Y++){
				if (FMat[Y + Y*osf] < 3){
					if (FMat[Y + osx] >= 3){
						ExtraRemove[X] = ExtraRemove[X] + 1;
						ExtraRemove[Y] = ExtraRemove[Y] + 1;
					}
       
					if (SMat[Y + osx] >= 3){
						ExtraRemove[X] = ExtraRemove[X] + 1;
						ExtraRemove[Y] = ExtraRemove[Y] + 1;
					}
				}
			}
		}
    
	}


	for (Z = 0; Z <= Nextno; Z++){
        if (FMat[Z + Z*osf] < 3){
			
        
			MaxRemove = 0;
        
			WinX = -1;
			for (X = 0; X<= Nextno; X++){
				if (FMat[X + X*osf] < 3){
					if (ExtraRemove[X] > MaxRemove){
						if (X != ISeqs[0] && X != ISeqs[1] && X != ISeqs[2]){
               
							   MaxRemove = ExtraRemove[X];
							   WinX = X;
                      
						}
               
					}
				}
			}
			if (WinX == -1) 
				break;
       
			if (MaxRemove > 0){
				FMat[WinX + WinX*osf] = float(3.0);
				SMat[WinX + WinX*oss] = float(3.0);
			}

			//Update extraremove
			osx = WinX*osf;
			//if (FMat[X + osx] < 3){
			for (Y = 0; Y <= Nextno; Y++){
				if (FMat[Y + Y*osf] < 3 && WinX != Y){
					if (FMat[Y + osx] >= 3){
						ExtraRemove[X] = ExtraRemove[X] - 1;
						ExtraRemove[Y] = ExtraRemove[Y] - 1;
					}
   
					if (SMat[Y + osx] >= 3){
						ExtraRemove[X] = ExtraRemove[X] - 1;
						ExtraRemove[Y] = ExtraRemove[Y] - 1;
					}
				}
			}

		}

		
			//}
    
		//}


        
	}

	return(1);
}


int FAR pascal TestPerms(int LSub, int UBCH1, int UBCH2, int UBCR1, int UBVSM1, int UBVSM2, float *HigherMat, float *LowerMat, int *VSitesMatP, int *VSitesMat, float *ChiResult,float *ChiResultP, int *ChiHigher){
	int X, Y, Z, cro, cho1, cho2, os1, vsmo1, vsmo2, os2, os3, inc1, inc2, inc3, inc4, inc5;
	cro = UBCR1+1;
	cho1 = UBCH1+1;
	cho2 = cho1*(UBCH2+1);
	vsmo1 = UBVSM1+1;
	vsmo2 = vsmo1*(UBVSM2+1);
	inc1 = vsmo2;
	inc2 = vsmo2*2;
	inc3 = vsmo2*3;
	inc4 = vsmo2*4;
	inc5 = vsmo2*5;

		
	for (X = 1; X < LSub; X++){
        
        for (Y = X + 1; Y <= LSub; Y++){
            os1 = X + Y*cro;
			
			if (ChiResultP[os1] >= ChiResult[os1])
                ChiHigher[os1] = ChiHigher[os1] + 1;
            
            os3 = X + Y*vsmo1;
			for (Z = 0; Z <= 3; Z++){
                os2 = os3 + Z*vsmo2;
                if (VSitesMatP[os2] >= VSitesMat[os2])
                    HigherMat[os2] = HigherMat[os2] + 1;
                
                if (VSitesMatP[os2] <= VSitesMat[os2])
                    LowerMat[os2] = LowerMat[os2] + 1;
                
            }
            if (VSitesMatP[os3] + VSitesMatP[os3 + inc3] >= VSitesMat[os3] + VSitesMat[os3+inc3])
                HigherMat[os3 + inc4] = HigherMat[os3 + inc4] + 1;
           
            if (VSitesMatP[os3 + inc1] + VSitesMatP[os3 + inc2] >= VSitesMat[os3 + inc1] + VSitesMat[os3 + inc2])
                HigherMat[os3 + inc5] = HigherMat[os3 + inc5] + 1;
            
            if (VSitesMatP[os3] + VSitesMatP[os3 + inc3] <= VSitesMat[os3] + VSitesMat[os3 + inc3])
                LowerMat[os3 + inc4] = LowerMat[os3 + inc4] + 1;
            
            if (VSitesMatP[os3 + inc1] + VSitesMatP[os3 + inc2] <= VSitesMat[os3 + inc1] + VSitesMat[os3 + inc2])
                LowerMat[os3 + inc5] = LowerMat[os3 + inc5] + 1;
            
		}
    }
	return(1);
}


int FAR pascal TestPerms2(int LSub, int UBCH1, int UBCH2, int UBCR1, int UBVSM1, int UBVSM2, float *HigherMat, float *LowerMat, int *VSitesMatP, int *VSitesMat, float *ChiResult,float *ChiResultP, int *ChiHigher, float *TN){
	int X, Y, Z, cro, cho1, cho2, os1, vsmo1, vsmo2, os2, os3, inc1, inc2, inc3, inc4, inc5, os4, os5, os6;
	float TotNucs,TV1;
	cro = UBCR1+1;
	cho1 = UBCH1+1;
	cho2 = cho1*(UBCH2+1);
	vsmo1 = UBVSM1+1;
	vsmo2 = vsmo1*(UBVSM2+1);
	inc1 = vsmo2;
	inc2 = vsmo2*2;
	inc3 = vsmo2*3;
	inc4 = vsmo2*4;

	inc5 = vsmo2*5;
	
	for (X = 1; X < LSub; X++){
        
        for (Y = X + 1; Y <= LSub; Y++){
            os1 = X + Y*cro;
			
			//if (ChiResultP[os1] >= ChiResult[os1])
            //    ChiHigher[os1] = ChiHigher[os1] + 1;
            
            os3 = X + Y*vsmo1;
			//for (Z = 0; Z <= 3; Z++){
            os2 = os3 + inc3;
            if (VSitesMatP[os3] >= VSitesMat[os3])
                HigherMat[os3] = HigherMat[os3] + 1;
			if (VSitesMatP[os2] >= VSitesMat[os2])
                HigherMat[os2] = HigherMat[os2] + 1;
            //}


			TotNucs = (VSitesMatP[os3] + VSitesMatP[os3+inc1] + VSitesMatP[os3+inc2] + VSitesMatP[os2]) / 2;
            TV1 = fabs((float)(VSitesMatP[os3]) - TotNucs) + fabs((float)(VSitesMatP[os2]) - TotNucs);
            
            if (TV1 <= TN[os3])
                 HigherMat[os3 + inc4] = HigherMat[os3 + inc4] + 1;
            
            
            if (VSitesMatP[os3] + VSitesMatP[os3 + inc3] >= VSitesMat[os3] + VSitesMat[os3+inc3])
                HigherMat[os3 + inc4] = HigherMat[os3 + inc4] + 1;
           
            if (VSitesMatP[os3 + inc1] + VSitesMatP[os3 + inc2] >= VSitesMat[os3 + inc1] + VSitesMat[os3 + inc2])
                HigherMat[os3 + inc5] = HigherMat[os3 + inc5] + 1;
            
            //if (VSitesMatP[os3] + VSitesMatP[os3 + inc3] <= VSitesMat[os3] + VSitesMat[os3 + inc3])
             //   LowerMat[os3 + inc4] = LowerMat[os3 + inc4] + 1;
            
            //if (VSitesMatP[os3 + inc1] + VSitesMatP[os3 + inc2] <= VSitesMat[os3 + inc1] + VSitesMat[os3 + inc2])
            //    LowerMat[os3 + inc5] = LowerMat[os3 + inc5] + 1;
            
		}
    }
	return(1);
}


int FAR pascal ModMatPic(int cAddj, int SY, int SX, float XAD, int PosE0, int PosE1, int UBMP, int UBMC, float *MatPic, char *MatrixC)

{
	int Y, X, os1,os2, os3, os4, XP, YP, NS;
	os1=UBMC+1;
	os2 =UBMP+1;
	os3 = 0;
	os4 = 0;
	NS=0;
	for (Y = SY; Y <= PosE1; Y++){
		YP = (int)(Y * XAD + 0.001);
		os3 = YP*os2;
		os4 = Y*os1;
		for (X = SX; X <= PosE0; X++){
                
            if (MatrixC[X + os4] == 1){
                XP = (int)(X * XAD + 0.001);
                MatPic[XP+ os3] = MatPic[XP+ os3] + cAddj;
				//if (MatPic[XP+ os3] > NS) 
				//	NS=(int)(MatPic[XP+ os3]);
            }
		}
	}
	return(1);
}

int FAR pascal ModMatPicTB(int cAddj, int SY, int SX, float XAD, int PosE0, int PosE1, int UBMP, int UBMC, float *MatPic, char *MatrixC)

{
	int Y, X, os1,os2, os3, os4, XP, YP, NS;
	os1=UBMC+1;
	os2 =UBMP+1;
	os3 = 0;
	os4 = 0;
	NS=0;
	for (Y = SY; Y <= PosE1; Y++){
		YP = (int)(Y * XAD + 0.001);
		os3 = YP*os2;
		os4 = Y*os1;
		for (X = SX; X <= PosE0; X++){
                
            //if (MatrixC[X + os4] == 1){
                XP = (int)(X * XAD + 0.001);
                MatPic[XP+ os3] = (float)(MatPic[XP+ os3] + MatrixC[X + os4]);
				//if (MatPic[XP+ os3] > NS) 
				//	NS=(int)(MatPic[XP+ os3]);
            //}
		}
	}
	return(1);
}


int FAR pascal MatCToMatPic(int SX, int SY, int PosE0, int PosE1, int UBMP, int UBMC, float *MatPic, char *MatrixC){
	int X, Y, os1,os2, os3, os4;
	os1=UBMP+1;
	os2=UBMC+1;
	
	for (Y = SY; Y <= PosE1; Y++){
		os3 = os1*Y;
		os4 = os2*Y;
		for (X = SX; X <= PosE0; X++){
        
            if (MatrixC[X + os4] == 1)
                MatPic[X + os3] = 255;
            
        }
	}
	return(1);
}

int FAR pascal MatCToMatPicTB(int SX, int SY, int PosE0, int PosE1, int UBMP, int UBMC, float *MatPic, char *MatrixC){
	int X, Y, os1,os2, os3, os4;
	os1=UBMP+1;
	os2=UBMC+1;
	
	for (Y = SY; Y <= PosE1; Y++){
		os3 = os1*Y;
		os4 = os2*Y;
		for (X = SX; X <= PosE0; X++){
        
            //if (MatrixC[X + os4] == 1)
                MatPic[X + os3] = MatrixC[X + os4];
            
        }
	}
	return(1);
}


int FAR pascal MakeTrpListLen (int X, int UB1, int *TripListLen, short int *AnalysisList, int *DoubListLen, short int *DoubList, short int *SVx, short int *SDx, short int *AlistTrace, float *Distance)
{
	
	int v, B, Z, Y, A, off1, tll, tll3, dll;
	float DVXY, DVXZ;
	v = 1;
	off1 = UB1+1;
    tll = *TripListLen;
	dll = *DoubListLen;
    do{
        Y = DoubList[v*2];
        
        A = AlistTrace[Y];
        if (SVx[A] > 50){
            
            DVXY = ((float)SDx[A]) / (float)(SVx[A]);
            Z = DoubList[1 + v*2];
            B = AlistTrace[Z];
            
			if (SVx[B] > 50){
                    DVXZ = (float)(SDx[B]) / (float)(SVx[B]);
                    
                    if (DVXY > DVXZ){
                        
                        if (1 - Distance[X + Y*off1] < 1 - Distance[X + Z*off1]){
                           
                                tll++;
                                tll3 = tll*3;
                                AnalysisList[0 + tll3] = X;
                                AnalysisList[1 + tll3] = Y;
                                AnalysisList[2 + tll3] = Z;
                                if (v < dll){
                                     DoubList[v*2] = DoubList[dll*2];
                                     DoubList[1 + v*2] = DoubList[1 + dll*2];
								}
								else{
                                     dll--;
                                     break;
								}
                                 dll--;
                                 v--;
						}
					}
					else if (DVXY < DVXZ){
                        
                        if (1 - Distance[X +  Y*off1] > 1 - Distance[X + Z*off1]){
                           

                                tll++;
                                tll3 = tll*3;
                                AnalysisList[0 + tll3] = X;
                                AnalysisList[1 + tll3] = Y;
                                AnalysisList[2 + tll3] = Z;
                                if (v < dll){
                                     DoubList[v*2] = DoubList[dll*2];
                                     DoubList[1 + v*2] = DoubList[1 + dll*2];
								}
								else{
                                     dll--;
                                     break;
								}
                                 dll--;
                                 v--;
						}
                    }
			}
               
        }
        v++;
        
        if (v > dll) 
			break;
    }while (v <= dll);

	*TripListLen = tll;
	*DoubListLen = dll;


	return(1);

}




double FAR pascal FastSimilarityA(int ISDim, int Nextno, int UBX, double *avdst, float *diffsx,float *validx, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB, short int *redodist)
{

	int X,A, Y, B, C, Valid, Diffs;	
    double dX, v1, d1, upper, ad;   
	
	upper = 0.0;
	ad = 0.0;
    int off2, off1, off3, o3,o4;    
	for (X = 0; X <= Nextno; X++){
        
		off1 = (ISDim+1)*X;
		for (A = 1; A <= UBX; A++)
			
			XCVal[A] = IntegerSeq[A + off1];
		
		
		for (Y = X + 1; Y <= Nextno; Y++){
			if (redodist[X]+redodist[Y] > 0){//if neither of the redodist scores is -1 and one or the other is 1 then the distance will be calculated
				Valid = 0;
                Diffs = 0;
				off2 = (ISDim+1)*Y;
                for (A = 1; A <= UBX; A++){
                    
                    
                    C = IntegerSeq[A+off2];
                   
                    B = XCVal[A]; 
                    
                    off3 = B+626*C;
                    Valid = Valid + CompressValid[off3];
                    
					if (B != C) 
                        
                        Diffs = Diffs + CompressDiffs[off3];
                        
                    
                }
				v1 = (double)(Valid);
				d1 = (double)(Diffs);
                if (v1 > 0)
					dX = (double)((v1-d1) / v1);
                else
					dX = 0.0;
				o3 = X + Y*(Nextno+1);
				o4 = Y + X*(Nextno+1);
                DistCheckB[o3] = (float)(dX);
                DistCheckB[o4] = (float)(dX);
				validx [o3]= (float)(v1);
			   validx [o4]= (float)(v1);
			   diffsx [o3]= (float)(d1);
			   diffsx [o4]= (float)(d1);
			   ad = ad + (1.0 - dX);
			   if(dX < upper)
				upper = dX;
			}

		}
	}

	*avdst = ad; 
	return(upper);
}

double FAR pascal FastSimilarityI(int ISDim, int Nextno, int UBX, double *avdst, float *diffsx,float *validx, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB, short int *redodist)
{

	int X,A, Y, B, C, Valid, Diffs, minvalid;	
    double dX, v1, d1, upper, ad;   
	float maxid, minid;
	upper = 0.0;
	ad = 0.0;
	minvalid = (int)(0.9*UBX);
	maxid = (float)(0.95);
	minid = (float)(0.9);
    int off2, off1, off3, o3,o4, o5, o6;    
	for (X = 0; X <= Nextno; X++){
        
		off1 = (ISDim+1)*X;
		for (A = 1; A <= UBX; A++)
			
			XCVal[A] = IntegerSeq[A + off1];
		
		
		for (Y = X + 1; Y <= Nextno; Y++){
			if (redodist[X]+redodist[Y] > 0){//if neither of the redodist scores is -1 and one or the other is 1 then the distance will be calculated
				Valid = 0;
                Diffs = 0;
				off2 = (ISDim+1)*Y;
                o3 = X + Y*(Nextno+1);
				if (validx [o3] == 0.0){
					for (A = 1; A <= UBX; A++){
                    
                    
						C = IntegerSeq[A+off2];
                   
						B = XCVal[A]; 
                    
						off3 = B+626*C;
						Valid = Valid + CompressValid[off3];
                    
						if (B != C) 
                        
							Diffs = Diffs + CompressDiffs[off3];
                        
                    
					}
					v1 = (double)(Valid);
					d1 = (double)(Diffs);
					if (v1 > 0)
						dX = (double)((v1-d1) / v1);
					else
						dX = 0.0;
					
					o4 = Y + X*(Nextno+1);
					DistCheckB[o3] = (float)(dX);
					DistCheckB[o4] = (float)(dX);
					validx [o3]= (float)(v1);
				   validx [o4]= (float)(v1);
				   diffsx [o3]= (float)(d1);
				   diffsx [o4]= (float)(d1);
				   ad = ad + (1.0 - dX);
				   if(dX < upper)
					upper = dX;
				}
			}

		}
		for (Y = X + 1; Y <= Nextno; Y++){
			
			if (redodist[X]+redodist[Y] > 0){
				o5 = X + Y*(Nextno+1);
				if (DistCheckB[o5] > maxid){
					for (A = 0; A <= Nextno; A++){
						o6 = A + X*(Nextno+1);
						if (DistCheckB[o6] < minid){
							o3 = A + Y*(Nextno+1);
							o4 = Y + A*(Nextno+1);
							if (validx [o3]==0.0){

								DistCheckB[o3] = DistCheckB[o5];
								DistCheckB[o4] = DistCheckB[o5];
								validx [o3]= validx [o5];
							    validx [o4]= validx [o5];
							    diffsx [o3]= diffsx [o5];
							    diffsx [o4]= diffsx [o5];
								
							}
						}
					}
				}
			}
		}
	}

	*avdst = ad; 
	return(upper);
}
double FAR pascal FastSimilarityB(int df, int reps, int ISDim, int Nextno, int UBX,float *Valid, float *Diffs, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB, int *weightmod)
{

	int  X,A, Y, B, C, E, off5,off2, off1, off3, o3,o4, off6, off7;	
    double dX, v1, d1,  th2, th3;   
	
	off6 = reps+1;
	off7 = (Nextno+1)*(reps+1);
      
	for (X = 0; X <= Nextno; X++){
        
		off1 = (ISDim+1)*X;
		for (A = 1; A <= UBX; A++)
			XCVal[A] = IntegerSeq[A + off1];
		
		
		for (Y = X + 1; Y <= Nextno; Y++){
			for (E = 0; E <= reps; E++){
					Valid[E] = 0;
					Diffs[E] = 0;
			}
			off2 = (ISDim+1)*Y;
			for (A = 1; A <= UBX; A++){
            
            
				C = IntegerSeq[A+off2];
				B = XCVal[A]; 
            
				off3 = B+626*C;
				off5 = (reps+1)*(A-1);
            
				
				
				for (E = df; E <= reps; E++)
					Valid[E] = Valid[E] + weightmod[E+off5]*CompressValid[off3];
            
				if (B != C) {
				    for (E = df; E <= reps; E++)
						Diffs[E] = Diffs[E] + weightmod[E+off5]*CompressDiffs[off3];
                
				}
			}
			for (E = df; E <= reps; E++){
				
				
				v1 = (double)(Valid[E]);
				d1 = (double)(Diffs[E]);
				if (v1 > 0){
					dX = (double)((v1-d1) / v1);
					if (dX > 0.25){
						th2 = (4.0 * dX - 1.0) / 3.0;
						th3 = log(th2);
						dX = -0.75*th3;
					}
					else
						dX = 10.0;
				}
				else
					dX = 10.0;

				o3 = E + X*off6 + Y*off7;
				o4 = E + Y*off6 + X*off7;
				DistCheckB[o3] = (float)(dX);
				DistCheckB[o4] = (float)(dX);
			}
				
		   
		}

		
	}

	 
	return(1);
}

int FAR pascal GetSeqXPos(int UBND1, int UBND2, int CCount, int NumberOfSeqs, short int *NodeDepth, short int *Done, float *NodeXPos, float *LLen, float *SeqXPos, float *NameXPos)
{
	int X,Y,Z,A, os1;
	os1 = UBND1+1;
	for (X = 0; X <= CCount + 1; X++){
        //ReDim Done(NumberOfSeqs + 1)
		for (Y=0; Y <= NumberOfSeqs; Y++)
			Done[Y]=0;
        for (Y = CCount + 1; Y >= X; Y--){
            if (Y <= UBND1){
                for (Z = 0; Z <= NumberOfSeqs; Z++){
                    if (NodeDepth[X +os1*Z] == -1)
						break;
                    if (NodeDepth[X + os1*Z] == NodeDepth[Y]){
                        NodeXPos[Y] = NodeXPos[Y] + LLen[X];
                        A = 0;
                        if (A <= UBND2){
                            do { 
        
                                if (Done[NodeDepth[Y+A*os1]] == 0){
                                        
                                    SeqXPos[NodeDepth[Y+A*os1]] = SeqXPos[NodeDepth[Y+A*os1]] + LLen[X];// '0,1,8
                                        
                                    if (LLen[X] > 0)
                                        NameXPos[NodeDepth[Y+A*os1]] = NameXPos[NodeDepth[Y+A*os1]] + LLen[X];
                                    
                                    Done[NodeDepth[Y+A*os1]] = 1;
                                }
        
                                A++;
                                if (A > UBND2) 
									break;
                                
                            }while (NodeDepth[Y + A*Z] != -1);
                        }
                        break;
                    }
                
                }
            }
        }

    }
	return(1);
}

int FAR pascal MakeTreeD(int UBTD, int UBND, int UBSB, int NumberOfSeqs, float *LLen, float *TreeD, float  *SeqXPos, short int *NodeDepth, short int *SepBranch)
{
	int X, Y, Z, os1, os2, os3, hld;
	int CurS;
	float dhold;
	dhold= (float)(0.0);
	os1 = UBTD+1;
	os2 = UBND+1;
	os3 = UBSB+1;
	hld = 0;
	//Do terminal branch lengths
    for (X = 0; X <= NumberOfSeqs; X++){
        for (Y = X + 1; Y <= NumberOfSeqs; Y++){
			dhold = TreeD[X + Y*os1] + SeqXPos[X] + SeqXPos[Y];
            TreeD[X + Y*os1] = dhold;
            TreeD[Y + X*os1] = dhold;
        }
    }
    
	//Add internal branch lengths
    
    
    
    for (X = 0; X <= NumberOfSeqs; X++){
		for (Z = 0; Z<= NumberOfSeqs; Z++){
			if (SepBranch[X + Z*os3] == 0){
				for (Y = 0; Y <= NumberOfSeqs; Y++){
					if (NodeDepth[X + Y*os2] > -1){
						CurS = NodeDepth[X + Y*os2];
						if(CurS <= UBTD){
							
							TreeD[CurS + Z*os1] = TreeD[CurS + Z*os1] + LLen[X];
							TreeD[Z + CurS*os1] = TreeD[CurS + Z*os1];//TreeD[Z + CurS*os1] + LLen[X];
                        
						}
					}
					else
						break;

				}
			}
		}

	
	}


	return(1);
}

int FAR pascal ClearNumTaxa(int NC, int Nextno, int *NumTaxa)
{
	int Z;
	for (Z = NC; Z<= Nextno; Z++)
            NumTaxa[Z] = 0;
        
	return(1);

}

int FAR pascal MakeSeqCoverageC(int SF, int Nextno, int UBSV, int UBTTS, int UBSC, float *SubValid, float *SeqCoverage, int *TreeTraceSeqs, int *TreeTrace){
	float MaxCoverage;
	int NextnoX, A, B, X, Y, os1, os2;

	MaxCoverage = 0;
    if (SF == 0)
        NextnoX = UBTTS;
    else
        NextnoX = Nextno;
    
    os1 = 2;
	os2 = UBSV+1;
    for (A = 0; A <= Nextno; A++){
        for (B = A + 1; B <= Nextno; B++){
            if (SF == 0){
                X = TreeTraceSeqs[1 + A*os1];
                Y = TreeTraceSeqs[1 + B*os1];
			}
            else{
                X = A;
                Y = B;
            }
            if (X != Y){
                if (SubValid[X + Y*os2] > SeqCoverage[A]){
                    SeqCoverage[A] = SubValid[X + Y*os2];
                    if (SubValid[X + Y*os2] > MaxCoverage)
                        MaxCoverage = SubValid[X + Y*os2];
                    
                }
                if (SubValid[X + Y*os2] > SeqCoverage[B])
                    SeqCoverage[B] = SubValid[X + Y*os2];
                
            }
        }
    }
    for (X = 0; X <= UBSC; X++){
        if (MaxCoverage > 0){
			SeqCoverage[X] = SeqCoverage[X] / MaxCoverage;
			if (SeqCoverage[X] > 1)
				SeqCoverage[X] = 1;
		} 
		else
			SeqCoverage[X] = 0;
     
	}
	return(1);
}


int FAR pascal EmptyNodeFind(int PermNextno, int UBNF, int UBNMR, unsigned char *NodeFind, float *NodeMaxRep){
	int X, Y, os1, os2, os3;
	os1 = UBNF+1;
	os3 = UBNMR+1;
	for (X = 0; X <= PermNextno; X++){
        os2 = X*os1;
		
		for (Y = 0; Y <= PermNextno; Y++)
             NodeFind[Y+os2] = 0;
         
         NodeMaxRep[X] = 0;
         NodeMaxRep[X + os3] = 0;
	}

	
	return(1);
}



int FAR pascal FillNodeMaxRep(int TType, int PermNextno, int Nextno, int ubnf, int ubtrx, int ubtry, int ubtts, int ubtt, int ubsc, float *NodeMaxRep ,char *NodeFind, short int *TreeRY, short int *TreeRX, float *SeqCoverage, int *TreeTraceSeqs, int *TreeTrace){


	int X, Y, os1, os2, os3, os4, os5, u, G,sn;
	int trx;
	float sc;
//	'nodemaxrep = single with dims (permnextno+10,1)
//        'nodefind is byte with dims ubnf,ubnf
//        'treerx = integer with dims ubtrx,ubtrx
//        'treery = integer with dims ubtry
//        'seqcoverage = float
//        'treetraceseqs = long with dims 1,ubtts
//        'treetrace = long with dim ubtt
	os1 = ubnf+1;
	os2 = PermNextno+11;
	os3 = ubtrx+1;
	os4 = ubnf+1;
	os5 = 2;
	sn=0;
	for (X = 0; X <= PermNextno; X++){
		for (Y = 0; Y <= PermNextno; Y++)
			NodeFind[X + Y*os1] = 0;
      
        NodeMaxRep[X] = 0;
        NodeMaxRep[X+os2] = 0;
	}
        
        
	for (X = 0; X <= Nextno; X++){
           
            
		for (Y = 0; Y <= Nextno; Y++){
                
            trx = TreeRX[X + Y*os3];   
			if (trx > -1){
                    
				if (TType == 0){//move this outside the loop
					NodeFind[X  + ubnf*trx] = 1;

                    if (X <= ubnf){
						sc = SeqCoverage[trx];
                        if (NodeMaxRep[X] < sc) 
							NodeMaxRep[X] = sc;
                        if (NodeMaxRep[X + os2] < sc) 
							NodeMaxRep[X +os2] = sc;
                    }
				}
                else{
					sn = TreeTrace[TreeTraceSeqs[1 + trx*os5]];
					if (trx <= ubtts && sn <= ubnf) {
						NodeFind[X + os4*sn] = 1;
                            
                            
                        //find out whether "y" is on the upper or lower branch
                        u = 0;
                        for (G = 0; G <= Y; G++){
                            if (TreeRX[X + G*os3] == TreeRY[X]){
                                u = 1;
                                break;
                            }
                        }
                        
                        if (u == 0){
                            if (X <= ubnf){
                                if (sn <= ubsc){
                                    
                                    if (NodeMaxRep[X] < SeqCoverage[trx])
										NodeMaxRep[X] = SeqCoverage[trx];
                                }
                            }
						}
                        else{
                            if (X <= ubnf){
                                
                                if (sn <= ubsc){
                                    
                                    if (NodeMaxRep[X + os2] < SeqCoverage[trx])
										NodeMaxRep[X + os2] = SeqCoverage[trx];
                                }
                            }
                        }
					}
				}
			}
            else
				break;
               
		}
	}
	return(1);
}


int FAR pascal StartBlock(int D, int X, int UBMD, int LSeq, unsigned char *MissingData){
	int d, off;
	d=D;
	off = (UBMD+1)*X;
	while(d<LSeq){
        if (MissingData[d + off] == 0) 
			break;
        d = d + 1;
        
    }

	return(d);
}


int FAR pascal MakeSC14(int X, int *y,int UBN14, int UBIS14,short int *ISeq14, short int *SeqCompressor14, unsigned char *Nuc14){
	int StepPos, A,B,C,D,Y, off1, off2;
	StepPos = 0;
    off1 = UBN14+1;  
	off1 = off1*X;  
	off2 = UBIS14+1;
	off2 = off2*X;
	for (Y = 1; Y <= UBN14 - 4; Y = Y + 4){
        StepPos = StepPos + 1;
		
		A = Nuc14[Y + off1];
        B = Nuc14[Y + 1 + off1];
        C = Nuc14[Y + 2 + off1];
        D = Nuc14[Y + 3 + off1];
        
        ISeq14[StepPos + off2] = SeqCompressor14[A + B*5 + C*25 + D*125];
    }
	*y=Y;
	return(StepPos);
}

int FAR pascal MakeSC13(int X, int *y, int UBN13, int UBIS13,short int *ISeq13, short int *SeqCompressor13, unsigned char *Nuc13){
	int StepPos, A,B,C,D,E,Y, off1, off2;
	StepPos = 0;
    off1 = UBN13+1;  
	off1 = off1*X;  
	off2 = UBIS13+1;
	off2 = off2*X;
	for (Y = 1; Y <= UBN13 - 5; Y = Y + 5){
        StepPos = StepPos + 1;
		
		A = Nuc13[Y + off1];
        B = Nuc13[Y + 1 + off1];
        C = Nuc13[Y + 2 + off1];
        D = Nuc13[Y + 3 + off1];
        E = Nuc13[Y + 4 + off1];
        
        ISeq13[StepPos + off2] = SeqCompressor13[A + B*4 + C*16 + D*64 + E*256];
    }
	*y=Y;
	return(StepPos);
}

int FAR pascal MakeSC04(int X,int *y, int UBN04, int UBIS04,short int *ISeq04, short int *SeqCompressor04, unsigned char *Nuc04){
	int StepPos, A,B,C,D,E,Y, off1, off2;
	StepPos = 0;
    off1 = UBN04+1;  
	off1 = off1*X;  
	off2 = UBIS04+1;
	off2 = off2*X;
	for (Y = 1; Y <= UBN04 - 5; Y = Y + 5){
        StepPos = StepPos + 1;
		
		A = Nuc04[Y + off1];
        B = Nuc04[Y + 1 + off1];
        C = Nuc04[Y + 2 + off1];
        D = Nuc04[Y + 3 + off1];
        E = Nuc04[Y + 4 + off1];
        
        ISeq04[StepPos + off2] = SeqCompressor04[A + B*4 + C*16 + D*64 + E*256];
    }
	*y=Y;
	return(StepPos);
}

int FAR pascal MakeSC11(int X, int *y,int UBN11, int UBIS11,short int *ISeq11, short int *SeqCompressor11, unsigned char *Nuc11){
	int StepPos, A,B,C,D,E,F,G,H,I,J,Y, off1, off2;
	StepPos = 0;
    off1 = UBN11+1;  
	off1 = off1*X;  
	off2 = UBIS11+1;
	off2 = off2*X;
	for (Y = 1; Y <= UBN11 - 10; Y = Y + 10){
        StepPos = StepPos + 1;
		
        A = Nuc11[Y + off1];
        B = Nuc11[Y + 1 + off1];
        C = Nuc11[Y + 2 + off1];
        D = Nuc11[Y + 3 + off1];
        E = Nuc11[Y + 4 + off1];
        F = Nuc11[Y + 5 + off1];
        G = Nuc11[Y + 6 + off1];
        H = Nuc11[Y + 7 + off1];
        I = Nuc11[Y + 8 + off1];
        J = Nuc11[Y + 9 + off1];
        ISeq11[StepPos + off2] = SeqCompressor11[A + B*2 + C*4 + D*8 + E*16 + F*32 + G*64 + H*128 + I*256 + J*512];
    }
	*y=Y;
	return(StepPos);
}

int FAR pascal MakeSC02(int X, int *y,int UBN02, int UBIS02,short int *ISeq02, short int *SeqCompressor02, unsigned char *Nuc02){
	int StepPos, A,B,C,D,E,F,G,H,I,J,Y, off1, off2;
	StepPos = 0;
    off1 = UBN02+1;  
	off1 = off1*X;  
	off2 = UBIS02+1;
	off2 = off2*X;
	for (Y = 1; Y <= UBN02 - 10; Y = Y + 10){
        StepPos = StepPos + 1;
		
        A = Nuc02[Y + off1];
        B = Nuc02[Y + 1 + off1];
        C = Nuc02[Y + 2 + off1];
        D = Nuc02[Y + 3 + off1];
        E = Nuc02[Y + 4 + off1];
        F = Nuc02[Y + 5 + off1];
        G = Nuc02[Y + 6 + off1];
        H = Nuc02[Y + 7 + off1];
        I = Nuc02[Y + 8 + off1];
        J = Nuc02[Y + 9 + off1];
        ISeq02[StepPos + off2] = SeqCompressor02[A + B*2 + C*4 + D*8 + E*16 + F*32 + G*64 + H*128 + I*256 + J*512];
    }
	*y=Y;
	return(StepPos);
}

int FAR pascal MakeSC12(int X, int *y,int UBN12, int UBIS12,short int *ISeq12, short int *SeqCompressor12, unsigned char *Nuc12){
	
       
           
	
	int StepPos, A,B,C,D,E,F, Y, off1, off2;
	StepPos = 0;
    off1 = UBN12+1;  
	off1 = off1*X;  
	off2 = UBIS12+1;
	off2 = off2*X;
	for (Y = 1; Y <= UBN12 - 6; Y = Y + 6){
        StepPos = StepPos + 1;
		
        A = Nuc12[Y + off1];
        B = Nuc12[Y + 1 + off1];
        C = Nuc12[Y + 2 + off1];
        D = Nuc12[Y + 3 + off1];
        E = Nuc12[Y + 4 + off1];
        F = Nuc12[Y + 5 + off1];
        
        ISeq12[StepPos + off2] = SeqCompressor12[A + B*3 + C*9 + D*27 + E*81 + F*243];
    }
	*y=Y;
	return(StepPos);
}

int FAR pascal MakeSC03(int X, int *y,int UBN03, int UBIS03,short int *ISeq03, short int *SeqCompressor03, unsigned char *Nuc03){
	
       
           
	
	int StepPos, A,B,C,D,E,F, Y, off1, off2;
	StepPos = 0;
    off1 = UBN03+1;  
	off1 = off1*X;  
	off2 = UBIS03+1;
	off2 = off2*X;
	for (Y = 1; Y <= UBN03 - 6; Y = Y + 6){
        StepPos = StepPos + 1;
		
        A = Nuc03[Y + off1];
        B = Nuc03[Y + 1 + off1];
        C = Nuc03[Y + 2 + off1];
        D = Nuc03[Y + 3 + off1];
        E = Nuc03[Y + 4 + off1];
        F = Nuc03[Y + 5 + off1];
        
        ISeq03[StepPos + off2] = SeqCompressor03[A + B*3 + C*9 + D*27 + E*81 + F*243];
    }
	*y=Y;
	return(StepPos);
}


int FAR pascal ReAddToRList(int Nextno, int UBTRL, int UBRL, int *tRList, int *RList, int *RNum){
	int Z, Y, off1, off2;
	off1 = UBTRL+1;
	off2 = UBRL+1;
	
	for (Z = 0; Z<= 2; Z++){
		for (Y = 0; Y<= Nextno; Y++){
			if (tRList[Z + Y*off1] == 1){
                RList[Z + RNum[Z]*off2] = Y;
                RNum[Z] = RNum[Z] + 1;
			}
		
		}
	}
	return(1);
}
int FAR pascal FillNucXX(int NXX, int Nextno, int X, int UBNXX, int UBFLP, unsigned char * NucXX, unsigned char *FLP){
	int Y,off1,osXX, off2, off3;
	off1 = UBFLP+1;
	osXX = UBNXX+1;
	off3=Nextno+1;
	off2 = X*off3;
	for (Y = 0; Y<= Nextno; Y++)
        NucXX[NXX + Y*osXX] = (unsigned char)(FLP[Y+off2]);

	return(1);
}

int FAR pascal MakeNucSets3(int UBFLP, int Nextno, int StartPosInAlign, int EndPosInAlign, int ub11,int ub12,int ub13,int ub14,int ub02,int ub03,int ub04, unsigned char *NL, unsigned char *ML, unsigned char *FLP, unsigned char *Nuc11, unsigned char *Nuc02, unsigned char *Nuc12, unsigned char *Nuc03, unsigned char *Nuc13, unsigned char *Nuc04, unsigned char *Nuc14){
	int LSeq, off1, X, Y, N02 , N03 , N04, N11 , N12 , N13 , N14, os11, os12, os13, os14, os02, os03, os04, off3, off2;
    N02 = 0;
	N03 = 0;
	N04 = 0;
    N11 = 0;
	N12 = 0;
	N13 = 0;
	N14 = 0;
    
	LSeq = UBFLP;
	
	os11 = ub11+1;
	os02 = ub02+1;
	os12 = ub12+1;
	os03 = ub03+1;
	os13 = ub13+1;
	os04 = ub04+1;
	os14 = ub14+1;
	
	off1 = UBFLP+1;
    off3=Nextno+1;
	
	X = StartPosInAlign;

    while (X != EndPosInAlign+1){
        off2 = X*off3;
        if (ML[X] == 0){
            if (NL[X] == 2) {
                N02 = N02 + 1;
				//if (N02 > ub02)
				//	return(ub02);
                for (Y = 0; Y<= Nextno; Y++)
                    Nuc02[N02 + Y*os02] = (unsigned char)(FLP[Y + off2]);
                
			}
                
            else if (NL[X] == 3){
                N03 = N03 + 1;
                //if (N03 > ub03)
				//	return(ub03);
				for (Y = 0; Y<= Nextno; Y++)
                    Nuc03[N03 + Y*os03] = (unsigned char)(FLP[Y + off2]);
                
                
			}
            else if (NL[X] == 4){
                N04 = N04 + 1;
				//if (N04 > ub04)
				//	return(ub04);
                for (Y = 0; Y<= Nextno; Y++)
                    Nuc04[N04 + Y*os04] = (unsigned char)(FLP[Y + off2]);
                
                
            }
		}
        else{
            if (NL[X] == 1){
                N11 = N11 + 1;
				//if (N11 > ub11)
				//	return(ub11);
                for (Y = 0; Y<= Nextno; Y++)
                    Nuc11[N11 + Y*os11] = (unsigned char)(FLP[Y + off2]);
                
			}
            else if (NL[X] == 2){
                N12 = N12 + 1;
				//if (N12 > ub12)
				//	return(ub12);
                for (Y = 0; Y<= Nextno; Y++)
                    Nuc12[N12 + Y*os12] = (unsigned char)(FLP[Y + off2]);
			}
            else if (NL[X] == 3){
                N13 = N13 + 1;
				//if (N13 > ub13)
				//	return(ub13);
                for (Y = 0; Y<= Nextno; Y++)
                    Nuc13[N13 * Y*os13] = (unsigned char)(FLP[Y + off2]);
			}
            else if (NL[X] == 4){
                N14 = N14 + 1;
				//if (N14 > ub14)
				//	return(ub14);
                for (Y = 0; Y<= Nextno; Y++)
                    Nuc14[N14 + Y*os14] = (unsigned char)(FLP[Y + off2]);
			}
                
					
        
        }
        if (X == EndPosInAlign)
			break;

		X++;
		
        if (X > LSeq)
			X = 1;
		//if (X==EndPosInAlign-1 ||UBFLP > 10000)
		//	return(UBFLP);
        
    
    } 
	return(1);
}

int FAR pascal EndBlock(int C, int X, int UBMD, int LSeq, unsigned char *MissingData){
	int d, c, off;
	c=C;
	off = (UBMD+1)*X;
	while(c < LSeq){
        if (MissingData[c + off] == 1) {
           break;
        }
        c = c + 1;
        
    }
	if (c >= LSeq)
       d = LSeq;
    else        
       d = c - 1;
	return(d);
}


int FAR pascal ConvSimToDist(int SLen, int Nextno, int UBDistance, int UBPermvalid,  int UBFubvalid, int UBSubvalid,short int *RedoDist, float *Distance, float *FMat, float *SMat, float *PermValid, float *PermDiffs,  float *Fubvalid, float *Fubdiffs, float *SubValid, float *SubDiffs)
{

       double DistXY, ValidXY, TempVal1;
	   int X, Y, osUBP, osUBF, osUBS, osUBD, off1;
	   
	   osUBP = (UBPermvalid+1);
	   
	   osUBS = (UBSubvalid+1);
	   osUBF = (UBFubvalid+1);
	   osUBD = (UBDistance+1);
       //this changes similarities to JC distances - it needs to be done in c
       for (X = 0; X <= Nextno; X++){
		  
			off1 = osUBP*X;
		   for (Y = X + 1; Y <= Nextno;Y++){
                //do distance
			   if (RedoDist[X] + RedoDist[Y] > 0.000001){
                    DistXY = (double)(SubValid[Y + osUBS*X] + Fubvalid[Y + osUBF*X]);
				    PermValid[Y + off1] = (float)(DistXY);
					PermValid[X + osUBP*Y] = (float)(DistXY);
					
					DistXY = (double)(SubDiffs[Y + osUBS*X] + Fubdiffs[Y + osUBF*X]);
                    PermDiffs[Y + off1] = (float)(DistXY);
                    PermDiffs[X + osUBP*Y] = (float)(DistXY);

                    
                    if (PermDiffs[Y + osUBP*X] > 0){
						DistXY = (double)(PermDiffs[Y + osUBS*X]/PermDiffs[Y + osUBS*X]);
                        Distance[Y + osUBD*X] = (float)(DistXY);
						Distance[X + osUBD*Y] = (float)(DistXY);
					}
                    else{
                        Distance[Y + osUBD*X] = (float)(0.0);
						Distance[X + osUBD*Y] = (float)(0.0);
					}
                    
			   }
			   else{
                     
				   
                    DistXY = (double)(PermValid[Y + osUBP*X] - SubValid[Y + osUBS*X]);
					Fubvalid[Y + osUBF*X] = (float)(DistXY);
					Fubvalid[X + osUBF*Y] = (float)(DistXY);  

                    DistXY = (double)(PermDiffs[Y + osUBP*X] - SubDiffs[Y + osUBS*X]);
					Fubdiffs[Y + osUBF*X] = (float)(DistXY);
					Fubdiffs[X + osUBF*Y] = (float)(DistXY);  
                    
			   }
                //Do FMat
                ValidXY = (double)(Fubvalid[Y + osUBF*X]); //PermValidx(X, Y) - SubValid(X, Y)
                if (ValidXY > 0.0000001){
						DistXY = (double)((ValidXY - Fubdiffs[Y + osUBF*X]) / ValidXY);
						if (DistXY > 0.25){
								 TempVal1 = ((4 * DistXY - 1) / 3);
								 DistXY = (log(TempVal1));
								 DistXY = (-0.75 * DistXY);
						}
						else
						   DistXY = 10.0;
				}
		 
				else
                     DistXY = 10.0;
                
                FMat[Y + osUBF*X] = (float)(DistXY);
                FMat[X + osUBF*Y] = (float)(DistXY);
                
                //Do SMat
                ValidXY = (double)(SubValid[Y + osUBS*X]);
                if (ValidXY > 0.0000001){
                     DistXY = double((ValidXY - SubDiffs[Y + osUBS*X]) / ValidXY);
                     if (DistXY > 0.25){
                         TempVal1 = ((4 * DistXY - 1) / 3);
                         DistXY = (log(TempVal1));
                         DistXY = (-0.75 * DistXY);
					 }
                     else
                         DistXY = 10.0;
                     
				}
                else
                     DistXY = 10.0;
                
                SMat[Y + osUBS*X] = (float)(DistXY);
                SMat[X + osUBS*Y] = (float)(DistXY);
                
           }
       }
       
    
        
	   for (X = 0; X <= Nextno; X++){
            Distance[X + osUBD*X] = 1;
            FMat[X + osUBF*X] = 0;
            PermValid[X + osUBD*X] = (float)(SLen);
            if (X <= UBPermvalid)
                PermDiffs[X + osUBP*X] = 0;
            
            SubValid[X + osUBS*X] = (float)(SLen / 2);
            SubDiffs[X + osUBS*X] = 0;
	   }

	return(1);
}

int FAR pascal CleanSCMat (int Nextno, int UBFM, int UBFC, float *FCMat, float *SCMat, float *FMat){
	int X, Y, os, os2, os3, os4;
	float rv, nn;
	os= UBFC+1;
	os2 = UBFM +1;
	nn=(float)(Nextno);
	rv = (float)(((nn * 3) - 1) / 1000);

	for (X = 0; X <= Nextno; X++){
		if (FMat[X + X*os2] == 3){
			 os3 =  X*os;
             for (Y = 0; Y <= Nextno; Y++){
				 os4 = Y*os;
                 FCMat[X + os4] = rv;
                 FCMat[Y + os3] = rv;
                 SCMat[X + os4] = rv;
                 SCMat[Y + os3] = rv;
             }
		}
         
	}
    /* 
	for (X = 0; X <= Nextno; X++){
         For Y = X + 1 To Nextno
             FCMat(X, Y) = (CLng(FCMat(X, Y) * 10000000)) / 10000000
             FCMat(Y, X) = FCMat(X, Y)
             SCMat(X, Y) = (CLng(SCMat(X, Y) * 10000000)) / 10000000
             SCMat(Y, X) = SCMat(X, Y)
         Next Y
     }*/


	return(1);

}




double FAR pascal FastBootDistX(int df, int reps, int nextno,int lenseq,float *diffsx,float *validx,int *weightmod, short int *seqnum,float *distance)
{
	//weightmod - reps,len
	//distance -reps,nextno,nextno
	
	double th2,th3;
	
	double th1, dst;
	
	int a,s1, s2, x, y ,z, off1, off0, off3, os, v1, d1;
	
	int xoff, yoff;
	os=reps+1;
	s2=66;
	off0 = reps+1;
	off1 = (nextno+1)*(reps+1);
	for(x = 0;x < nextno;x++){
		xoff = x*(lenseq+1);
		for (y = x+1; y<=nextno; y++){
		   yoff = y*(lenseq+1);
		   
		  
		   for (a=df; a <=reps; a++){
				v1=0;
				d1=0;
				for (z = 1; z <= lenseq; z++){
				   s1 = seqnum [z + xoff];
				   
				   if (s1 != 46){

						if (s1 == seqnum [z + yoff]){
							off3=(os)*(z-1);
							v1 = v1 + weightmod[a + os*(z-1)];
					   }
						else if (seqnum [z + yoff] != 46){
							off3 = os*(z-1);
							v1 = v1 + weightmod[a + off3];
							d1 = d1 + weightmod[a + off3];
							
						}
				   }
				}
				validx[a] = (float)(v1);
				diffsx[a] = (float)(d1);
			   
		   } 
		   for (a = df; a <= reps; a++){
			  if (validx[a] > 0){
					th1= (double)(diffsx[a]);
					th2= (double)(validx[a]);
					dst = (th2-th1)/th2;
					//return(dst);
					if (dst > 0.25){
						th2 = (4.0 * dst - 1.0) / 3.0;
						th3 = log(th2);
						dst = -0.75*th3;
					}
					else 
						dst=10.0;

			   }

			   else
				   dst = 10.0;
				
			   
			   distance[a + x*off0 + y*off1] = (float)(dst);
			   distance[a + y*off0 + x*off1] = (float)(dst);
			   
		   }
		}
	   
	}

	return(1);
}

double FAR pascal FastBootDist(int df, int reps, int nextno,int lenseq,float *diffsx,float *validx,int *weightmod, short int *seqnum,float *distance)
{
	//weightmod - reps,len
	//distance -reps,nextno,nextno
	
	float th2,th3;
	
	float th1, dst;
	
	int a,s1, s2, x, y ,z, off1, off0, off3;
	
	int xoff, yoff;

	s2=66;
	off0 = reps+1;
	off1 = (nextno+1)*(reps+1);
	for(x = 0;x < nextno;x++){
		xoff = x*(lenseq+1);
		for (y = x+1; y<=nextno; y++){
		   yoff = y*(lenseq+1);
		   for (a=df; a <=reps; a++)
			   	diffsx[a] = 0.0;
		  
		   for (a=df; a <=reps; a++)
			   validx[a] = 0.0;
		  
		   for (z = 1; z <= lenseq; z++){
			   s1 = seqnum [z + xoff];
			   
			   if (s1 != 46){

					if (s1 == seqnum [z + yoff]){
						off3=(off0)*(z-1);
						for (a = df; a <= reps; a++)
							validx[a] = validx[a] + weightmod[a + off3];
				   }
					else if (seqnum [z + yoff] != 46){
						off3=(off0)*(z-1);
						for (a = df; a <= reps; a++){	
							validx[a] = validx[a] + weightmod[a + off3];
							
					
						//for (a = df; a <= reps; a++)	
							diffsx[a] = diffsx[a] + weightmod[a + off3];
						}
					}
			   }
		   
		   }    
		   for (a = df; a <= reps; a++){
			  if (validx[a] > 0){
					th1= (float)(diffsx[a]);
					th2= (float)(validx[a]);
					dst = (th2-th1)/th2;
					//return(dst);
					if (dst > 0.25){
						th2 = (float)((4.0 * dst - 1.0) / 3.0);
						th3 = (float)(log(th2));
						dst = (float)(-0.75*th3);
					}
					else 
						dst=10.0;

			   }

			   else
				   dst = 10.0;
				
			   
			   distance[a + x*off0 + y*off1] = (float)(dst);
			   distance[a + y*off0 + x*off1] = (float)(dst);
			   
		   }
		}
	   
	}

	return(1);
}


int FAR pascal MakeIdentical0(int LSeq, int CountVSites, unsigned char *Identical0,unsigned char *StrainSeq, unsigned char *TempBig){
	
	int Y, CV;
	CV = CountVSites;
	for (Y = 0; Y <= LSeq-1; Y++){
        
        if (StrainSeq[Y] != TempBig[Y]){
            if (Identical0[Y+1] == 0){
                CV = CV + 1;
                Identical0[Y+1] = 1;
            }
                
        }
           
        
	}

	return(CV);
}

double FAR pascal FastBootDistI(int df, int reps, int nextno,int lenseq,float *diffsx,float *validx,int *weightmod, short int *seqnum,float *distance, int *IdenticalF, int *IdenticalR)
{
	//weightmod - reps,len
	//distance -reps,nextno,nextno
	
	float th2,th3;
	
	float th1, dst;
	
	int a,s1, s2, x, y ,z, off1, off0, off3, off4, sublen;
	
	int xoff, yoff;
	sublen = IdenticalF[lenseq];
	s2=66;
	off0 = reps+1;
	off1 = (nextno+1)*(reps+1);
	for(x = 0;x < nextno;x++){
		xoff = x*(lenseq+1);
		for (y = x+1; y<=nextno; y++){
		   yoff = y*(lenseq+1);
		   for (a=df; a <=reps; a++)
			   	diffsx[a] = 0.0;
		  
		   for (a=df; a <=reps; a++)
			   validx[a] = 0.0;
		   
		   for (z = 1; z <= sublen; z++){
			   off4 = IdenticalR[z];
			   s1 = seqnum [off4 + xoff];
			   
			   if (s1 != 46){

					if (s1 == seqnum [off4 + yoff]){
						off3=(off0)*(off4-1);
						for (a = df; a <= reps; a++)
							validx[a] = validx[a] + weightmod[a + off3];
				   }
					else if (seqnum [off4 + yoff] != 46){
						off3=(off0)*(off4-1);
						for (a = df; a <= reps; a++){	
							validx[a] = validx[a] + weightmod[a + off3];
							
					
						//for (a = df; a <= reps; a++)	
							diffsx[a] = diffsx[a] + weightmod[a + off3];
						}
					}
			   }
		   
		   }    
		   for (a = df; a <= reps; a++){
			  if (validx[a] > 0){
					th1= (float)(diffsx[a]);
					th2= (float)(validx[a]);
					dst = (th2-th1)/th2;
					//return(dst);
					if (dst > 0.25){
						th2 = (float)((4.0 * dst - 1.0) / 3.0);
						th3 = (float)(log(th2));
						dst = (float)(-0.75*th3);
					}
					else 
						dst=10.0;

			   }

			   else
				   dst = 10.0;
				
			   
			   distance[a + x*off0 + y*off1] = (float)(dst);
			   distance[a + y*off0 + x*off1] = (float)(dst);
			   
		   }
		}
	   
	}

	return(1);
}

int FAR pascal CheckSplit(int LS, int Be, int En, int Seq1, int Seq2, int Seq3, int *Split, unsigned char *MissingData){
	int Z, off1, off2, off3;
	off1 = Seq1*(LS+1);
	off2 = Seq2*(LS+1);
	off3 = Seq3*(LS+1);
	if (Be < En){
		for (Z = Be; Z <= En; Z++){
			if (MissingData[Z + off1] == 1 || MissingData[Z + off2] == 1 || MissingData[Z +off3] == 1){
				*Split = 1;
				break;                                            
			}
		}
	}
	else{
		for (Z = Be; Z <= LS; Z++){
            if (MissingData[Z + off1] == 1 || MissingData[Z + off2] == 1 || MissingData[Z +off3] == 1){
				*Split = 1;
				break;                                            
			}
		}
		if (*Split == 0){
			for (Z = 1; Z <= En; Z++){
                if (MissingData[Z + off1] == 1 || MissingData[Z + off2] == 1 || MissingData[Z +off3] == 1){
					*Split = 1;
					break;                                            
				}
			}
		}
                                    
	}
	return(Z);
}

int FAR pascal FindMissing(int LS, int Seq1, int Seq2, int Seq3, int Z, int En, unsigned char *MissingData){
	int B, off1,off2,off3, GoOn;
	off1 = Seq1*(LS+1);
	off2 = Seq2*(LS+1);
	off3 = Seq3*(LS+1);
	
	if (Z < En){
		for (B = En; B >= Z; B--){
			if (MissingData[B + off1] == 1 || MissingData[B + off2] == 1 || MissingData[B +off3] == 1)
				break;
		}
	}
	else{
		GoOn = 0;
		for (B = En; B >= 1; B--){
			if (MissingData[B + off1] == 1 || MissingData[B + off2] == 1 || MissingData[B +off3] == 1) {
				GoOn = 1;
				break;
			}
		}
		if (GoOn == 0){
			for (B = LS; B >= Z; B--){
				if (MissingData[B + off1] == 1 || MissingData[B + off2] == 1 || MissingData[B +off3] == 1)
					break;
			}
		}
	}
	return(B);
}

double FAR pascal DistanceCalcZ(int nextno,int lenseq,float *diffsx,float *validx, short int *seqnum,float *distance,double *avdst, int *validl, int *countl)
{

	int count;
	int valid;
	double count2;
	double valid2;
	double dst, ad;
	double upper=0.0;
	int x,y,z;
	
	int xoff, yoff;
	ad = 0.0;
	dst = 0.0;
	for(x = 0;x < nextno;x++){
		xoff = x*lenseq;
		for (y = x+1; y<=nextno; y++){
		   yoff = y*lenseq;
		   count = 0;
		   valid = 0;
		   for (z = 1; z < lenseq; z++){
			   
			   //s1 = *(seqnum + z + xoff) + *(seqnum + z + yoff);
			   
			   if (countl[seqnum [z + xoff] + seqnum [z + yoff]])
				   
				   valid++;
			   
			   else if (validl[seqnum [z + xoff] + seqnum [z + yoff]]) {
					valid++;
					count++;
			   }
		   }

		   count2 = count;
		   valid2 = valid;
		   if (valid2 > 0)
				dst = (valid2 - count2)/valid2;
		   else
			   dst = 0.0;

		   *(distance + x + y*(nextno+1))= (float)(dst);
		   *(distance + y + x*(nextno+1))= (float)(dst);
		   *(validx + x + y*(nextno+1))= (float)(valid);
		   *(validx + y + x*(nextno+1))= (float)(valid);
		   *(diffsx + x + y*(nextno+1))= (float)(count);
		   *(diffsx + y + x*(nextno+1))= (float)(count);
		   ad = ad + (1.0 - dst);
		   if(dst < upper)
			   upper = dst;
		}
	   upper = (double)(1 - dst);
	}
	*avdst = ad; 
	return(upper);
}

int FAR pascal MakeDoneThis2 (int Nextno, float *FMat,float *FAMat, float *SAMat, int *DoneThis, int *Iseqs){
	//donethis - 1,nextno
	//LD - 1,2,1
	int Y, X, is;
	float holder, ubf, ubs, lbf, lbs;
	
    ubs=0.0;
	lbs=10000.0;
	ubf=0.0;
	lbf=10000.0;
	//work out min and max distances between iseqs in samat and famat (i.e define the bounds of the subtree that should be considered 

    for (X = 0; X < 3; X++){
        for (Y = 0; Y < 3; Y++){
			holder = (float)(FAMat[Iseqs[X] + Iseqs[Y]*(Nextno+1)]);
            

			if (ubf < holder)
				ubf = holder;

            
			
			if(lbf > holder)
				lbf = holder;

			holder = (float)(SAMat[Iseqs[X] + Iseqs[Y]*(Nextno+1)]);

            

			if (ubs < holder)
				ubs = holder;

            

			if (lbs > holder)
				lbs = holder;

        }
    }

	
	

	//return(1);
	//donethis=1 means the sequence should be ignored in subsequent analyses
	//mark as donethis sequences those that have a smallest distance to the iseqs than the two closest iseqs have to one another
	
	//check for outside the bounds
	for (Y = 0; Y <3; Y++){
		is = Iseqs[Y];
		
        for (X = 0; X <= Nextno; X++){
            if (FAMat[is + X*(Nextno+1)] < lbf || FAMat[is + X*(Nextno+1)] > ubf)//ld(0,y,1)
                 DoneThis[X*2] = 1;

            if (SAMat[is + X*(Nextno+1)] < lbs || SAMat[is + X*(Nextno+1)] > ubs)//ld(1,y,1)
                 DoneThis[1 + X*2] = 1;
        }
    }
	

	//readd those that are inside the bounds at least for some of the camparisons with the iseqs
	for (Y = 0; Y <3; Y++){
		is = Iseqs[Y];
		
        for (X = 0; X <= Nextno; X++){
            if (FAMat[is + X*(Nextno+1)] > lbf && FAMat[is + X*(Nextno+1)] < ubf)//ld(0,y,1)
                 DoneThis[X*2] = 0;

            if (SAMat[is + X*(Nextno+1)] > lbs && SAMat[is + X*(Nextno+1)] < ubs)//ld(1,y,1)
                 DoneThis[1 + X*2] = 0;
        }
    }

	//mark iseqs as donethis 
	for (X = 0; X < 2; X++){
        DoneThis[X + Iseqs[0]*2] = 1;
        DoneThis[X + Iseqs[1]*2] = 1;
        DoneThis[X + Iseqs[2]*2] = 1;
    }
     
    //mark as donethis sequences that have no overlap with iseqs
    for (X = 0; X <= Nextno; X++){
        if (FMat[X + Iseqs[0]*(Nextno+1)] == 3.0 || FMat[X + Iseqs[1]*(Nextno+1)] == 3.0 || FMat[X + Iseqs[2]*(Nextno+1)] == 3.0){
            DoneThis[X*2] = 1;
            DoneThis[1 + X*2] = 1;
        }
     
    }
	return(1);
}
int FAR pascal MakeDoneThis (int Nextno, float *FMat,float *FAMat, float *SAMat, double *LD, int *DoneThis, int *Iseqs){
	//donethis - 1,nextno
	//LD - 1,2,1
	int Y, X, is, off;
	float holder, ubf, ubs, lbf, lbs;
	for (Y = 0; Y < 2; Y++){
        for (X = 0; X <3; X++){
            LD[Y + X*2] = 0.0;//LD(0,0,0),LD(0,1,0), LD(0,2,0),LD(1,0,0),LD(1,1,0), LD(1,2,0)
            LD[Y + X*2 + 6] = 100000.0;//LD(0,0,1),LD(0,1,1), LD(0,2,1),LD(1,0,1),LD(1,1,1), LD(1,2,1)
        }
    }
    ubs=0.0;
	lbs=10000.0;
	ubf=0.0;
	lbf=10000.0;
	//work out min and max distances between iseqs in samat and famat (i.e define the bounds of the subtree that should be considered 

    for (X = 0; X < 2; X++){
        for (Y = X + 1; Y < 3; Y++){
			holder = (float)(FAMat[Iseqs[X] + Iseqs[Y]*(Nextno+1)]);
            if (LD[X*2] < holder)//LD(0,x,0) max
                LD[X*2] = holder;
            if (LD[Y*2] < holder)//LD(0,y,0) max
                LD[Y*2] = holder;

			if (ubf < holder)
				ubf = holder;

            if (LD[X*2 + 6] > holder)//LD(0,x,1) min
                LD[X*2 + 6] = holder;
            if (LD[Y*2 + 6] > holder)//LD(0,y,1) min
                LD[Y*2 + 6] = holder;
			
			if(lbf > holder)
				lbf = holder;

			holder = SAMat[Iseqs[X] + Iseqs[Y]*(Nextno+1)];

            if (LD[1 + X*2] < holder)//LD(1,x,0) max
                LD[1 + X*2] = holder;
            if (LD[1 + Y*2] < holder)//LD(1,y,0) max
                LD[1 + Y*2] = holder;

			if (ubs < holder)
				ubs = holder;

            if (LD[X*2 + 7] > holder)//LD(1,x,1) min
                LD[X*2 + 7] = holder;
            if (LD[Y*2 + 7] > holder)//LD(1,y,1) min
                LD[Y*2 + 7] = holder;

			if (ubs > holder)
				lbs = holder;

        }
    }

	
	

	//return(1);
	//donethis=1 means the sequence should be ignored in subsequent analyses
	//mark as donethis sequences those that have a smallest distance to the iseqs than the two closest iseqs have to one another
	for (Y = 0; Y <3; Y++){
		is = Iseqs[Y];
		off = Y*2 + 6;//
        for (X = 0; X <= Nextno; X++){
            if (FAMat[is + X*(Nextno+1)] < LD[off])//ld(0,y,1)
                 DoneThis[X*2] = 1;

            if (SAMat[is + X*(Nextno+1)] < LD[off+1])//ld(1,y,1)
                 DoneThis[1 + X*2] = 1;
        }
    }
	//mark iseqs as donethis 
	for (X = 0; X < 2; X++){
        DoneThis[X + Iseqs[0]*2] = 1;
        DoneThis[X + Iseqs[1]*2] = 1;
        DoneThis[X + Iseqs[2]*2] = 1;
    }
     
    //mark as donethis sequences that have no overlap with iseqs
    for (X = 0; X <= Nextno; X++){
        if (FMat[X + Iseqs[0]*(Nextno+1)] == 3.0 || FMat[X + Iseqs[1]*(Nextno+1)] == 3.0 || FMat[X + Iseqs[2]*(Nextno+1)] == 3.0){
            DoneThis[X*2] = 1;
            DoneThis[1 + X*2] = 1;
        }
     
    }
	return(1);
}

int FAR pascal GetNumInListC(int Seq1, int Seq2, int Seq3, int *S1S2, int *S2S3){
	int GetNumInList;
	GetNumInList=0;
	if (Seq1 < Seq2 && Seq1 < Seq3){
			if (Seq2 < Seq3)
				GetNumInList = S1S2[Seq1] + S2S3[Seq2 - Seq1] - (Seq2 - Seq1 - 1) * Seq1 + Seq3 - Seq2;
			else
				GetNumInList = S1S2[Seq1] + S2S3[Seq3 - Seq1] - (Seq3 - Seq1 - 1) * Seq1 + Seq2 - Seq3;
			
	}
	else if (Seq2 < Seq1 && Seq2 < Seq3){
			if (Seq1 < Seq3)
				GetNumInList = S1S2[Seq2] + S2S3[Seq1 - Seq2] - (Seq1 - Seq2 - 1) * Seq2 + Seq3 - Seq1;
			else
				GetNumInList = S1S2[Seq2] + S2S3[Seq3 - Seq2] - (Seq3 - Seq2 - 1) * Seq2 + Seq1 - Seq3;
			
	}
	else if( Seq3 < Seq2 && Seq3 < Seq1){
			if (Seq1 < Seq2)
				GetNumInList = S1S2[Seq3] + S2S3[Seq1 - Seq3] - (Seq1 - Seq3 - 1) * Seq3 + Seq2 - Seq1;
			else
				GetNumInList = S1S2[Seq3] + S2S3[Seq2 - Seq3] - (Seq2 - Seq3 - 1) * Seq3 + Seq1 - Seq2;
			
	}
	return(GetNumInList);
}

int FAR pascal CheckMatrix(int UB, int SCO, int MinSeqSize, int Nextno, int *Valtot, int *ISeqs, float *PermValid, float *SubValid, float *FMat, float *SMat, float *FAMat, float *SAMat){
	
	int X, Y, Z, A, EraseF, off1, off2, off3, off4;
	float nn;
	float ReplaceVal;
	nn=(float)(Nextno);

	ReplaceVal = (nn * 3 - 1) / 1000;
	
    for (X = 0; X <= Nextno; X++){
        EraseF = 0;
		off1 = X*(UB+1);
		off2 = X*(Nextno+1);
        for (Y = 0; Y <3; Y++){
			
            if (X != ISeqs[Y]){
				if (PermValid[ISeqs[Y] + off1] - SubValid[ISeqs[Y] + off2] < MinSeqSize || SubValid[ISeqs[Y]+off2] < SCO){
					EraseF = 1;
					break;
				}
            }
		}
        
		if (EraseF == 1){
           
            for (Y = 0; Y <= Nextno; Y++){
				off3 = Y*(Nextno+1);
                FMat[X + off3] = 3.0;
                FMat[Y + off2] = 3.0;
                SMat[X + off3] = 3.0;
                SMat[Y + off2] = 3.0;

                FAMat[X + off3] = ReplaceVal;
                FAMat[Y + off2] = ReplaceVal;
                SAMat[X + off3] = ReplaceVal;
                SAMat[Y + off2] = ReplaceVal;
                                
            }
            FAMat[X + off2] = 0;
            SAMat[X + off2] = 0;
        }
    }
    
	
    for (X = 0; X <= Nextno; X++){
		off2 = X*(Nextno+1);
		off1 = X*(UB+1);
        for (Y = X + 1; Y <= Nextno; Y++){
            off3 = Y*(Nextno+1);
			if (FMat[Y + off2] != 3.0){
                if (PermValid[Y + off2] - SubValid[Y + off2] < MinSeqSize){
                    
                    Valtot[0] = 0;
                    Valtot[1] = 0;
                    for (Z = 0; Z < 3; Z++){
                        Valtot[0] = Valtot[0]  + (int)(PermValid[ISeqs[Z] + off1] - SubValid[ISeqs[Z] + off2]);
                        Valtot[1] = Valtot[1]  + (int)(PermValid[Y + ISeqs[Z]*(UB+1)] - SubValid[Y + ISeqs[Z]*(Nextno+1)]);
                    }
                    
                    if (Valtot[0] > Valtot[1]){
                        
                        for (A = 0; A <= Nextno; A++){
                            
							off4 = A*(Nextno+1);
                            FMat[A + off3] = 3.0;
                            FMat[Y + off4] = 3.0;
                            SMat[A + off3] = 3.0;
                            SMat[Y + off4] = 3.0;
							if (A != Y){
                                FAMat[A + off3] = ReplaceVal;
                                FAMat[Y + off4] = ReplaceVal;
                                SAMat[A + off3] = ReplaceVal;
                                SAMat[Y + off4] = ReplaceVal;
                                
                            }
                            
                        }
                        FAMat[Y + off3] = 0;
                        SAMat[Y + off3] = 0;
					}
                    else{
                        for (A = 0; A <= Nextno; A++){
                            
                                off4 = A*(Nextno+1);
                                FMat[A + off2] = 3.0;
                                FMat[X + off4] = 3.0;
                                SMat[A + off2] = 3.0;
                                SMat[X + off4] = 3.0;
							if (A != Y){
                                FAMat[A + off2] = ReplaceVal;
                                FAMat[X + off4] = ReplaceVal;
                                SAMat[A + off2] = ReplaceVal;
                                SAMat[X + off4] = ReplaceVal;
                                
                            }
                        }
                        FAMat[Y + off2] = 0;
                        SAMat[Y + off2] = 0;
                    }
                }
                if (SubValid[Y + off2] < SCO && SMat[Y + off2] != 3.0){
                    
                    Valtot[0] = 0;
                    Valtot[1] = 0;
                    for (Z = 0; Z < 3; Z++){
                        Valtot[0] = Valtot[0]  + (int)(SubValid[ISeqs[Z] + off2]);
                        Valtot[1] = Valtot[1]  + (int)(SubValid[ISeqs[Z] + off3]);
                    }
                    if (Valtot[0] > Valtot[1]){
                         for (A = 0; A <= Nextno; A++){
                            
								off4 = A*(Nextno+1);
                                FMat[A + off3] = 3.0;
                                FMat[Y + off4] = 3.0;
                                SMat[A + off3] = 3.0;
                                SMat[Y + off4] = 3.0;
							if (A != Y){			
                                FAMat[A + off3] = ReplaceVal;
                                FAMat[Y + off4] = ReplaceVal;
                                SAMat[A + off3] = ReplaceVal;
                                SAMat[Y + off4] = ReplaceVal;
                                
                            }
                            
                        }
                        FAMat[Y + off3] = 0;
                        SAMat[Y + off3] = 0;
					}
                    else{
                        for (A = 0; A <= Nextno; A++){
                            
                                off4 = A*(Nextno+1);
                                FMat[A + off2] = 3.0;
                                FMat[X + off4] = 3.0;
                                SMat[A + off2] = 3.0;
                                SMat[X + off4] = 3.0;
							if (A != Y){
                                FAMat[A + off2] = ReplaceVal;
                                FAMat[X + off4] = ReplaceVal;
                                SAMat[A + off2] = ReplaceVal;
                                SAMat[X + off4] = ReplaceVal;
                                
                            }
                        }
                        FAMat[Y + off2] = 0;
                        SAMat[Y + off2] = 0;
                    }
                }
            }
        }
    }

	//clean up any leftovers
	for (X = 0; X<= Nextno; X++){
        if (FMat[X + X*(Nextno+1)] != 3.0){
            for (Y = 0; Y<= Nextno; Y++){
                if (FMat[X + Y*(Nextno+1)] < 3.0 && X != Y) 
					break;
			}
           
            if (Y == Nextno + 1) 
                FMat[X + X*(Nextno+1)] = 3.0;
            
		}
    }

	return(1);
}

int FAR pascal CheckPatternX(int NextNo, int LSeq, int *ISeqs, int *ST, int *en, short int *SeqNum, double *Pattern, char *DonePattern){
//donepattern - 2,nextno
//pattern - 2,2,nextno
int A, G, H, X, Z, off1, off2, off0, offx, offy, offz;
	for (G = 0; G < 3; G++){
		for (H = 0; H<=NextNo; H++){// 'RNum(G)
			X = H; //RList(G, H)
			
			if (X != ISeqs[G]){
				offy = X*3;
				for (Z = 0; Z < 3; Z++){
					
					if (DonePattern[Z + offy] == 0){
							DonePattern[Z + offy] = 1;
							offx = X*(LSeq+1);
							off0 = ISeqs[0]*(LSeq+1);
							off1 = ISeqs[1]*(LSeq+1);
							off2 = ISeqs[2]*(LSeq+1);
							offz = X*9;
							if (ST[Z] < en[Z]){
									
									for (A = ST[Z]; A <= en[Z]; A++){
										if (SeqNum[A + offx] != 46){
											if (SeqNum[A + off1] != 46){
												if (SeqNum[A + off2] != 46){
													if (SeqNum[A + off0] != 46){
														if (SeqNum[A + off0] != SeqNum[A + off1] || SeqNum[A + off0] != SeqNum[A + off2]){
															if (SeqNum[A + off0] == SeqNum[A + offx] ){
																if (SeqNum[A + offx] != SeqNum[A + off1]){
																	if (SeqNum[A + off1] == SeqNum[A + off2] )
																		Pattern[Z*3 + offz] = Pattern[Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off2])
																		Pattern[Z*3 + offz] = Pattern[Z*3 + offz]+ 0.5;
																	
																}
															}
															else{
																if (SeqNum[A + off1] == SeqNum[A + offx] ){
                                                                
																	if (SeqNum[A + off0] == SeqNum[A + off2] )
																		Pattern[1 + Z*3 + offz] = Pattern[1 + Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off2])
																		Pattern[1 + Z*3 + offz] = Pattern[1 + Z*3 + offz]+0.5;
																
																}
																else if (SeqNum[A + off2] == SeqNum[A + offx] ){
																	if (SeqNum[A + off0] == SeqNum[A + off1] )
																		Pattern[2 + Z*3 + offz] = Pattern[2 + Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off1])
																		Pattern[2 + Z*3 + offz] = Pattern[2 + Z*3 + offz]+0.5;
																	
																}
															}
														}
													}
												}
											}
										}
									}
								}
							else{
								for (A = 1; A <= en[Z]; A++){
										if (SeqNum[A + offx] != 46){
											if (SeqNum[A + off1] != 46){
												if (SeqNum[A + off2] != 46){
													if (SeqNum[A + off0] != 46){
														if (SeqNum[A + off0] != SeqNum[A + off1] || SeqNum[A + off0] != SeqNum[A + off2]){
															if (SeqNum[A + off0] == SeqNum[A + offx] ){
																if (SeqNum[A + offx] != SeqNum[A + off1]){
																	if (SeqNum[A + off1] == SeqNum[A + off2] )
																		Pattern[Z*3 + offz] = Pattern[Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off2])
																		Pattern[Z*3 + offz] = Pattern[Z*3 + offz]+ 0.5;
																	
																}
															}
															else{
																if (SeqNum[A + off1] == SeqNum[A + offx] ){
                                                                
																	if (SeqNum[A + off0] == SeqNum[A + off2] )
																		Pattern[1 + Z*3 + offz] = Pattern[1 + Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off2])
																		Pattern[1 + Z*3 + offz] = Pattern[1 + Z*3 + offz]+0.5;
																
																}
																else if (SeqNum[A + off2] == SeqNum[A + offx] ){
																	if (SeqNum[A + off0] == SeqNum[A + off1] )
																		Pattern[2 + Z*3 + offz] = Pattern[2 + Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off1])
																		Pattern[2 + Z*3 + offz] = Pattern[2 + Z*3 + offz]+0.5;
																	
																}
															}
														}
													}
												}
											}
										}
								}
								for (A = ST[Z]; A <= LSeq; A++){
										if (SeqNum[A + offx] != 46){
											if (SeqNum[A + off1] != 46){
												if (SeqNum[A + off2] != 46){
													if (SeqNum[A + off0] != 46){
														if (SeqNum[A + off0] != SeqNum[A + off1] || SeqNum[A + off0] != SeqNum[A + off2]){
															if (SeqNum[A + off0] == SeqNum[A + offx] ){
																if (SeqNum[A + offx] != SeqNum[A + off1]){
																	if (SeqNum[A + off1] == SeqNum[A + off2] )
																		Pattern[Z*3 + offz] = Pattern[Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off2])
																		Pattern[Z*3 + offz] = Pattern[Z*3 + offz]+ 0.5;
																	
																}
															}
															else{
																if (SeqNum[A + off1] == SeqNum[A + offx] ){
                                                                
																	if (SeqNum[A + off0] == SeqNum[A + off2] )
																		Pattern[1 + Z*3 + offz] = Pattern[1 + Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off2])
																		Pattern[1 + Z*3 + offz] = Pattern[1 + Z*3 + offz]+0.5;
																
																}
																else if (SeqNum[A + off2] == SeqNum[A + offx] ){
																	if (SeqNum[A + off0] == SeqNum[A + off1] )
																		Pattern[2 + Z*3 + offz] = Pattern[2 + Z*3 + offz]+1.0;
																	else if (SeqNum[A + offx] != SeqNum[A + off1])
																		Pattern[2 + Z*3 + offz] = Pattern[2 + Z*3 + offz]+0.5;
																	
																}
															}
														}
													}
												}
											}
										}
								}
							}
							
							
                    
					}
					
				}
			}
		}
	}
	return(1);
}

int FAR pascal MakeOLSeq(int LS, int BPos, int EPos, int *RSize, int *OLSeq){
	int X;
	
	if (BPos < EPos){
		for (X=0; X < BPos; X++)
			OLSeq[X] = 0;

		for (X=EPos+1; X<=LS; X++)
			OLSeq[X] = 0;

        RSize[0] = EPos - BPos + 1;
        for (X = BPos; X <= EPos; X++)
            OLSeq[X] = 1;
	}
    else{
        for (X = EPos+1; X < BPos; X++)
            OLSeq[X] = 0;
		
		RSize[0] = EPos + LS - BPos + 1;
        for (X = 1; X <= EPos; X++)
            OLSeq[X] = 1;
        for (X = BPos; X <= LS; X++)
            OLSeq[X] = 1;
    }
	return(1);
}

int FAR pascal MakeBPosLR(int VSN, int TSN, int LS, int BPos, int EPos, short int *SeqNum, int *Iseqs, int *BPosLR, double *AVSN){
	int X, INC, StP, EnP, SCount, TCount, off0,off1, off2;
	for (X = 0; X < 4; X++){
        if (X == 0 || X == 2){
            INC = -1;
            if (X == 0){
                StP = BPos - 1;
                EnP = EPos + 1;
			}
            else{
                StP = EPos;
                EnP = BPos;
            }
		}
        else{
            INC = 1;
            if (X == 1){
                StP = BPos;
                EnP = EPos;
			}
            else{
                StP = EPos + 1;
                EnP = BPos - 1;
            }
        }
        SCount = 0;
        TCount = 0;
        if (StP > LS) 
			StP = StP - LS;
        if (EnP > LS)
			EnP = EnP - LS;
		off0 = Iseqs[0]*(LS+1);
		off1 = Iseqs[1]*(LS+1);
		off2 = Iseqs[2]*(LS+1);
        while (StP != EnP){
            if (SeqNum[StP + off0] != 46){
				if (SeqNum[StP + off1] != 46){
					if (SeqNum[StP + off2] != 46){

						TCount++;
						if (SeqNum[StP + off0] != SeqNum[StP + off1] || SeqNum[StP + off0] != SeqNum[StP + off2]){
							if (SeqNum[StP + off0] == SeqNum[StP + off1] || SeqNum[StP + off0] == SeqNum[StP + off2] || SeqNum[StP + off1] == SeqNum[StP + off2]){
								SCount++;
								if (SCount == VSN && TCount > TSN)
									break;
								
							}
						}
					}
				}
			}
            
            
            StP = StP + INC;
            if (StP < 1)
                StP = LS;
            else if (StP > LS)
                StP = 1;
           
        }
        BPosLR[X] = StP;
		AVSN[X] = SCount;
		if (AVSN[X] == 0)
			AVSN[X] = 1;
    }
	return(1);
}


int FAR pascal MarkRemovals(int Nextno, int WinPP, int Redolistsize, int *RedoList, int *RNum, int *Rlist, int *DoPairs){
	int X, Z, Y;
	for (X = 0; X <= Redolistsize; X++){
		for (Y = 1; Y < 4; Y++){
			for (Z = 0; Z <= RNum[WinPP]; Z++){
				if (Rlist[WinPP + Z*3] == RedoList[Y + X*4]){
					if (Y == 1){
						if (DoPairs[RedoList[2 + X*4] + RedoList[3 + X*4]*(Nextno+1)] == 1)
							break;
					}
					else if (Y == 2){
						if (DoPairs[RedoList[1 + X*4] + RedoList[3 + X*4]*(Nextno+1)] == 1)
							break;
					}
					else if (Y == 3){
						if (DoPairs[RedoList[1 + X*4] + RedoList[2 + X*4]*(Nextno+1)] == 1)
							break;
					}
                        
				}
			}
			if (Z <= RNum[WinPP]){
				RedoList[X*4] = -1;
                break;
			}
		}
	}

	return(1);
}


int far pascal AtomDists(int X,int UB, int TotAmino, double *AtomArray, double *MinDist){
	int Y, A,B, off1, off2, off3, off4;
	double Dist1,Dist2,Dist3, Dist;
	//ReDim AtomArray(2, UB, UB2)
	//ReDim MinDist(TotAmino, TotAmino)
	off1 = X*3*(UB+1);
	off3 = (TotAmino+1)*X;
	for (Y = 0; Y<= UB; Y++){
        if (AtomArray[Y*3 + off1] < 100000){
            for (A = X + 1; A <= TotAmino; A++){
				off4 = (TotAmino+1)*A;
				off2 =  A*3*(UB+1);
                for (B = 0; B <= UB; B++){
                    if (AtomArray[B*3+ off2] < 100000){
                        Dist1 = AtomArray[B*3+ off2] - AtomArray[Y*3 + off1];
						Dist1 = Dist1*Dist1;
                        Dist2 = AtomArray[1+B*3+ off2] - AtomArray[1+Y*3 + off1];
						Dist2 = Dist2*Dist2;
                        Dist3 = AtomArray[2+B*3+ off2] - AtomArray[2+Y*3 + off1];
						Dist3 = Dist3*Dist3;
                        Dist = Dist1+Dist2+Dist3;
						Dist = pow(Dist,0.5);
                        if (Dist < MinDist[X + off4]){
                            MinDist[X + off4] = Dist;
                            MinDist[A + off3] = Dist;
                        }
                    }
					else
						break;
                }
            }
        }
		else
			break;
    
	}



	return(1);
}





int FAR pascal MakeBackups(int UBuDaught, int SE, int Nextno, int LSeq, unsigned char *MissingData, unsigned char *uMissingData, short int *SeqNum, unsigned char *uSeqNum, int *FFillCol, int *uFFillCol, int *SeqCol, int *uSeqCol, unsigned char *Daught, unsigned char *uDaught, float *Distance, float *uDistance, float *TreeDistance, float *uTreeDistance, int *TreeTrace, int *uTreeTrace){
	int X, Y, off1, off2, off3, off4, off5;
	off1 = UBuDaught+1;
	off3 = LSeq+1;
	off5 = Nextno+1;
	for (X = 0; X <= Nextno; X++){
		 off2 = X*off1;
		 off4 = X*off3;
         uTreeTrace[X] = TreeTrace[X];
         uDaught[SE + off2] = Daught[SE + off2];
         //uStraiName[X] = StraiName(X)
         uSeqCol[X] = SeqCol[X];
         uFFillCol[X] = FFillCol[X];
         
		 for (Y = 1; Y <= LSeq; Y++)
             uSeqNum[Y + off4] = (unsigned char)(SeqNum[Y + off4]);
		 
		 for (Y = 1; Y <= LSeq; Y++)
             uMissingData[Y + off4] = (unsigned char)(MissingData[Y + off4]);
         
         for (Y = 0; Y <= Nextno; Y++)
             uTreeDistance[X + Y*off5] = TreeDistance[X+ Y*off5];
		 
		 for (Y = 0; Y <= Nextno; Y++)
             uDistance[X + Y*off5] = Distance[X + Y*off5];
         
	}

	return(1);
}

int FAR pascal ReplaceWithBackups(int UBuDaught, int SE, int Nextno, int LSeq, unsigned char *MissingData, unsigned char *uMissingData, short int *SeqNum, unsigned char *uSeqNum, int *FFillCol, int *uFFillCol, int *SeqCol, int *uSeqCol, unsigned char *Daught, unsigned char *uDaught, float *Distance, float *uDistance, float *TreeDistance, float *uTreeDistance, int *TreeTrace, int *uTreeTrace){
	int X, Y, off1, off2, off3, off4, off5;
	off1 = UBuDaught+1;
	off3 = LSeq+1;
	off5 = Nextno+1;
	for (X = 0; X <= Nextno; X++){
		 off2 = X*off1;
		 off4 = X*off3;
         TreeTrace[X]=uTreeTrace[X] ;
         Daught[SE + off2]=uDaught[SE + off2]  ;
         //uStraiName[X] = StraiName(X)
         SeqCol[X]=uSeqCol[X] ;
         FFillCol[X]=uFFillCol[X] ;
         
		 for (Y = 1; Y <= LSeq; Y++)
             SeqNum[Y + off4] =(short int)(uSeqNum[Y + off4]) ;
		 
		 for (Y = 1; Y <= LSeq; Y++)
             MissingData[Y + off4] = (int)(uMissingData[Y + off4]);
         
         for (Y = 0; Y <= Nextno; Y++)
             TreeDistance[X + Y*off5] = uTreeDistance[X+ Y*off5];
		 
		 for (Y = 0; Y <= Nextno; Y++)
             Distance[X + Y*off5] = uDistance[X + Y*off5];
         
	}

	return(1);
}



int FAR pascal MakeETSeqNumX(int NextNo,int lseq, int tlseq, int rs, int RE, short int *ETSeqNum, short int *TreeSeqNum){
	
	int X, Y, off1, off2;
	if (rs < RE){
		
		for (Y = 0; Y<= NextNo;Y++){
			off1 = Y*(tlseq+1)+1-rs;
			off2 = Y*(lseq+1);
			for (X = rs; X<= RE; X++)
				ETSeqNum[X + off1] = TreeSeqNum[X + off2];
		}
	}
	else{
    
		for (Y = 0; Y<= NextNo;Y++){
			off1 = Y*(tlseq+1)+1-rs;
			off2 = Y*(lseq+1);
			for (X = rs; X<= lseq; X++)
				ETSeqNum[X + off1] = TreeSeqNum[X + off2];
		}
		
		for (Y = 0; Y<= NextNo;Y++){
			off1 = Y*(tlseq+1)+ (lseq-rs+1);
			off2 = Y*(lseq+1);
			for (X = 1; X<= RE; X++)
				ETSeqNum[X + off1 ] = TreeSeqNum[X + off2];
		}
	
	}
	return(1);
}

int FAR pascal MaketSeqNum(int lseq, int NextNo, short int *tSeqNum2, short int *SeqNum, float *FMat){


	int A, X, Y, off1, off2, off3;
	A = -1;
	off1 = NextNo+1;
	
    for (X = 0; X <= NextNo; X++){
		off2 = (lseq+1)*X;
        if (FMat[X + X*off1] != 3){
            A++;
			off3 = (lseq+1)*A;
            for (Y = 1; Y <=lseq; Y++)
                tSeqNum2[Y + off3] = SeqNum[Y+off2];
            
        }
	}

	return(1);
}

int FAR pascal CleanRedoList(int *Redolistsize, int *RedoList){
	int X, Y, Redo;
	X = 0;
	Redo = *Redolistsize;
	while (X <= Redo){
		if (RedoList[X*4] == -1){ 
			for (Y = 0; Y <4; Y++)
				RedoList[Y + X*4] = RedoList[Y + Redo*4];
			Redo--;
		}
		else
			X++;
	}
	*Redolistsize = Redo;
	return(1);
}

int FAR pascal MakeRelevant(int Nextno, int *Relevant, int *RNum, int *Rlist){
	int X, Y;
	for (X = 0; X <= Nextno; X++)
		Relevant[X] = 0;

	for (X = 0; X < 3; X++){
        for(Y = 0; Y <= RNum[X]; Y++){
			Relevant[Rlist[X + Y*3]] = 1;
		}
    }
	return(1);
}

int FAR pascal MakeLDist(int Nextno, double *LDist, float *FAMat, int *RNum, int *Rlist){
	int WinPP, X, Y, s1;
	for (WinPP = 0; WinPP < 3; WinPP++){
        LDist[WinPP] = 0.0;
        for (X = 0; X < RNum[WinPP]; X++){
			s1 = Rlist[WinPP + X*3]*(Nextno+1);
            for (Y = X + 1; Y <= RNum[WinPP]; Y++){
                if (FAMat[Rlist[WinPP + Y*3] + s1] > LDist[WinPP])
                    LDist[WinPP] = FAMat[Rlist[WinPP + Y*3] + s1];
                
            }
        }
		//LDist[WinPP]=LDist[WinPP]+0.00001;
    }
	return(1);
}

double FAR pascal MakeRList(int Nextno, int *GoodC,  int *Iseqs, int *RlistX, int *InvListX, int *RNumX,int *Rlist, int *InvList, int *RNum, float *RInv, float *RCorr, double *PScores, double *tPVal, double *tVal, double *TotP, double *RLScore, char *dontredo, char *acceptab, char *rcorrwarn){
	//rinv/rcorr - 2,2,nextno
	//tval/pscores 2,nextno,2
	//totp - 2,nextno,1
	//goodc -nextno,1
	//rlscore - 2,nextno
	//dontredo -2,nextno
	int WinPP, X, Z,Y, off1, off2, off3, off4, corc, off5;
	double TPS, Dummy, tv1, tv2, tv3, TotPTarget, TT, TTX;


	off5 = 3*(Nextno+1);
    TotPTarget = 0;
    for (X = 0; X < 3; X++)
        TotPTarget = TotPTarget + rcorrwarn[X];
    
	TTX=0;
	for (X = 0; X <3; X++){
		if(rcorrwarn[X] == 0)
			TTX = TTX + 1;
	}

	
	//return (TotPTarget);
    if (TotPTarget > 0)
        TotPTarget = 0.9 - (0.9 / 3) * TotPTarget;
		
    else
        TotPTarget = 0.9;
    

	for (WinPP = 0; WinPP < 3; WinPP++){
		
        for (X = 0; X <= Nextno; X++){
			
			
			off3 = X*3 + WinPP;
			if (dontredo[off3] == 0){
				off1 = X*9 + WinPP;
				corc=0;
				for (Z = 0; Z <2; Z++){
					if (RCorr[off1+Z*3] > 0.95 && rcorrwarn[Z] == 0){
						if (RCorr[off1+Z*3] > 0.98)
							corc+=2;
						else
							corc++;
					}
				}

				if (acceptab[off3] == 1 || Iseqs[WinPP] == X || corc == 2){
					
					for (Z = 0; Z < 3; Z++){
						if (RInv[off1 + Z*3] == 0){//&& RInv[off1 + 3] == 0 && RInv[off1 + 6] == 0){	
							if (rcorrwarn[Z] == 0){
								off2 = off1 + Z*3;
                
								off4 = off3 + Z*off5;
								if (RCorr[off2] >= 1){
                        
									RCorr[off2] = (float)(0.99999999);
									

								}
                    
								if (RCorr[off2] <= 0)
									tVal[off4] = 0;
								else{
									tv1 = RCorr[off2] * RCorr[off2];
									if (1.0-tv1 > 0.0){
										tv2 = 4.0 / (1.0 - tv1);
										tv3 = sqrt(tv2);
										tVal[off4] = RCorr[off2] * tv3;
									}
									else
										tVal[off4] = 0;

								}
                    
                    
								Dummy = ttestprob2(tVal[off4], 4);
                    
								tPVal[off4] = ((1 - Dummy) * 2);
                        
								PScores[off4] = (1 - tPVal[off4]);
                    
								if (PScores[off4] >= 0.95)
									TPS = (PScores[off4] - 0.95) / 0.05;
								else
									TPS = (PScores[off4] - 0.95) / 0.95;
								
								//if (Z==2)
								//	TPS = TPS/2;

								if (TPS > 0)
									TotP[off3] = TotP[off3] + TPS;
								else
									TotP[WinPP + X*3 + off5] = TotP[off3] - TPS;

							}
                    
                    
						}
                
					}
					TT=0;//TotPTarget;
					if (TotP[off3] > TotPTarget){

						
						
						if (GoodC[X] == 1 || GoodC[X + Nextno + 1] == 1){
							Rlist[WinPP + RNum[WinPP]*3] = X;
							RNum[WinPP] = RNum[WinPP] + 1;
							RLScore[off3] = TotP[off3];
							
							for (Y = 0; Y < 10; Y++){
								if (TotP[off3] > TT){
									RlistX[WinPP + RNumX[WinPP + Y*3]*3 + Y*off5] = X;
									RNumX[WinPP + Y*3] = RNumX[WinPP + Y*3] + 1;
								
								}
								else
									break;
								
								TT = TT + (TTX-TT)/3;
								//return (TT);
							}
						}
						else if (X == Iseqs[WinPP]){
							
							Rlist[WinPP + RNum[WinPP]*3] = X;
							RNum[WinPP] = RNum[WinPP] + 1;
							RLScore[off3] = TotP[off3];
							for (Y = 0; Y < 10; Y++){
								if (TotP[off3] > TT){
									RlistX[WinPP + RNumX[WinPP + Y*3]*3 + Y*off5] = X;
									RNumX[WinPP + Y*3] = RNumX[WinPP+ Y*3] + 1;
								}
								else
									break;
								TT = TT+(TTX-TT)/3;
							}
							
						}
					}
					else{
						
						for (Y = 0; Y < 10; Y++){
								if (TotP[off3] > TT){
									RlistX[WinPP + RNumX[WinPP]*3 + Y*off5] = X;
									RNumX[WinPP + Y*3] = RNumX[WinPP+ Y*3] + 1;
								}
								else if (X == Iseqs[WinPP]){
									RlistX[WinPP + RNumX[WinPP + Y*3]*3 + Y*off5] = X;
									RNumX[WinPP + Y*3] = RNumX[WinPP+ Y*3] + 1;
								}
								else
									break;
								TT = TT+(TTX-TT)/3;
						}
				
					
						if (X == Iseqs[WinPP]){
                
							Rlist[WinPP + RNum[WinPP]*3] = X;
							RNum[WinPP] = RNum[WinPP] + 1;
							RLScore[off3] = TotP[off3];
							for (Y = 0; Y < 10; Y++){
								
									RlistX[WinPP + RNumX[WinPP + Y*3]*3 + Y*off5] = X;
									RNumX[WinPP + Y*3] = RNumX[WinPP+ Y*3] + 1;
								
							}
									
							//if (TotP[off3] > TotPTarget*2){
							//		RlistX[WinPP + RNumX[WinPP]*3] = X;
							//		RNumX[WinPP] = RNumX[WinPP] + 1;
							//}
							
						}
						else if (RInv[WinPP + X*9] > 0 && RCorr[WinPP + X*9] > 0.83 && rcorrwarn[0] == 0) {
							InvList[WinPP + RNum[WinPP]*3] = 1;
							Rlist[WinPP + RNum[WinPP]*3] = X;
							RNum[WinPP] = RNum[WinPP] + 1;
							RLScore[off3] = TotP[off3];
							//if (TotP[off3] > TotPTarget*1.5){
							//		RlistX[WinPP + RNumX[WinPP]*3] = X;
							//		RNumX[WinPP] = RNumX[WinPP] + 1;
							//		InvListX[WinPP + RNumX[WinPP]*3] = 1;
							//}
						}
						else if (RInv[WinPP + 3 + X*9] > 0 && RCorr[WinPP + 3 + X*9] > 0.83 && rcorrwarn[1] == 0) {
							InvList[WinPP + RNum[WinPP]*3] = 1;
							Rlist[WinPP + RNum[WinPP]*3] = X;
							RNum[WinPP] = RNum[WinPP] + 1;
							RLScore[off3] = TotP[off3];
							//if (TotP[off3] > TotPTarget*1.5){
							//		RlistX[WinPP + RNumX[WinPP]*3] = X;
							//		RNumX[WinPP] = RNumX[WinPP] + 1;
							//		InvListX[WinPP + RNumX[WinPP]*3] = 1;
							//}

						}
						else if (RInv[WinPP + 6 + X*9] > 0 && RCorr[WinPP + 6 + X*9]  > 0.83 && rcorrwarn[2] == 0) {
							InvList[WinPP + RNum[WinPP]*3] = 1;
							Rlist[WinPP + RNum[WinPP]*3] = X;
							RNum[WinPP] = RNum[WinPP] + 1;
							RLScore[off3] = TotP[off3];
							//if (TotP[off3] > TotPTarget*1.5){
							//		RlistX[WinPP + RNumX[WinPP]*3] = X;
							//		RNumX[WinPP] = RNumX[WinPP] + 1;
							//		InvListX[WinPP + RNumX[WinPP]*3] = 1;
							//}
						}

					}
				}
				else if (RInv[WinPP + X*9] > 0 && RCorr[WinPP + X*9] > 0.83 && rcorrwarn[0] == 0) {
					InvList[WinPP + RNum[WinPP]*3] = 1;
					Rlist[WinPP + RNum[WinPP]*3] = X;
					RNum[WinPP] = RNum[WinPP] + 1;
					RLScore[off3] = TotP[off3];
					//if (TotP[off3] > TotPTarget*1.5){
					//	RlistX[WinPP + RNumX[WinPP]*3] = X;
					//	RNumX[WinPP] = RNumX[WinPP] + 1;
					//	InvListX[WinPP + RNumX[WinPP]*3] = 1;
					//}
				}
				else if (RInv[WinPP + 3 + X*9] > 0 && RCorr[WinPP + 3 + X*9] > 0.83 && rcorrwarn[1] == 0) {
					InvList[WinPP + RNum[WinPP]*3] = 1;
					Rlist[WinPP + RNum[WinPP]*3] = X;
					RNum[WinPP] = RNum[WinPP] + 1;
					RLScore[off3] = TotP[off3];
					//if (TotP[off3] > TotPTarget*1.5){
					//	RlistX[WinPP + RNumX[WinPP]*3] = X;
					//	RNumX[WinPP] = RNumX[WinPP] + 1;
					//	InvListX[WinPP + RNumX[WinPP]*3] = 1;
					//}

				}
				else if (RInv[WinPP + 6 + X*9] > 0 && RCorr[WinPP + 6 + X*9]  > 0.83 && rcorrwarn[2] == 0) {
					
					InvList[WinPP + RNum[WinPP]*3] = 1;
					Rlist[WinPP + RNum[WinPP]*3] = X;
					RNum[WinPP] = RNum[WinPP] + 1;
					RLScore[off3] = TotP[off3];
					//if (TotP[off3] > TotPTarget*1.5){
					//	RlistX[WinPP + RNumX[WinPP]*3] = X;
					//	RNumX[WinPP] = RNumX[WinPP] + 1;
					//	InvListX[WinPP + RNumX[WinPP]*3] = 1;
					//}
					

				}
			}
			else if (X == Iseqs[WinPP]){
                
							Rlist[WinPP + RNum[WinPP]*3] = X;
							RNum[WinPP] = RNum[WinPP] + 1;
							RLScore[off3] = TotP[off3];
							for (Y = 0; Y < 10; Y++){
								
									RlistX[WinPP + RNumX[WinPP + Y*3]*3 + Y*off5] = X;
									RNumX[WinPP + Y*3] = RNumX[WinPP+ Y*3] + 1;
								
							}
			}
		}
        RNum[WinPP] = RNum[WinPP] - 1;
		for (X = 0; X <10; X++)
			RNumX[WinPP + X*3] = RNumX[WinPP+X*3] - 1;
	}
	return(1);
}


int FAR pascal MakeMatchMatX(int LSeq, int NextNo, int X, char *ContainSite, float *SMat, float *MatchMat,float *BMatch, int *BPMatch, short int *SeqNum, int *iseqs){
	//bpmatch 2,1,nexto
	//bmatch 2,nextno
	//containsite lseq,nextno
	//matchmat 2,nextno,nextno

	int AA, A, Y, Z,off1,ST,EN, s1,s2;
	float Diffs, Valid,th1,th2,th3;
	
	off1 = LSeq+1;
	for (Y = 0; Y <= NextNo; Y++){
	
        if (BMatch[X + Y*3] > 0){
			ST = BPMatch[X + Y*6];
			if (ST >LSeq)
				ST=LSeq;
			EN = BPMatch[X + 3 + Y*6];
            if (ST < EN){
                for (Z = ST; Z <= EN; Z++)
                    ContainSite[Z + Y*off1] = 1;
			}
			else{
				for (Z = ST; Z <= LSeq; Z++)
                    ContainSite[Z + Y*off1] = 1;
				for (Z = 1; Z <= EN; Z++)
                    ContainSite[Z + Y*off1] = 1;
                
            }
        }
    }
    for (AA = 0; AA <= 2; AA++){
		Y = iseqs[AA];
        if (BMatch[X + Y*3] > 0){
            for (Z = 0; Z <= NextNo; Z++){
                Diffs = 0.0;
				Valid = 0.0;
                ST = BPMatch[X + Y*6];
				EN = BPMatch[X + 3 + Y*6];
				if (BMatch[X + Z*3] > 0){
                    
                    if (ST < EN){
                        for (A = ST;A<= EN; A++){ 
							s1 = SeqNum[A + Z*off1];
                            if (s1 != 46){
								s2 = SeqNum[A + Y*off1];
                                if (s2 != 46){

                                    if (ContainSite[A + Z*off1] == 1){
                                        if (ContainSite[A + Y*off1] == 1){
                                            if (s1 != s2) 
                                                Diffs++;
                                            
                                            Valid++;
                                        }
                                    }
                                }
							}
                        }
					}
                    else{
                        for (A = ST;A<= LSeq; A++){ 
                            s1 = SeqNum[A + Z*off1];
                            if (s1 != 46){
								s2 = SeqNum[A + Y*off1];
                                if (s2 != 46){

                                    if (ContainSite[A + Z*off1] == 1){
                                        if (ContainSite[A + Y*off1] == 1){
                                            if (s1 != s2) 
                                                Diffs++;
                                            
                                            Valid++;
                                        }
                                    }
                                }
							}
                        }
                        for (A = 1;A<= EN; A++){ 
                            s1 = SeqNum[A + Z*off1];
                            if (s1 != 46){
								s2 = SeqNum[A + Y*off1];
                                if (s2 != 46){

                                    if (ContainSite[A + Z*off1] == 1){
                                        if (ContainSite[A + Y*off1] == 1){
                                            if (s1 != s2) 
                                                Diffs++;
                                            
                                            Valid++;
                                        }
                                    }
                                }
							}
                        }
                        
                    }
				}
                    
				else{
					if (ST < EN){
                        for (A = ST;A<= EN; A++){ 
							s1 = SeqNum[A + Z*off1];
                            if (s1 != 46){
								s2 = SeqNum[A + Y*off1];
                                if (s2 != 46){
                                    
									if (s1 != s2) 
										Diffs++;
                                            
                                    Valid++;
                                   
                                }
							}
                        }
					}
                    else{
                        for (A = ST;A<= LSeq; A++){ 
							s1 = SeqNum[A + Z*off1];
                            if (s1 != 46){
								s2 = SeqNum[A + Y*off1];
                                if (s2 != 46){
                                    
									if (s1 != s2) 
										Diffs++;
                                            
                                    Valid++;
                                   
                                }
							}
                        }
						for (A = 1;A<= EN; A++){ 
							s1 = SeqNum[A + Z*off1];
                            if (s1 != 46){
								s2 = SeqNum[A + Y*off1];
                                if (s2 != 46){
                                    
									if (s1 != s2) 
										Diffs++;
                                            
                                    Valid++;
                                   
                                }
							}
                        }
                        
                    }
                }
                if (Valid <= 30)
                    MatchMat[X + AA*3 + Z*9] = 3;
                else if (Diffs / Valid >= 0.75) 
                    MatchMat[X + AA*3 + Z*9] = 3;
                else{
                    th1 = 1 - (Diffs / Valid);
                    th2 = (float)((4.0 * th1 - 1.0) / 3.0);
                    th3 = (float)(log(th2));
                    MatchMat[X + AA*3 + Z*9] = (float)(-0.75 * th3);
				}
                //MatchMat[X + Z*3 + Y*3*(NextNo+1)] = MatchMat[X + Y*3 + Z*3*(NextNo+1)];
            }
		}
		else{
            for (Z = 0; Z <= NextNo; Z++){
                if (BMatch[X + Z*3] == 0){
                    MatchMat[X + AA*3 + Z*9] = SMat[Y + Z*(NextNo+1)];
                    //MatchMat[X + Z*3 + Y*9] = MatchMat[X + Y*3 + Z*9];
                }
            }
        }
    }


	return(1);

}

int FAR pascal AddSeqToUPGMA(int Nextno, int SortedNo, short int *XInstance, float *DistanceBak, short int *TreeX, short int *TreeY, int *Check, short int *NodeYPos){
	int Replace, G, Z, X, sx, sy, offx, offy, MultiInclude, cXi;
	Replace=0;
	MultiInclude=0;
	sx = TreeX[SortedNo];
	sy = TreeY[SortedNo];
	offx = (Nextno+1)*sx;
	offy = (Nextno+1)*sy;
	for (X = 0; X <= Nextno; X++){
		if (X != sx && X != sy){
			if (DistanceBak[X + offx] < 1 && DistanceBak[X + offy] < 1)
				DistanceBak[X + offx] = (DistanceBak[X + offx] + DistanceBak[X + offy]) / 2;
            else if (DistanceBak[X + offy] < 1)
                DistanceBak[X + offx] = DistanceBak[X + offy];
            else
                DistanceBak[X + offx] = (float)(0.999999);

            DistanceBak[sx + X*(Nextno+1)] = DistanceBak[X + offx];
		}
		else if (X == sx){

			if (XInstance[sx] > 0){
                    //find last instance including x

				for (Z = SortedNo - 1; Z >= 0; Z--){ 

					if (TreeX[Z] == sx){
						MultiInclude = Z;
                        break;
					}

				}

                cXi = XInstance[sx];

                for (Z = 0; Z <= cXi; Z++)
					TreeX[SortedNo + Z*(Nextno+1)] = TreeX[MultiInclude + Z*(Nextno+1)];

			}

			if (XInstance[sy] > 0){// if "sequence y" is actually a node
                    //finds last node including y

				for (Z = SortedNo - 1; Z >= 0; Z--){
					if (TreeX[Z] == sy){
						MultiInclude = Z;
                        break;
					}
				}

                //adds sequences in node y to node x
                cXi = XInstance[sy];

				for (Z = 0; Z <= cXi; Z++){
					XInstance[X] = XInstance[X] + 1;
                        
                    //this is a temporary fix
                    if (XInstance[X] > Nextno){
                            
						//replace duplicate
                        for (X = 0; X <= Nextno; X++)
							Check[X] = 0;
                            
                        for (G = 0; G <= Nextno; G++)
                            Check[TreeX[SortedNo + G*(Nextno+1)]] = Check[TreeX[SortedNo + G*(Nextno+1)]]  + 1;

						for (G = 0; G <= Nextno; G++){
							if (Check[G] > 1)
								Replace = G;
						}
                        XInstance[X] = Replace;
					}
                    TreeX[SortedNo + XInstance[X]*(Nextno+1)] = TreeX[MultiInclude + Z*(Nextno+1)];
				}
			}
                    
			else{
				XInstance[X] = XInstance[X] + 1;
                if (XInstance[X] > Nextno){
					//replace duplicate
					for (X = 0; X <= Nextno; X++)
						Check[X] = 0;
                        
					for (G = 0; G <= Nextno; G++)
						Check[TreeX[SortedNo + G*(Nextno+1)]] = Check[TreeX[SortedNo + G*(Nextno+1)]]  + 1;
                                
                    for (G = 0; G <= Nextno; G++){
						if (Check[G] > 1)
							Replace = G;
					}
					XInstance[X] = Replace;
				}
                TreeX[SortedNo + XInstance[X]*(Nextno+1)] = sy;
			}

		}
        NodeYPos[X] = XInstance[X];
	}

    for (X = 0; X <= Nextno; X++){
		if (X != sy){
			DistanceBak[sy + X*(Nextno+1)] = 100;
            DistanceBak[X + sy*(Nextno+1)] = 100;
		}

	}
	return(1);
}

int FAR pascal AddSeqToUPGMA2(int Nextno, int SortedNo, short int *XInstance, float *DistanceBak, short int *TreeX, short int *TreeY, int *Check, short int *NodeYPos){
	int Replace,  Z, X, sx, sy, offx, offy, MultiInclude, cXi;
	Replace=0;
	MultiInclude=0;
	sx = TreeX[SortedNo];
	sy = TreeY[SortedNo];
	offx = (Nextno+1)*sx;
	offy = (Nextno+1)*sy;
	for (X = 0; X <= Nextno; X++){
		if (X != sx && X != sy){
			DistanceBak[X + offx] = (DistanceBak[X + offx] + DistanceBak[X + offy]) / 2;
            DistanceBak[sx + X*(Nextno+1)] = DistanceBak[X + offx];
		}
		else if (X == sx){

			if (XInstance[sx] > 0){
                    //find last instance including x

				for (Z = SortedNo - 1; Z >= 0; Z--){ 

					if (TreeX[Z] == sx){
						MultiInclude = Z;
                        break;
					}

				}

                cXi = XInstance[sx];

                for (Z = 0; Z <= cXi; Z++)
					TreeX[SortedNo + Z*(Nextno+1)] = TreeX[MultiInclude + Z*(Nextno+1)];

			}

			if (XInstance[sy] > 0){// if "sequence y" is actually a node
                    //finds last node including y

				for (Z = SortedNo - 1; Z >= 0; Z--){
					if (TreeX[Z] == sy){
						MultiInclude = Z;
                        break;
					}
				}

                //adds sequences in node y to node x
                cXi = XInstance[sy];

				for (Z = 0; Z <= cXi; Z++){
					XInstance[X] = XInstance[X] + 1;
                    TreeX[SortedNo + XInstance[X]*(Nextno+1)] = TreeX[MultiInclude + Z*(Nextno+1)];
				}
			}
                    
			else{
				XInstance[X] = XInstance[X] + 1;
                TreeX[SortedNo + XInstance[X]*(Nextno+1)] = sy;
			}

		}
        //NodeYPos[X] = XInstance[X];
	}

    for (X = 0; X <= Nextno; X++){
		if (X != sy){
			DistanceBak[sy + X*(Nextno+1)] = 100;
            DistanceBak[X + sy*(Nextno+1)] = 100;
		}

	}
	return(1);
}




int FAR pascal MakeTrpGroups(int X, int Nextno, int *NumInGroup, int *CompMat, int *Iseqs, int *DoneOne, int *GroupSeq, double *MinDistZ, float *FAMat){
	int Y, GroupNumber, xs, xs0, xs1;
	double MinDistance;
	MinDistZ[X] = 0;
    GroupNumber = 1;
	MinDistance=0.0;
	xs = Iseqs[X];
	xs0 = Iseqs[CompMat[X]];
	xs1 = Iseqs[CompMat[X+3]];
	for (Y = 0; Y <= Nextno; Y++){
		if (FAMat[xs + Y*(Nextno+1)] < FAMat[xs + xs0*(Nextno+1)]){
			if( FAMat[xs + Y*(Nextno+1)] < FAMat[xs + xs1*(Nextno+1)]){
				DoneOne[Y] = 1;
                GroupSeq[Y] = 0;
                if (FAMat[xs + Y*(Nextno+1)] > MinDistZ[X])
					MinDistZ[X] = FAMat[xs + Y*(Nextno+1)];
                          
			}
		}
	}
                    
	while (MinDistance != 10001.0){
		MinDistance = 10001;
		for (Y = 0; Y <= Nextno; Y++){
			if (DoneOne[Y] == 0){
				if (FAMat[xs + Y*(Nextno +1)] < MinDistance){
					if(FAMat[xs + Y*(Nextno +1)] > MinDistZ[X])
						MinDistance = FAMat[xs + Y*(Nextno +1)];
				}
			}
		}

		if (MinDistance == 10001)
			break;
                        
		for (Y = 0; Y <= Nextno; Y++){
			if (FAMat[xs + Y*(Nextno +1)] == MinDistance){
				GroupSeq[Y] = GroupNumber;
                   DoneOne[Y] = 1;
			}
		}
        GroupNumber++;
	}
                   
                    
                    
    for (Y = 0; Y <= Nextno; Y++)
		NumInGroup[GroupSeq[Y]] = NumInGroup[GroupSeq[Y]] + 1;
                     
                    
                    //GroupNumber = GroupNumber - 1
	return(1);
}
double FAR pascal MakePhPrScore(int Nextno, double tmF, int *TraceInvolvedBak, int *DoneThis, int *Iseqs, double *PhPrScore,  float *FMat, float *SMat, double *tPhPrScore, double *SubPhPrScore, double *SubScore){
	//donerthis - 1,nextno
	int X, C, D, NumInvolved;
	double NS, SumX, SumY, SumXY, SumX2, SumY2, iv1, iv0, td1, td2, td3,td4;
	
	C=0;
	for (X = 0; X < 3; X++)
        TraceInvolvedBak[X] = Iseqs[X];
    
	NumInvolved = 2;
     
    for (X = 0; X <= Nextno; X++){
        if (DoneThis[X*2] == 0 || DoneThis[1+X*2] == 0){
            NumInvolved++;
			if (NumInvolved <= Nextno)
                TraceInvolvedBak[NumInvolved] = X;
            else{
                NumInvolved--;
                break;
            }
        }
    }

    for (X = 0; X < 3; X++)
        SubScore[X] = 0.0;
    
    

    for (X = 0; X < 4; X++){
        if (X == 0)
            NS = (double)(NumInvolved);
        else{
            SubPhPrScore[X - 1] = 0.0;
            NS = (double)(NumInvolved - 1);
        }
        if (NS > 1){
			for (C = 0; C < 3; C++){
				if (C != X - 1){
					SumX = 0.0;
					SumY = 0.0;
					SumXY = 0.0;
					SumX2 = 0.0;
					SumY2 = 0.0;
                        
					for (D = 0; D <= NumInvolved; D++){
                
						if (D != X - 1){
							if (TraceInvolvedBak[C] != TraceInvolvedBak[D]){
								iv0 = FMat[TraceInvolvedBak[C] + TraceInvolvedBak[D]*(Nextno+1)];
								iv1 = SMat[TraceInvolvedBak[C] + TraceInvolvedBak[D]*(Nextno+1)];
								if (X == 0)
									SubScore[C] = SubScore[C] + fabs(iv0 - iv1);
								
                        
								SumX = SumX + iv0;
								SumY = SumY + iv1;
								SumXY = SumXY + iv0*iv1;
								SumX2 = SumX2 + iv0*iv0;
								SumY2 = SumY2 + iv1*iv1;
							}
						}
					}
                
					if (SumX2 > 0){
						if (SumY2 > 0){ 
							//if (NS > 2){
								if ((NS * SumY2)*0.99999 < (SumY * SumY) && (NS * SumY2)/0.99999 > (SumY * SumY)) 
									tPhPrScore[C] = 1;
								else{
									if ((NS * SumX2)*0.99999 < (SumX * SumX) && (NS * SumX2)/0.99999 > (SumX * SumX))
										tPhPrScore[C] = 1;
									else{
										td3 = (NS * SumX2);
										
										td3 = td3 - (SumX * SumX);
										td1 = sqrt(td3);
										
										
										td3 = (NS * SumY2);
										td3 = td3 - (SumY * SumY);
										td2 = sqrt(td3);
										td3 = td1*td2;
										
										td4 = (NS * SumXY) - (SumX * SumY);
										td4 = td4/td3;
										td4 = td4 + tmF;
										tPhPrScore[C] = td4;
										//tPhPrScore(C) = (NS * SumXY - SumX * SumY) / (Sqr(NS * SumX2 - SumX * SumX) * Sqr(NS * SumY2 - SumY * SumY))
									//	tPhPrScore[C] =td3;
									}
								}
								
							//}
								
							//else
							//	tPhPrScore[C] = 1;
						}
						else
							tPhPrScore[C] = 1;
					}
					else
						tPhPrScore[C] = 1;
                
					if (X == 0)
						PhPrScore[C] = tPhPrScore[C];
					else
						SubPhPrScore[X - 1] = SubPhPrScore[X - 1] + tPhPrScore[C];
				}
			}
		}
		else{
			if (X == 0)
				PhPrScore[C] = 1;
			else
				SubPhPrScore[X - 1] = 1;
		}
        if (X > 0)
            SubPhPrScore[X - 1] = SubPhPrScore[X - 1] / 2;
	
    }
	return(1);
}

double FAR pascal DistanceCalcY(short int nextno,int lenseq,float *diffsx,float *validx, short int *seqnum,float *distance,double *avdst, double *distmod)
{

	double count;
	double valid;
	double count2;
	double valid2;
	double dst, ad;
	double upper=0.0;
	short int s1, s2;
	
	long xoff, yoff;
	ad = 0.0;
	dst = 0.0;
	for(int x = 0;x < nextno;x++){
		xoff = x*lenseq;
		for (int y = x+1; y<=nextno; y++){
		   yoff = y*lenseq;
		   count = 0.0;
		   valid = 0.0;
		   for (int z = 1; z <= lenseq; z++){
			   s1 = *(seqnum + z + xoff);
			   s2 = *(seqnum + z + yoff);
			   if(s1 > 64 && s2 > 64){
				   valid = valid + distmod[z];
				   if (s1 != s2)
						count++;
			   }
		   }    
		   count2 = count;
		   valid2 = valid;
		   if (valid2 > 0)
				dst = (valid2 - count2)/valid2;
		   else
			   dst = 0.0;

		   *(distance + x + y*(nextno+1))= (float)(dst);
		   *(distance + y + x*(nextno+1))= (float)(dst);
		   *(validx + x + y*(nextno+1))= (float)(valid);
		   *(validx + y + x*(nextno+1))= (float)(valid);
		   *(diffsx + x + y*(nextno+1))= (float)(count);
		   *(diffsx + y + x*(nextno+1))= (float)(count);
		   ad = ad + (1.0 - dst);
		   if(dst < upper)
			   upper = dst;
		}
	   upper = (double)(1 - dst);
	}
	*avdst = ad; 
	return(upper);
}

int FAR pascal JCDist(short int bootreps, short int jcflag,short int nextno,int lenseq,short int *seqnum,double *dmat,int *wmod, int *count, int *valid)
{
	//int *count;
	//int *valid;
	double count2;
	double valid2;
	double dst, th1,th2,th3;
	short int s1, s2;
	long xoff, yoff;
	int w,wm;
	
	//count = (int *)malloc(bootreps*sizeof(int));
	//valid = (int *)malloc(bootreps*sizeof(int));
	
	for(int x = 0;x < nextno;x++){
		xoff = x*(lenseq+1);
		for (int y = x+1; y<=nextno; y++){
		   yoff = y*(lenseq+1);
		   for (w = 0; w <=bootreps; w++){
			   count[w] = 0;
			   valid[w] = 0;
		   }
		  
		   for (int z = 1; z <= lenseq; z++){
			   for (w = 0; w <=bootreps; w++){
				   wm = *(wmod + z*(bootreps+1) + w);
				   if (wm > 0){
					   s1 = *(seqnum + z + xoff);
					   s2 = *(seqnum + z + yoff);
					   if(s1 > 64 && s2 > 64){
							   valid[w] += wm;
							   if (s1 == s2)
									count[w] += wm;
					   }
				   }
			   }
		   }    
		   //return 1;
		   for (w = 0; w <bootreps; w++){

			   count2 = count[w];
			   valid2 = valid[w];
			   if (valid2 == 0)
				   valid2 = 0.1;
			   dst = count2/valid2;
			   if (jcflag == 0){
				   *(dmat + (bootreps + 1)*(nextno+1)*(x - 1) + (bootreps +1)*(y - 1) + w) = (float)(1-dst);
				   *(dmat + (bootreps + 1)*(nextno+1)*(y - 1) + (bootreps +1)*(x - 1) + w) = (float)(1-dst);
			   }
			   else{
					 
				    th1 = (4.0 * dst - 1.0);
					th2 = th1 / 3.0;
					th3 = log(th2);
					dst = -0.75 * th3;
						
				   *(dmat + (bootreps + 1)*(nextno+1)*(x - 1) + (bootreps +1)*(y - 1) + w) = (float)(dst);
				   *(dmat + (bootreps + 1)*(nextno+1)*(y - 1) + (bootreps +1)*(x - 1) + w) = (float)(dst);
				   //return 1;
			   }
		   }
		}
	}
	//free(count);
	//free(valid);
	return(1);
}
int FAR pascal MakeTreeArrayX (int nextno, float *tmat2,float *tmat2bak){
	double lowd = 0;
	double lld;
	int y,x;
	double cs = 1.0;
	double holder1,holder2;
	lld = 1000;
	while (lowd < 1000) {
		lowd = 1000;
		for (y = 0; y <=  nextno; y++){
			//offset = y*(nextno+1);
			for (x = y + 1; x <= nextno; x++){
				if(tmat2[x+y*(nextno+1)] < lowd)
					lowd = tmat2[x+y*(nextno+1)];
			}
		}
		if (lowd < 1000) {
			holder1=lowd*lowd;
			for (y = 0; y <=  nextno; y++){
				//offset = y*(nextno+1);

				for (x = y + 1; x <= nextno; x++){
					holder2 = tmat2[x+ y*(nextno+1)]*tmat2[x+ y*(nextno+1)];
					if(holder2/0.99999 >= holder1 && holder2*0.99999 <= holder1){ 
						tmat2bak[x+ y*(nextno+1)] = (float)(cs);
						tmat2[x+ y*(nextno+1)] = 10000;
						tmat2bak[y+ x*(nextno+1)] = (float)(cs);
						tmat2[y+x*(nextno+1)] = 10000;
					}
				}
			}
		}
		else{
			
			for (y = 0; y <=  nextno; y++){
				
				for (x = y + 1; x <= nextno; x++){
					tmat2[x+y*(nextno+1)] = tmat2bak[x+y*(nextno+1)]/1000;
					tmat2[y+x*(nextno+1)] = tmat2[x+y*(nextno+1)];
				}
			}
		
		}
		if (lld != lowd)
			cs++;
		lld=lowd;
	}
	return(1);
	
}
int FAR pascal MakeTreeArray (int nextno, float *tmat2,float *tmat2bak){
	double lowd = 0;
	int y,x;
	double cs = 1.0;
	double holder1,holder2;
	while (lowd < 1000) {
		lowd = 1000;
		for (y = 0; y <=  nextno; y++){
			//offset = y*(nextno+1);
			for (x = y + 1; x <= nextno; x++){
				if(tmat2[x+y*(nextno+1)] < lowd)
					lowd = tmat2[x+y*(nextno+1)];
			}
		}
		if (lowd < 1000) {
			holder1=lowd*lowd;
			for (y = 0; y <=  nextno; y++){
				//offset = y*(nextno+1);

				for (x = y + 1; x <= nextno; x++){
					holder2 = tmat2[x+ y*(nextno+1)]*tmat2[x+ y*(nextno+1)];
					if(holder2/0.99999 >= holder1 && holder2*0.99999 <= holder1){ 
						tmat2bak[x+ y*(nextno+1)] = (float)(cs);
						tmat2[x+ y*(nextno+1)] = 10000;
						tmat2bak[y+ x*(nextno+1)] = (float)(cs);
						tmat2[y+x*(nextno+1)] = 10000;
					}
				}
			}
		}
		else{
			
			for (y = 0; y <=  nextno; y++){
				
				for (x = y + 1; x <= nextno; x++){
					tmat2[x+y*(nextno+1)] = tmat2bak[x+y*(nextno+1)]/1000;
					tmat2[y+x*(nextno+1)] = tmat2[x+y*(nextno+1)];
				}
			}
		
		}
		cs++;
	}
	return(1);
	
}

double FAR pascal MakeRCompat(int *ISeqs, int *CompMat, int WinPP, int Nextno, int *RCompat,int *RCompatB, int *InPen, int *RCats, int *RNum, int *NRNum, int *GoodC, int *DoneX, int *Rlist, int *NRList,float *FAMat, double *LDist){
	//goodc nextno,1
    int X, Y, Z, RL1, RL2, RL3,  nCats, s0, s1,ds0,ds1;
    
	//get non-recombinant list
    s0 = ISeqs[CompMat[WinPP]] ;
	s1 = ISeqs[CompMat[WinPP+3]];
    DoneX[s0]=1;
	DoneX[s1]=1;
	for (X = 0; X <= RNum[WinPP]; X++){
		for( Y = 0; Y <= Nextno; Y++){
			if (DoneX[Y] == 0){ 
				if (GoodC[Y] == 1 || GoodC[Y + Nextno + 1] == 1){
					
					if (FAMat[Rlist[WinPP + X*3] + Y*(Nextno+1)] < LDist[WinPP]){
                            //check and see if it is recombinant
						
						for (Z = 0; Z <= RNum[WinPP]; Z++){
								
                                if (Y == Rlist[WinPP + Z*3])
									break;
						}
						
						if (Z == RNum[WinPP] + 1){
							//ie it is non-recombinant
                            DoneX[Y] = 1;
                            NRList[WinPP + NRNum[WinPP]*3] = Y;
                            NRNum[WinPP] = NRNum[WinPP] + 1;
						}
					}
				}
			}
		}
	}
    
	NRNum[WinPP] = NRNum[WinPP] - 1;
        
    RCompat[WinPP] = 0;
	for (X = 0; X <= RNum[WinPP]; X++){
            //ReDim RCats(Nextno * 3)
			for (Y=0; Y <= Nextno*3; Y++)
				RCats[Y] = 0;

            //get categories
            RL1 = Rlist[WinPP + X*3];
            if (NRNum[WinPP] > -1){
				for (Y = 0; Y <= NRNum[WinPP]; Y++){
					RL2 = NRList[WinPP + Y*3];
					RL3 = (long)((FAMat[RL1 + RL2*(Nextno+1)] * 1000)+0.0000001);
				//	RL4 = FAMat[RL1 + RL2*(Nextno+1)] * 1000;
				//	RL3 = long(RL4);
					RCats[RL3] = 1;
				}
			}
			
			//add the other iseqs
			if (FAMat[RL1 + s0*(Nextno+1)] < LDist[WinPP]){
				for (Y = 0; Y <= RNum[WinPP]; Y++){
					RL2 = Rlist[WinPP + Y*3];
					RL3 = (long)((FAMat[RL2 + s0*(Nextno+1)] * 1000)+0.0000001);
					RCats[RL3] = 1;
				}
			}
			if (FAMat[RL1 + s1*(Nextno+1)] < LDist[WinPP]){
				for (Y = 0; Y <= RNum[WinPP]; Y++){
					RL2 = Rlist[WinPP + Y*3];
					RL3 = (long)((FAMat[RL2 + s1*(Nextno+1)] * 1000)+0.0000001);
					RCats[RL3] = 1;
				}
			}
			//count the categories
			nCats = 0;
			for (Y = 0; Y <= Nextno; Y++)
				nCats = nCats + RCats[Y];
            
			if (nCats > RCompat[WinPP]) 
				RCompat[WinPP] = nCats;
	}
	ds0=0;
	ds1=0;
	for (X = 0; X <= RNum[WinPP]; X++){
		//add iseqs to nrlist
		if (FAMat[Rlist[WinPP + X*3] + s0*(Nextno+1)] < LDist[WinPP] && ds0==0){
			NRNum[WinPP] = NRNum[WinPP] + 1;
			NRList[WinPP + NRNum[WinPP]*3] = s0;
			ds0=1;
		}
		if (FAMat[Rlist[WinPP + X*3] + s1*(Nextno+1)] < LDist[WinPP] && ds1==0){
			NRNum[WinPP] = NRNum[WinPP] + 1;
			NRList[WinPP + NRNum[WinPP]*3] = s1;
			ds1=1;
		} 
	}
    RCompatB[WinPP] = 0;
	if (NRNum[WinPP] > -1){
		for (X = 0; X <= NRNum[WinPP]; X++){
				for (Y=0; Y <= Nextno*3; Y++)
					RCats[Y] = 0;
				//get categories
				RL1 = NRList[WinPP + X*3];
            
				for (Y = 0; Y <= RNum[WinPP]; Y++){
					RL2 = Rlist[WinPP + Y*3];
					RL3 = (long)((FAMat[RL1 + RL2*(Nextno+1)] * 1000)+0.0000001);
					//RL4 = FAMat[RL1 + RL2*(Nextno+1)] * 1000;
					//RL3 = long(RL4);
					RCats[RL3] = 1;
				}

				/*//add the other iseqs
				if (FAMat[RL1 + s0*(Nextno+1)] < LDist[WinPP]){
					for (Y = 0; Y <= RNum[WinPP]; Y++){
						RL2 = Rlist[WinPP + Y*3];
						RL3 = (long)((FAMat[RL2 + s0*(Nextno+1)] * 1000)+0.0000001);
						RCats[RL3] = 1;
					}
				}
				if (FAMat[RL1 + s1*(Nextno+1)] < LDist[WinPP]){
					for (Y = 0; Y <= RNum[WinPP]; Y++){
						RL2 = Rlist[WinPP + Y*3];
						RL3 = (long)((FAMat[RL2 + s1*(Nextno+1)] * 1000)+0.0000001);
						RCats[RL3] = 1;
					}
				}*/
				//count them
				nCats = 0;
				for (Y = 0; Y <= Nextno; Y++)
					nCats = nCats + RCats[Y];
				
				nCats = nCats - 1;
            
				if (nCats > RCompatB[WinPP]) 
					RCompatB[WinPP] = nCats;
		}
	}
    if (NRNum[WinPP] > -1){
		if (RCompatB[WinPP] < RCompat[WinPP]) 
			RCompat[WinPP] = RCompatB[WinPP];
	}
    
    if (RCompat[WinPP] > RNum[WinPP])
		RCompat[WinPP] = RNum[WinPP];
	
	if (RCompat[WinPP] > 0)
		RCompat[WinPP] = RCompat[WinPP] + InPen[WinPP];// 'penalise the inversions

	
        
    
	return(1);
}


int FAR pascal ScanNums(int Nextno, unsigned char *GrpMaskSeq, short int *MaskSeq){

	int Seq1,Seq2,Seq3, MCCorrection, g;
	MCCorrection =0;
	for (Seq1 = 0; Seq1 <= Nextno-2; Seq1++){
		if (MaskSeq[Seq1] == 0){
			for (Seq2 = Seq1 + 1; Seq2 <= Nextno-1; Seq2++){
				if (MaskSeq[Seq2] == 0){
					for (Seq3 = Seq2 + 1; Seq3 <= Nextno; Seq3++){
						if (MaskSeq[Seq3] == 0){
							g=0;
							g=g+(int)(GrpMaskSeq[Seq1]);
							g=g+(int)(GrpMaskSeq[Seq2]);
							g=g+(int)(GrpMaskSeq[Seq3]);
							if (g > 1) 
								MCCorrection = MCCorrection + 1;
							
						}
					}
				}
			}
		}
	}


	return (MCCorrection);

}
int FAR pascal MakeSDM(int NextNo, int SLen, int *SP, int *EP, int *ISeqs, int *CompMat, unsigned char *MissingData, short int *SeqNum, double *SDM, double *DistMat){
int A,X, Y, Z, S0, S1, off0, off1, off2, offy;
short int n0,n1,n2;
double D0, D1, D2, V0, V1, V2, T;

	
	//compmat 2,1
	for (X = 0; X <3; X++){
		S0 = ISeqs[CompMat[X]];
		S1 = ISeqs[CompMat[X+3]];
		off2 = ISeqs[X]*(SLen+1);
		off0 = S0*(SLen+1);
		off1 = S1*(SLen+1);
		
		for (Z = 0; Z < 5; Z++){
			for (Y = 0; Y <= NextNo; Y++){
				T = 0.0;
				D0 = 0.0;
				D1 = 0.0;
				D2 = 0.0;
				V0 = 0.0;
				V1 = 0.0;
				V2 = 0.0;
				A = SP[Z];
				offy = Y*(SLen+1);
				while (A != EP[Z]){
					if (MissingData[A + off0] == 0){ 
						if (MissingData[A + off1] == 0){ 
							if (MissingData[A + off2] == 0){ 
								n0 = SeqNum[A + off0];
								if (n0 != 46) {
									n1 = SeqNum[A + off1];
									if (n1 != 46) {
										n2 = SeqNum[A + offy];
										if (n2 != 46){
											
											if (n2 != n0 || n2 != n1){
												if (n2 == n0) {
													D0 = D0 + 1;
													T = T + 1;
												}
												else if (n2 == n1){
													D1 = D1 + 1;
													T = T + 1;
												}
												else if (n0 == n1){
													D2 = D2 + 1;
													T = T + 1;
												}
											}
										}
                                
									}
                                
								}
								if (Z == 1 || Z == 2 || Z == 4){
									if (SeqNum[A + off2] != 46){
										if (SeqNum[A + off2] != SeqNum[A + offy])
											V1 = V1 + 1;
										
										V0 = V0 + 1;
									}
								}
							}
						}
					}
					A = A + 1;
					if (A > SLen)
						A = 1;
				
				}
            
            //sdm -2,2,nextno
				if (V0 > 0){
					if (Z == 1)
						SDM[X + Y*9] = V1 / V0;
					else if (Z == 2)
						SDM[X + 3 + Y*9] = V1 / V0;
					else if (Z == 4)
						SDM[X + 6 + Y*9] = V1 / V0;
					
				}
				else{
					if (Z == 1)
						SDM[X + Y*9] = 10;
					else if (Z == 2)
						SDM[X + 3 + Y*9] = 10;
					else if (Z == 4)
						SDM[X + 6 + Y*9] = 10;
					
				}
				//distmat 2,4,nextno,2
            
				if (T > 0){
					DistMat[X + Z*3 + Y*15] = D0 / T;
               
					DistMat[X + Z*3 + Y*15 + 15*(NextNo+1)] = D1 / T;
                
					DistMat[X + Z*3 + Y*15 + 30*(NextNo+1)] = D2 / T;
				}
				else{
					DistMat[X + Z*3 + Y*15] = 10; 
                
					DistMat[X + Z*3 + Y*15 + 15*(NextNo+1)] = 10; 
               
					DistMat[X + Z*3 + Y*15 + 30*(NextNo+1)] = 10; 
                
				}
				
			}
		}
	}
	return (1);

}




int FAR pascal PBar(double *pval){
	int xx;
	
	*pval = *pval+0.00001;
	xx=(int)(*pval)*10;
	return(xx);
}

int FAR pascal MakeActualSeqSize(int LS,int Nextno,int WinPP, int *RNum, int *Rlist, int *ActualSeqSize, short int *SeqNum){
	int Y, WinPPY, count3, count4, count1, count2,count5,count6;
	for (WinPPY = 0;WinPPY <= RNum[WinPP]; WinPPY++){
        count3 = (Nextno - RNum[WinPP] + WinPPY);
        count4 = (Rlist[WinPP + WinPPY*3]);
        count6 = count3*(LS+1);
		count5 = count4*(LS+1);
		count1 = 0;
        count2 = 0;
        
        for (Y = 1; Y <= LS; Y++){
            if (SeqNum[Y + count5] != 46)
                count1++;
            
            if (SeqNum[Y + count6] != 46)
                count2++;
        }
        ActualSeqSize[count4] = count1;
        ActualSeqSize[count3] = count2;
	}
	return(1);
}

double FAR pascal StripUnfound(int WinPP, int *RNum, int *Rlist, int *InvList, int *FoundOne, float *RCorr, double *RLScore){
	//rcorr - 2,2,nextno
	//rinv - 2,2,nextno
	//rlist - 2,nextno
	//rlscore 2,nextno
	int  rl1,rl2;
	int Z = 0;
	while (Z <= RNum[WinPP]){
		if (FoundOne[Z] == 0){
			//Even if event not found, nearly perfect matches must still be handled
            //and must be left in rlist
            rl1 = Rlist[WinPP + Z*3];
			if (InvList[WinPP + Z*3] == 1 || RCorr[WinPP + rl1*9] < 0.95 || RCorr[WinPP + 3 + rl1*9] < 0.95 || RCorr[WinPP + 6 + rl1*9] < 0.95){ 
				if (Z < RNum[WinPP]){
					rl2 = Rlist[WinPP + RNum[WinPP]*3];
					RLScore[WinPP + rl1*3] = 0;
   					//for (A = 0; A <3; A++)
					//	RCorr[WinPP + A*3 + rl1*9] = RCorr[WinPP + A*3 + rl2*9];
					Rlist[WinPP + Z*3] = rl2;
                    InvList[WinPP + Z*3] = InvList[WinPP + RNum[WinPP]*3];
                    FoundOne[Z] = FoundOne[RNum[WinPP]];
				}
                RNum[WinPP] = RNum[WinPP] - 1;
			}
			else
				Z++;
		}
		else
			Z++;
	}
	return(1);
	
}

double FAR pascal UpdatePlotInfo(double PVal, int prg,int LSeq,int BPos, int EPos, double Dst, int *MaxHits, double *PDistPlt, double *ProbPlt, int *HitPlt, char *RedoPltL){
	
	int X, off1;
	
	off1 = prg*(LSeq+11);//pltdist etc dimentionsed with 10 extra spaces

	if (EPos > LSeq)
		EPos = LSeq;
        

    if (BPos > LSeq - 10){
            BPos = LSeq - 10;
            EPos = LSeq;
    }

	if (BPos < EPos){

        

        for (X = BPos; X <= EPos; X++)
            HitPlt[X + off1] = HitPlt[X + off1] + 1;

		for (X = BPos; X <= EPos; X++){
            if (PDistPlt[X + off1] < Dst)
                PDistPlt[X + off1] = Dst;
		}
        
		for (X = BPos; X <= EPos; X++){
            if (ProbPlt[X + off1] < PVal)
                ProbPlt[X + off1] = PVal;
		}
        
		for (X = BPos; X <= EPos; X++){
            if (HitPlt[X + off1] > *MaxHits){
                *MaxHits = HitPlt[X + off1]; //*MaxHits + 1;
                RedoPltL[2] = 1;
			}
		}
        
	}

    else{

        for (X = BPos; X <= LSeq; X++)
            HitPlt[X + off1] = HitPlt[X + off1] + 1;

		for (X = BPos; X <= LSeq; X++){
            if (PDistPlt[X + off1] < Dst)
                PDistPlt[X + off1] = Dst;
		}
        
		for (X = BPos; X <= LSeq; X++){
            if (ProbPlt[X + off1] < PVal)
                ProbPlt[X + off1] = PVal;
		}
        
		for (X = BPos; X <= LSeq; X++){
            if (HitPlt[X + off1] > *MaxHits){
                *MaxHits = HitPlt[X + off1]; //*MaxHits + 1;
                RedoPltL[2] = 1;
			}
		}
		
		for (X = 1; X <= EPos; X++)
            HitPlt[X + off1] = HitPlt[X + off1] + 1;

		for (X = 1; X <= EPos; X++){
            if (PDistPlt[X + off1] < Dst)
                PDistPlt[X + off1] = Dst;
		}
        
		for (X = 1; X <= EPos; X++){
            if (ProbPlt[X + off1] < PVal)
                ProbPlt[X + off1] = PVal;
		}
        
		for (X = 1; X <= EPos; X++){
            if (HitPlt[X + off1] > *MaxHits){
                *MaxHits = HitPlt[X + off1]; //*MaxHits + 1;
                RedoPltL[2] = 1;
			}
		}

    }


	return(1);
}
double FAR pascal MakeDst(int lseq, int DA, int Mi, int Ma, int BPos, int EPos, double *VDiffs, short int *SeqNum ){
	int X, s1, s2, s3, off1;
	double Dst, LenR;
	Dst = 0.0;

        LenR = 0.0;
		VDiffs[0] = 0.0;
		VDiffs[1] = 0.0;
		VDiffs[2] = 0.0;
		off1 = lseq+1;
        if (BPos < EPos){
			for (X = BPos; X <= EPos; X++){
               s1 =  SeqNum[X + DA*off1];
			   if (s1 != 46){
				   s2 =  SeqNum[X + Mi*off1];
                    if (s2 != 46){
						s3 =  SeqNum[X + Ma*off1];
                        if (s3 != 46){
                            LenR ++;
                            if (s1 != s2 || s1 != s3) {
                                if (s1 != s2 && s1 == s3)
                                    VDiffs[0] = VDiffs[0] + 1;
                                else if (s1 != s3 && s1 == s2)
                                    VDiffs[1] = VDiffs[1] + 1;
                                else if (s2 != s3 && s2 == s1)
                                    VDiffs[2] = VDiffs[2] + 1;
                                
                            }
                        }
                    }
			   }
			}
		}
        else{
            for (X = BPos; X <= lseq; X++){
               s1 =  SeqNum[X + DA*off1];
			   if (s1 != 46){
				   s2 =  SeqNum[X + Mi*off1];
                    if (s2 != 46){
						s3 =  SeqNum[X + Ma*off1];
                        if (s3 != 46){
                            LenR ++;
                            if (s1 != s2 || s1 != s3) {
                                if (s1 != s2 && s1 == s3)
                                    VDiffs[0] = VDiffs[0] + 1;
                                else if (s1 != s3 && s1 == s2)
                                    VDiffs[1] = VDiffs[1] + 1;
                                else if (s2 != s3 && s2 == s1)
                                    VDiffs[2] = VDiffs[2] + 1;
                                
                            }
                        }
                    }
			   }
			}
           for (X = 1; X <= EPos; X++){
               s1 =  SeqNum[X + DA*off1];
			   if (s1 != 46){
				   s2 =  SeqNum[X + Mi*off1];
                    if (s2 != 46){
						s3 =  SeqNum[X + Ma*off1];
                        if (s3 != 46){
                            LenR ++;
                            if (s1 != s2 || s1 != s3) {
                                if (s1 != s2 && s1 == s3)
                                    VDiffs[0] = VDiffs[0] + 1;
                                else if (s1 != s3 && s1 == s2)
                                    VDiffs[1] = VDiffs[1] + 1;
                                else if (s2 != s3 && s2 == s1)
                                    VDiffs[2] = VDiffs[2] + 1;
                                
                            }
                        }
                    }
			   }
			}
            
        }
        
        if (VDiffs[0] >= VDiffs[1] && VDiffs[0] >= VDiffs[2])
            Dst = VDiffs[0] / LenR;
        else if (VDiffs[1] >= VDiffs[0] && VDiffs[1] >= VDiffs[2])
            Dst = VDiffs[1] / LenR;
        else if (VDiffs[2] >= VDiffs[1] && VDiffs[2] >= VDiffs[0])
            Dst = VDiffs[2] / LenR;
        
		return(Dst);
}

double FAR pascal CalCR(double tmF,int Nextno, int WinPP, int *Iseqs, int *CompMat, float *RCorr, float *RInv, double *IntVal, double *RMat, float *trcorrx){
	//Rcor - 2,2,nextno
	//rinv - 2,2,nextno
	//compmat - 2,1
	//RMat - 2,5,nextno
	//trcorrx 2,2,4,x
	int goon, X, Z, NS, ro1, ro2, ro3 , ro4, e,D, eh;
	double SumX, SumY, SumXY, SumX2, SumY2, td1,td2,td3;
	float  tRCorr;
	for (X = 0; X < 3; X++){
		ro1 = X*3;

		RCorr[WinPP + ro1 + Iseqs[WinPP]*9] = 1;
        RCorr[WinPP + ro1 + Iseqs[CompMat[WinPP]]*9] = 0;
        RCorr[WinPP + ro1 + Iseqs[CompMat[WinPP + 3]]*9] = 0;
	}
    ro2 = Iseqs[WinPP]*18;
	for (Z = 0; Z < 3; Z++){
		for (X = 0; X <= Nextno;X++){
			ro3 = X*9;
			ro4 = X*45;
			RCorr[WinPP+ Z*3 + ro3] = 0;
			RInv[WinPP + Z*3 + ro3] = 0;
			if (X != Iseqs[WinPP]){
                        
                ro1 = X*18;
				
				for (e = 0; e < 6; e++){
					SumX = 0;
                    SumY = 0;
                    SumXY = 0;
                    SumX2 = 0;
                    SumY2 = 0;
                    if (e == 5)
						eh = 4;
					else
						eh=e;
					
					if (e <= 4)
						trcorrx[WinPP + Z*3 + eh*9 + ro4] = 0;
					
                    NS = 6;
                    for (D = 0; D < 6; D++){
                                   
						if (e == 0){
							IntVal[0] = RMat[Z + D*3 + ro2];
                            IntVal[1] = RMat[Z + D*3 + ro1];
						}
						else{
							if (e == 1){//1-0 swap
								if (D == 2 || D == 5){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + D*3 + ro1];
								}
								else if (D == 0 || D == 3){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D + 1)*3 + ro1];
								}
								else{
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D - 1)*3 + ro1];
								}
							}
							else if (e == 2){//2-0 swap
								if (D == 2 || D == 5){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D-2)*3 + ro1];
								}
								else if (D == 0 || D == 3){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D + 2)*3 + ro1];
								}
								else{
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + D*3 + ro1];
								}
								
							}
							else if (e == 3){//2-1 swap
								if (D == 0 || D == 3){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + D*3 + ro1];
								}
								else if (D == 2 || D == 5){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D - 1)*3 + ro1];
								}
								else{
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D + 1)*3 + ro1];
								}
								
							}
							else if (e == 4){//all swap1
								if (D == 2 || D == 5){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D-2)*3 + ro1];
								}
								else if (D == 0 || D == 3){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D + 1)*3 + ro1];
								}
								else{
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D + 1)*3 + ro1];
								}
							}
							else if (e == 5){//all swap2
								if (D == 2 || D == 5){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D-1)*3 + ro1];
								}
								else if (D == 0 || D == 3){
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D + 2)*3 + ro1];
								}
								else{
									IntVal[0] = RMat[Z + D*3 + ro2];
									IntVal[1] = RMat[Z + (D - 1)*3 + ro1];
								}
								
							}
                                        
						}
						if (IntVal[0] > 4 || IntVal[1] > 4){
							NS --;
							break;
						}
						else{
							SumX = SumX + IntVal[0];
							SumY = SumY + IntVal[1];
							SumXY = SumXY + IntVal[0] * IntVal[1];
							SumX2 = SumX2 + IntVal[0] * IntVal[0];
							SumY2 = SumY2 + IntVal[1] * IntVal[1];
						}
					}
					goon = 0;
					if (NS == 6){
						
						if (SumX2 > 0){
							if (SumY2 > 0){
								td2 = SumX * SumX;
								td3 = 6.0 * SumX2;
								td3 = td3 - td2;
								if (td3 > 0.000000001){
									td1 = pow(td3,0.5);
									td2 = SumY * SumY;
									td3 = 6.0 * SumY2;
									td3 = td3 - td2;
									if (td3 > 0.000000001){
									
										//decrease r-vals that don't pass through the ori?
										goon=1;
										
										td2 = pow(td3, 0.5);
										td3 = SumX * SumY;
										tRCorr = (float)(6.0 * SumXY);
										tRCorr = tRCorr - (float)(td3);
										td3 = (td1 * td2);
										if ((float)(td3) > 0)
											tRCorr = tRCorr / (float)(td3);
										else
											tRCorr = 0;
										tRCorr = tRCorr + (float)(tmF);
										
										
										if (e == 5){
											if (trcorrx[WinPP + Z*3 + eh*9 + ro4] < tRCorr)
												trcorrx[WinPP + Z*3 + eh*9 + ro4] = tRCorr;
										}
										else
											trcorrx[WinPP + Z*3 + eh*9 + ro4] = tRCorr;
										
										if (eh == 0) {
											RCorr[WinPP + Z*3 + ro3] = (float)(tRCorr);
											RInv[WinPP + Z*3 + ro3] = 0.0;
										}
										else{//if ((RCorr[WinPP + Z*3 + ro3] < 0.83 && RInv[WinPP + Z*3 + ro3] == 0 ) || RInv[WinPP + Z*3 + ro3] > 0) {
											if (trcorrx[WinPP + Z*3 +  ro4] < 0.83){
													if (RCorr[WinPP+ Z*3 + ro3]<tRCorr) {
														RCorr[WinPP + Z*3 + ro3] = tRCorr;
														RInv[WinPP + Z*3 + ro3] = (float)(eh);
													}
											}
										}
									}
								}
							}
						}
						
						
						if (goon == 0){
							if (eh == 0) {
								if ((6.0 * SumY2) == (SumY * SumY) || (6.0 * SumX2) == (SumX * SumX)){ 
                                        RCorr[WinPP+ Z*3 + ro3] = 1.0;
										trcorrx[WinPP + Z*3 + eh*9 + ro4] = 1.0;
										RInv[WinPP + Z*3 + ro3] = 0;
								}
								else{
                                        RCorr[WinPP+ Z*3 + ro3] = 0.0;
										trcorrx[WinPP + Z*3 + eh*9 + ro4] = 0.0;
								}
							}
                                    
							else{
								//if (RCorr[WinPP+ Z*3 + ro3] <= 0){
									if ((6.0 * SumY2) == (SumY * SumY) || (6.0 * SumX2) == (SumX * SumX)){
										trcorrx[WinPP + Z*3 + eh*9 + ro4] = 1.0;
										//RCorr[WinPP+ Z*3 + ro3] = 1.0;
									}
									else{
										trcorrx[WinPP + Z*3 + eh*9 + ro4] = 0.0;
                                        //RCorr[WinPP+ Z*3 + ro3] = 0.0;
									}
                                //}
							}
						}
					}
                    else if (eh == 0){
						RCorr[WinPP+ Z*3 + ro3] = 0;
						trcorrx[WinPP + Z*3 + eh*9 + ro4] = 0;
					}
					else{
						//if (RCorr[WinPP+ Z*3 + ro3] <= 0){
							//RCorr[WinPP+ Z*3 + ro3] = 0;
							trcorrx[WinPP + Z*3 + eh*9 + ro4] = 0;

						//}
					}
                               
					
                            
				}
			}
			else{
				trcorrx[WinPP + Z*3  + ro4] = 1;
				RCorr[WinPP+ Z*3 + ro3] = 1;
			}
		}
	}

	return(1);
}


double FAR pascal MakeLMat(int X, int Nextno,double *LMat, double *PDist, float *SubValidx, float *SubDiffsx, int *Iseqs, int *CompMat, double *AVSN){
	int  Y, WinPP,Z,A;
	//lmat 2 3 1 nextno
	if (AVSN[X] > 0){
		for (WinPP = 0; WinPP < 3; WinPP++){
			if (SubValidx[Iseqs[CompMat[WinPP]] + (Iseqs[CompMat[WinPP + 3]])*(Nextno+1)] > 20)
				PDist[WinPP + X*3] = SubDiffsx[Iseqs[CompMat[WinPP]] + (Iseqs[CompMat[WinPP + 3]])*(Nextno+1)]/SubValidx[Iseqs[CompMat[WinPP]] + (Iseqs[CompMat[WinPP + 3]])*(Nextno+1)];
			else
				PDist[WinPP + X*3] = 1.0;

			for (Y = 0; Y <2; Y++){
					Z = Iseqs[CompMat[WinPP + Y*3]];
					for (A = 0; A <= Nextno; A++){
						if (SubValidx[Z + A*(Nextno+1)] > 20)
							LMat[WinPP + X*3 + Y*12 + A*24] = SubDiffsx[Z + A*(Nextno+1)]/SubValidx[Z + A*(Nextno+1)];//AVSN[X];
						else
							LMat[WinPP + X*3 + Y*12 + A*24] = 1.0;
					}
			}
		}
	}
	else{
		for (WinPP = 0; WinPP < 3; WinPP++){
			if (SubValidx[Iseqs[CompMat[WinPP]] + (Iseqs[CompMat[WinPP + 3]])*(Nextno+1)] > 20)
				PDist[WinPP + X*3] = SubDiffsx[Iseqs[CompMat[WinPP]] + (Iseqs[CompMat[WinPP + 3]])*(Nextno+1)]/SubValidx[Iseqs[CompMat[WinPP]] + (Iseqs[CompMat[WinPP + 3]])*(Nextno+1)];
			else
				PDist[WinPP + X*3] = 1.0;

			for (Y = 0; Y <2; Y++){
					Z = Iseqs[CompMat[WinPP + Y*3]];
					for (A = 0; A <= Nextno; A++){
						if (SubValidx[Z + A*(Nextno+1)] > 20)
							LMat[WinPP + X*3 + Y*12 + A*24] = SubDiffsx[Z + A*(Nextno+1)]/SubValidx[Z + A*(Nextno+1)];
						else
							LMat[WinPP + X*3 + Y*12 + A*24] = 1.0;
					}
			}
		}
	}




	return(1);
}



double FAR pascal UltraTreeDist(double MD, int MaxCurPos, int NumberOfSeqs,float *TMat2, double *NumDone, int *DoneThis, int *AbBe, int *NodeOrder, double *MidNode, double *NodeLen ){
	int Y,Z,C,A;
	double TallyDist, Modi;

	for (Y = 0; Y <= MaxCurPos;Y++){
        if (NodeOrder[Y] == NodeOrder[(int)(MidNode[0])])
			break;
        AbBe[Y] = 1;
    }
                         
    for (Y = MaxCurPos; Y >= 0; Y--){
        if (Y == MaxCurPos) {
            while (NodeOrder[Y] == 0)
                Y--;
            
        }
        if (NodeOrder[Y] == NodeOrder[(int)(MidNode[0])])
			break;
        AbBe[Y] = 3;
    }
       
    for (Y = MaxCurPos; Y >= 0; Y--){
        if (Y == MaxCurPos) {
            while (NodeOrder[Y] == 0)
                Y--;
        }
        if (AbBe[Y] == 0)
            AbBe[Y] = 2;
        
    }
        
    //now modify the tree distance matrix to reflect equal distances from the root
    //In effect its lengthening the terminal branches so that the distance between
    //sequences in a distance matrix will reflect their reletive positions in the tree
    //in relation to the midpoint "root"
    //first do the "left" part of the tree
    
    for (Y = 0; Y <= MaxCurPos;Y++){
        if (AbBe[Y] > 0){
			if (NodeOrder[Y] <= NumberOfSeqs){
				if (DoneThis[NodeOrder[Y]] == 0){ 
					DoneThis[NodeOrder[Y]] = 1;
					TallyDist = 0.0;
					for (Z = 0; Z <= MaxCurPos; Z++)
						NumDone[Z] = 1.0;
					
					if (NodeOrder[Y] != NodeOrder[(int)(MidNode[0])]){
						TallyDist = TallyDist + NodeLen[NodeOrder[Y]];
						NumDone[NodeOrder[Y]] = -NumDone[NodeOrder[Y]];
						if (AbBe[Y] == 2 || AbBe[Y] == 1){
							for (Z = Y + 1; Z <= MaxCurPos; Z++){
								if (NodeOrder[Z] == NodeOrder[(int)(MidNode[0])]){
									TallyDist = TallyDist + MidNode[AbBe[Y]];
									Modi = MD - TallyDist;
                                                    
									C = NodeOrder[Y];
									for (A = 0; A <= NumberOfSeqs; A++){
										if (A != C) {
											TMat2[A + C*(NumberOfSeqs+1)] = TMat2[A + C*(NumberOfSeqs+1)] + (float)(Modi);
											TMat2[C + A*(NumberOfSeqs+1)] = TMat2[A + C*(NumberOfSeqs+1)];
										}
									}
									break;
								}
								else if (NodeOrder[Z] > NumberOfSeqs){
									TallyDist = TallyDist + NodeLen[NodeOrder[Z]] * NumDone[NodeOrder[Z]];
									NumDone[NodeOrder[Z]] = -NumDone[NodeOrder[Z]];
								}
							}
						}
						else {
							for (Z = Y - 1; Z >= 0; Z--){
                                                
								if (NodeOrder[Z] == NodeOrder[(int)(MidNode[0])]){
									TallyDist = TallyDist + MidNode[1];
									Modi = MD - TallyDist;
									C = NodeOrder[Y];
									for (A = 0; A <= NumberOfSeqs;A++){
										if (A != C){
											TMat2[A + C*(NumberOfSeqs+1)] = TMat2[A + C*(NumberOfSeqs+1)] + (float)(Modi);
											TMat2[C + A*(NumberOfSeqs+1)] = TMat2[A + C*(NumberOfSeqs+1)];
										}
									}
									break;
								}
								else if (NodeOrder[Z] > NumberOfSeqs) {
									TallyDist = TallyDist + NodeLen[NodeOrder[Z]] * NumDone[NodeOrder[Z]];
									NumDone[NodeOrder[Z]] = -NumDone[NodeOrder[Z]];
								}
							}
						}
					}
				}
			}
		}
        else if (AbBe[Y] == 0) 
            break;
        
    }
	return(1);
}

double FAR pascal TreeMid(int MaxCurPos, int NumberOfSeqs,double *NumDone, float *TMat2, int *TB, int *NodeOrder, double *MidNode, double *NodeLen){
	
	int Seq1,Seq2,nextno, Y,  Z, C, Pos,Inside;
	double MD, tdist;
	tdist = 0.0;
	//Find greatest distance between seqs in tree
	nextno = NumberOfSeqs+1;
	MD = 0.0;
	for (Seq1 = 0; Seq1 < NumberOfSeqs; Seq1++){
		for (Seq2 = Seq1+1; Seq2 <= NumberOfSeqs; Seq2++){
			if (MD < TMat2[Seq1 + Seq2*nextno]) {
				MD = TMat2[Seq1 + Seq2*nextno];
				TB[0] = Seq1;
				TB[1] = Seq2;
			}
		}
	}

	MD = MD/2;
	for (Y = 0; Y<= MaxCurPos; Y++)
		NumDone[Y] = 1;
	

	//Find Midpoint of the Tree

	for (Y = 0; Y<= MaxCurPos; Y++){
		if (NodeOrder[Y] == TB[0]){ 
			Pos = Y + 1;
			do{
				//mark the route
				if (NodeOrder[Pos] > NumberOfSeqs)
					NumDone[NodeOrder[Pos]] = -NumDone[NodeOrder[Pos]];
				else{
					if (NodeOrder[Pos] == TB[1])
						break;
				}
				Pos++;
			} while (NodeOrder[Pos] != TB[1]);
			
			
			
			tdist = tdist + *(NodeLen + *(NodeOrder +Y));
			if (tdist < MD){
				for (Z = Y + 1; Z <= Pos; Z++){
					if (NodeOrder[Z] > NumberOfSeqs || NodeOrder[Z] == NodeOrder[Pos]){ 
						if (NumDone[NodeOrder[Z]] == -1.0 || NodeOrder[Z] == NodeOrder[Pos]){
							NumDone[NodeOrder[Z]] = -NumDone[NodeOrder[Z]]; 
							if (tdist + NodeLen[NodeOrder[Z]] < MD)
								tdist = tdist + NodeLen[NodeOrder[Z]];
							else{
								Inside = 0;
								C = Z;
								while (C > 0){
									C--;
									if(NodeOrder[C] == NodeOrder[Z]){
										Inside = 1;
										break;
									}
								}
                            
								//midpoint found
								if (Inside == 0){
									MidNode[0] = (double)(Z);
									MidNode[1] = MD - tdist;
									MidNode[2] = NodeLen[NodeOrder[Z]] - MidNode[1];
									break;
								}
								else if (Inside == 1){
									MidNode[0] = (double)(Z);
									MidNode[2] = MD - tdist;
									MidNode[1] = NodeLen[NodeOrder[Z]] - MidNode[2];
									break;
								}
							}
						}
					}
				}
			}
			else{
				MidNode[0] = (double)(Y);
				MidNode[2] = MD;
				MidNode[1] = NodeLen[NodeOrder[Y]] - MidNode[2];
			}
			break;
		}
		else if (NodeOrder[Y] == TB[1]){
			Pos = Y + 1;
			//mark the route between the most distant sequences
			do{
				if (NodeOrder[Pos] > NumberOfSeqs)
					NumDone[NodeOrder[Pos]] = -NumDone[NodeOrder[Pos]];
				else if (NodeOrder[Pos] == TB[0])
					break;
				Pos++;
			}while (NodeOrder[Pos] != TB[0]);
                             
			tdist = *(NodeLen+NodeOrder[Y]);
			if (tdist < MD){
				for (Z = Y + 1; Z<=Pos; Z++){
					if (NodeOrder[Z] > NumberOfSeqs || NodeOrder[Z] == NodeOrder[Pos]){
						if (NumDone[NodeOrder[Z]] == -1 || NodeOrder[Z] == NodeOrder[Pos]){
							NumDone[NodeOrder[Z]] = -NumDone[NodeOrder[Z]];
							if (tdist + NodeLen[NodeOrder[Z]] < MD)
								tdist = tdist + NodeLen[NodeOrder[Z]];
							else{
								Inside = 0;
								C = Z;
								while (C > 0){
									C --;
									if (NodeOrder[C] == NodeOrder[Z]) {
										Inside = 1;
										break;
									}
								}
								//midpoint found
								if (Inside == 0){
									MidNode[0] = (double)(Z);
									MidNode[1] = MD - tdist;
									MidNode[2] = NodeLen[NodeOrder[Z]] - MidNode[1];
									break;
									
								}
								else if (Inside == 1){
									MidNode[0] = (double)(Z);
									MidNode[2] = MD - tdist;
									MidNode[1] = NodeLen[NodeOrder[Z]] - MidNode[2];
									break;
								}
							}
						}
					}
				}
			}
			else{
				MidNode[0] = Y;
				MidNode[2] = MD;
				MidNode[1] = NodeLen[NodeOrder[Y]] - MidNode[2];
			}
			break;
		}
	}
	return(MD);
}

double FAR pascal TreeToArray (short int nlen2, int nextno, int treelen, char *sholder, float *tmat,int  *nodeorder, int *donenode, int *tempnodeorder, unsigned char *rootnode, double *nodelen, double *numdone){
	
	int  zz, done0, dh,tcpos, maxcurpos, tnode,  x, z, y, lpos, currentpos,tpos, totcount, currentnode;
	double tallydist,th1,th2,th3;
	//Set the various position counters
	
	
	maxcurpos = nextno * 3;
	

	lpos = 0;
	currentpos = 0;
	totcount = 0;
    
    currentnode = nextno;
    
	
	//Move through the treefile one character at a time and work out tree
    //distances between sequences
    
	while (lpos < treelen && currentpos <= maxcurpos){
		lpos ++;
        if (sholder[lpos] == 83 && currentpos <= maxcurpos){ //If character is "S" - indicates a sequence name
			
			//Read in the current sequence number
            for (x = 1; x <= nlen2; x++){
					nodeorder[currentpos] += (int)(0.1+(sholder[lpos + x] - 48)*pow(10,nlen2-x));//*10^(1);//nlen2 - x);// Val(Mid$(TreeOut, lpos + 1, NameLen))
				
			}
			//return((double)(nodeorder[currentpos]));
			//return nodeorder[currentpos]; 
					//Update position to that of the "P" character +2
            tpos = lpos + 2;
                    
            //Find the decimal that indicaties the position of the branch length
            while (tpos < treelen){
				if (sholder[tpos] == 46){ //  'If caracter is "."
					if (sholder[tpos - 2] != 45){ // ' ie if number is not negative
						//NodeLen(NodeOrder(currentpos)) = Val(Mid$(TreeOut, tpos - 1, 6))
						dh = 2;
						for (x = 0; x <= 6; x++){
							if (sholder[tpos - 2 + x] > 47 && sholder[tpos - 2 + x] < 58){
								th1 = 6-x-dh;
								th2 = pow(10,th1);
								th3 = sholder[tpos - 2 + x] - 48;
								nodelen[nodeorder[currentpos]] += th3*th2;//(sholder[tpos - 2 + x] - 48)*pow(10,6-x-dh);
							}
							else
								dh--;
						}
					}
					else{
						dh = 2;
						for (x = 0; x <= 6; x++){
							if (sholder[tpos - 2 + x] > 47 && sholder[tpos - 2 + x] < 58){
								th1 = 6-x-dh;
								th2 = pow(10,th1);
								th3 = sholder[tpos - 2 + x] - 48;
								nodelen[nodeorder[currentpos]] += th3*th2;//(sholder[tpos - 2 + x] - 48)*pow(10,6-x-dh);
							}
					
							else
								dh--;
						}
						//nodelen[nodeorder[currentpos]] *= -1.0;//uncomment if neg branches alowed
						nodelen[nodeorder[currentpos]] = 0.0;
					
					}
					nodelen[nodeorder[currentpos]] /= 10000;
                    
					donenode[nodeorder[currentpos]] = 1;
                    break;
				
                }
                tpos ++;
				
            }
		           
            //Find next available Node slot
            while (currentpos <= maxcurpos) {
				currentpos ++;
                if (nodeorder[currentpos] == 0)
                    break;
            }
			
        }    
		else if (sholder[lpos] == 40 && currentpos <= maxcurpos){ //"(" - ie a new node
            
			currentnode++;
            nodeorder[currentpos] = currentnode;
            //Find next available Node slot
            while (nodeorder[currentpos] != 0){
				currentpos ++;
                if (currentpos > maxcurpos)
					break;
			}
                
            if (currentnode != nextno + 1){  //If its not the first internal node
				//The idea here is to find the matching ")" to get the branch length for this node
                tnode = currentnode;
                tcpos = currentpos;
                tpos = lpos;
                do{
					tpos ++;
                    if (sholder[tpos] == 40) {//'"("
						tnode ++; //'Increace node count
                        tcpos ++;
                        if (tcpos > maxcurpos) 
							break;
					}
					else if (sholder[tpos] == 83) {//   '"S"
                        tpos += nlen2 + 7;
                        tcpos ++;
                        if (tcpos > maxcurpos)
							break;
					}
					else if (sholder[tpos] == 41){// '")"
                        tcpos ++;
                        if (tcpos > maxcurpos)
							break;
                        tnode --; // ' Decrease node count until the count matches currentnode-1
                        if (tnode == currentnode - 1){
							//Get the brnach length
                            //tpos += 3;
                            while (tpos < treelen){
								tpos++;
								if (sholder[tpos] == 46)
									break;
							}
							
							if (sholder[tpos - 2] != 45){ // ' ie if number is not negative
						//NodeLen(NodeOrder(currentpos)) = Val(Mid$(TreeOut, tpos - 1, 6))
								dh = 2;
								for (x = 0; x <= 6; x++){
									if (sholder[tpos - 2 + x] > 47 && sholder[tpos - 2 + x] < 58){
										th1 = 6-x-dh;
										th2 = pow(10,th1);
										th3 = sholder[tpos - 2 + x] - 48;
										nodelen[currentnode] += th3*th2;//(sholder[tpos - 2 + x] - 48)*pow(10,6-x-dh);
									}
									else
										dh--;
								}
							}
							else{
								dh = 2;
								for (x = 0; x <= 6; x++){
									if (sholder[tpos - 2 + x] > 47 && sholder[tpos - 2 + x] < 58){
										th1 = 6-x-dh;
										th2 = pow(10,th1);
										th3 = sholder[tpos - 2 + x] - 48;
										nodelen[currentnode] += th3*th2;//(sholder[tpos - 2 + x] - 48)*pow(10,6-x-dh);
									}
									else
										dh--;
								}							
								//nodelen[currentnode] *= -1.0;//uncomment if negative branch lengths allowed
								nodelen[currentnode] = 0.0;
							}
							//return nodeorder[currentpos];
							nodelen[currentnode] /= 10000;
                            donenode[currentnode] = 1;
                            nodeorder[tcpos - 1] = currentnode;
						}
					}
					else if (sholder[tpos] == 59 || sholder[tpos] == 0)// '";" ' If end of the tree is reached
						break;
					
				} while (donenode[currentnode] == 0);
				//return 4;
			}
		}
		else if (sholder[lpos] == 59 || sholder[lpos] == 0){  //'";" ' End of the tree reached so calculate the matrix
			
			currentnode = nextno;
			currentpos = 0;
			break;
		}
	
	}//do
	
	for (z = 0; z <= maxcurpos; z++)
		tempnodeorder[z] = nodeorder[z];
	
	for (y = 0; y <= nextno * 2; y++){
		if (tempnodeorder[y] > nextno + 1){
			z = y + 1;
            while (tempnodeorder[z] != tempnodeorder[y]){
				if (tempnodeorder[z] > -1) 
					*(rootnode + tempnodeorder[y] + tempnodeorder[z]*(maxcurpos+1)) = 1;
                z++;
                if (z > maxcurpos){
					z--;
                    break;
                }
            }
			//return 5;
            tempnodeorder[z] = -1;
            tempnodeorder[y] = -1;
		}
	}
        
    //Work out pairwise distances and write them to an outfile
    
	for( x = 0; x <= maxcurpos; x++){
			if (nodelen[x] < 0.0) 
				nodelen[x] = 0.0;
			else if(nodelen[x] > 1.0) 
				nodelen[x] = 1.0;
	}
                    
	done0 = 0;
                    
	for(zz = 0; zz <= maxcurpos; zz++){
		if (nodeorder[zz] == 0){
			if (done0 == 0) 
				done0 = 1;
			else if(done0 == 1) {
				nodeorder[zz] = nextno + 1;
				break;
			}
		}
	}
		


	for (y = 0; y<= maxcurpos; y++){
			if (nodeorder[y] == nextno + 1){ 
				if (y > 2)
					break;
			}
			for (z = 0; z<= maxcurpos; z++)
				numdone[z] = 1;
			
			if (nodeorder[y] <= nextno){
				tallydist = nodelen[nodeorder[y]];
				for (z = y + 1; z <= maxcurpos;z++){
					if (nodeorder[z] == nextno + 1) 
						break;
					if (nodeorder[z] > nextno){
						tallydist += nodelen[nodeorder[z]] * numdone[nodeorder[z]];
						numdone[nodeorder[z]] = numdone[nodeorder[z]] * -1.0;
					}
                                    
					else{
						tmat[nodeorder[y] + nodeorder[z]*(nextno+1)] = (float)(tallydist + nodelen[nodeorder[z]]);
						tmat[nodeorder[z] + nodeorder[y]*(nextno+1)] = tmat[nodeorder[y] + nodeorder[z]*(nextno+1)];
					}
				}
			}
			
	}


	//return 1;
   
	//for (x = 0; x < nextno; x++){
	//	for(z = x + 1; z <= nextno; z++){
	//		for (y = nextno + 1; y <= nextno * 2;y++){
	//			if ((*(rootnode + y + x*(maxcurpos*2+1) ) == 1 && *(rootnode + y + z*(maxcurpos*2+1)) == 0) || (*(rootnode + y + x*(maxcurpos*2+1)) == 0 && *(rootnode + y + z*(maxcurpos*2+1)) == 1))
	//				*(tmat + x + (nextno+1) * z) +=  nodelen[y];
	//		}
	//		*(tmat + x + (nextno+1)*z) += (nodelen[x] + nodelen[z]);
	//		*(tmat + z + (nextno+1)*x) = *(tmat + x + (nextno+1)*z);
	//	}
	//}
	
	//free (nodelen);
	//free (tempnodeorder);
	//free (donenode);
	//free (nodeorder);

	return 6;
}

int FAR pascal MakeNumSeq (int Nextno, int SLen, int UBNS, int StartPosInAlign, int EndPosInAlign, unsigned char *ConvNumSeq, short int *SeqNum, unsigned char *NumSeq){
	int X, Y, Offset, os1, os2, os3, os4, os5, os6;
	
	os1 = SLen+1;
	os5 = UBNS+1;
	

	ConvNumSeq[66] = 1;
	ConvNumSeq[68] = 2;
	ConvNumSeq[72] = 3;
	ConvNumSeq[85] = 4;

	if (StartPosInAlign < EndPosInAlign){
		for (X = 0; X <= Nextno; X++){
			os4 = os1*X;
			os6 = os5*X;
			for (Y = StartPosInAlign; Y <= EndPosInAlign; Y++){
				os2 = Y + os4;
				os3 = Y + os6 - StartPosInAlign + 1;
				NumSeq[os3] =  ConvNumSeq[SeqNum[os2]];//for some reason without this offset the wrong number is read from seqnum
			}
		}
	}
	else{
		Offset = SLen - StartPosInAlign + 1;
		for (X = 0; X <= Nextno; X++){
			os4 = os1*X;
			os6 = os5*X;
			for (Y = StartPosInAlign; Y <= SLen; Y++){
				os2 = Y + os4;
				os3 = Y + os6 - StartPosInAlign + 1;
				NumSeq[os3] = ConvNumSeq[SeqNum[os2]];

			}
			
			for (Y = 1; Y <= EndPosInAlign; Y++){
				os2 = Y + os4;
				os3 = Y + os6 + Offset;
				NumSeq[os3] = ConvNumSeq[SeqNum[os2]];
				
			}
			
		}
	}

	return(1);
}

int FAR pascal MakeISeq4 (int Nextno, int UBNS, int UBIS4, short int *SeqCompressor4, short int *ISeq4,  char *NumSeq){
	//SeqCompressor4(4,4,4,4), ISeq4(UBIS4,Nextno)
	int X, Y, A, B, C, D, StepPos, os1, os2, os3, os4;
	os1 = UBNS+1;
	os3 = UBIS4+1;
	for (X = 0; X<= Nextno;X++){
		StepPos = 0;
		os2 = os1*X;
		os4 = os3*X;
		for (Y = 1; Y<= UBNS - 4; Y+=4){
			StepPos++;
			A = (int)(NumSeq[Y + os2]);
			B = (int)(NumSeq[Y + 1 + os2]);
			C = (int)(NumSeq[Y + 2 + os2]);
			D = (int)(NumSeq[Y + 3 + os2]);
			ISeq4[StepPos + os4] = SeqCompressor4[A + B*5 + C*25 + D*125];
		}
		StepPos++;
		A = 0;
		B = 0;
		C = 0;
		D = 0;
		if (Y <= UBNS){
			A = (int)(NumSeq[Y + os2]);
			if (Y + 1 <= UBNS){
				B = (int)(NumSeq[Y + 1 + os2]);
				if (Y + 2 <= UBNS){
					C = (int)(NumSeq[Y + 2 + os2]);
					if (Y + 3 <= UBNS)
						D = (int)(NumSeq[Y + 3 + os2]);
					
				}
			}
		}
		ISeq4[StepPos + os4] = SeqCompressor4[A + B*5 + C*25 + D*125];
	}
	return(1);
}


double FAR pascal TreeToArrayB (short int nlen2, int nextno, int treelen, short int *sholder, float *tmat,int  *nodeorder, int *donenode, int *tempnodeorder, unsigned char *rootnode, double *nodelen){
	
	int tcpos, maxcurpos, tnode,  x, z, y, lpos, currentpos,tpos, totcount, currentnode;
	
	//Set the various position counters
	
	maxcurpos = nextno * 3;
	

	lpos = 0;
	currentpos = 0;
	totcount = 0;
    
    currentnode = nextno;
    
	
	//Move through the treefile one character at a time and work out tree
    //distances between sequences
    
	while (lpos < treelen && currentpos <= maxcurpos){
		lpos ++;
        if (sholder[lpos] == 83 && currentpos <= maxcurpos){ //If character is "S" - indicates a sequence name
			
			//Read in the current sequence number
            for (x = 1; x <= nlen2; x++)
					nodeorder[currentpos] += (int)(0.1+(sholder[lpos + x] - 48)*pow(10,nlen2-x));//*10^(1);//nlen2 - x);// Val(Mid$(TreeOut, lpos + 1, NameLen))
			
			//return nodeorder[currentpos]; 
					//Update position to that of the "P" character +2
            tpos = lpos + 2;
                    
            //Find the decimal that indicaties the position of the branch length
            while (tpos < treelen){
				if (sholder[tpos] == 46){ //  'If caracter is "."
					/*if (sholder[tpos - 2] != 45){ // ' ie if number is not negative
						dh = 2;
						for (x = 0; x <= 6; x++){
							if (sholder[tpos - 2 + x] > 47 && sholder[tpos - 2 + x] < 58){
								th1 = 6-x-dh;
								th2 = pow(10,th1);
								th3 = sholder[tpos - 2 + x] - 48;
								nodelen[nodeorder[currentpos]] += th3*th2;//(sholder[tpos - 2 + x] - 48)*pow(10,6-x-dh);
								
							  }
							else
								dh--;
						}
						nodelen[nodeorder[currentpos]]=1.0;
					}
					else{
						/*dh = 2;
						for (x = 0; x <= 6; x++){
							if (sholder[tpos - 2 + x] > 47 && sholder[tpos - 2 + x] < 58){
								th1 = 6-x-dh;
								th2 = pow(10,th1);
								th3 = sholder[tpos - 2 + x] - 48;
								nodelen[nodeorder[currentpos]] += th3*th2;//(sholder[tpos - 2 + x] - 48)*pow(10,6-x-dh);
							}
					
							else
								dh--;
						}
						nodelen[nodeorder[currentpos]] *= -1.0;
						nodelen[nodeorder[currentpos]]=1.0;
					
					}*/
					nodelen[nodeorder[currentpos]] = 0.01;
                    
					donenode[nodeorder[currentpos]] = 1;
                    break;
				
                }
                tpos ++;
				
            }
		           
            //Find next available Node slot
            while (currentpos <= maxcurpos) {
				currentpos ++;
                if (nodeorder[currentpos] == 0)
                    break;
            }
			
        }    
		else if (sholder[lpos] == 40 && currentpos <= maxcurpos){ //"(" - ie a new node
            
			currentnode++;
            nodeorder[currentpos] = currentnode;
            //Find next available Node slot
            while (nodeorder[currentpos] != 0){
				currentpos ++;
                if (currentpos > maxcurpos)
					break;
			}
                
            if (currentnode != nextno + 1){  //If its not the first internal node
				//The idea here is to find the matching ")" to get the branch length for this node
                tnode = currentnode;
                tcpos = currentpos;
                tpos = lpos;
                do{
					tpos ++;
                    if (sholder[tpos] == 40) {//'"("
						tnode ++; //'Increace node count
                        tcpos ++;
                        if (tcpos > maxcurpos) 
							break;
					}
					else if (sholder[tpos] == 83) {//   '"S"
                        tpos += nlen2 + 7;
                        tcpos ++;
                        if (tcpos > maxcurpos)
							break;
					}
					else if (sholder[tpos] == 41){// '")"
                        tcpos ++;
                        if (tcpos > maxcurpos)
							break;
                        tnode --; // ' Decrease node count until the count matches currentnode-1
                        if (tnode == currentnode - 1){
							//Get the brnach length
                            //tpos += 3;
                            while (tpos < treelen){
								tpos++;
								if (sholder[tpos] == 46)
									break;
							}
							
							/*if (sholder[tpos - 2] != 45){ // ' ie if number is not negative
						//NodeLen(NodeOrder(currentpos)) = Val(Mid$(TreeOut, tpos - 1, 6))
								dh = 2;
								for (x = 0; x <= 6; x++){
									if (sholder[tpos - 2 + x] > 47 && sholder[tpos - 2 + x] < 58){
										th1 = 6-x-dh;
										th2 = pow(10,th1);
										th3 = sholder[tpos - 2 + x] - 48;
										nodelen[currentnode] += th3*th2;//(sholder[tpos - 2 + x] - 48)*pow(10,6-x-dh);
									}
									else
										dh--;
								}
							}
							else{
								dh = 2;
								for (x = 0; x <= 6; x++){
									if (sholder[tpos - 2 + x] > 47 && sholder[tpos - 2 + x] < 58){
										th1 = 6-x-dh;
										th2 = pow(10,th1);
										th3 = sholder[tpos - 2 + x] - 48;
										nodelen[currentnode] += th3*th2;//(sholder[tpos - 2 + x] - 48)*pow(10,6-x-dh);
									}
									else
										dh--;
								}							
								nodelen[currentnode] *= -1.0;
							}
							//return nodeorder[currentpos];
							nodelen[currentnode] /= 10000;*/
							nodelen[currentnode] = 0.01;
                            donenode[currentnode] = 1;
                            nodeorder[tcpos - 1] = currentnode;
						}
					}
					else if (sholder[tpos] == 59 || sholder[tpos] == 0)// '";" ' If end of the tree is reached
						break;
					
				} while (donenode[currentnode] == 0);
				//return 4;
			}
		}
		else if (sholder[lpos] == 59 || sholder[lpos] == 0){  //'";" ' End of the tree reached so calculate the matrix
			
			currentnode = nextno;
			currentpos = 0;
			break;
		}
	
	}//do
	
	for (z = 0; z <= maxcurpos; z++)
		tempnodeorder[z] = nodeorder[z];
	
	for (y = 0; y <= nextno * 2; y++){
		if (tempnodeorder[y] > nextno + 1){
			z = y + 1;
            while (tempnodeorder[z] != tempnodeorder[y]){
				if (tempnodeorder[z] > -1) 
					*(rootnode + tempnodeorder[y] + tempnodeorder[z]*(maxcurpos+1)) = 1;
                z++;
                if (z > maxcurpos){
					z--;
                    break;
                }
            }
			//return 5;
            tempnodeorder[z] = -1;
            tempnodeorder[y] = -1;
		}
	}
        
    //Work out pairwise distances and write them to an outfile
    //return 1;
    for (x = 0; x < nextno; x++){
		for(z = x + 1; z <= nextno; z++){
			for (y = nextno + 1; y <= nextno * 2;y++){
				if ((*(rootnode + y + x*(maxcurpos+1) ) == 1 && *(rootnode + y + z*(maxcurpos+1)) == 0) || (*(rootnode + y + x*(maxcurpos+1)) == 0 && *(rootnode + y + z*(maxcurpos+1)) == 1))
					*(tmat + x + (nextno+1) * z) = *(tmat + x + (nextno+1) * z) + (float)(nodelen[y]);
			}
			*(tmat + x + (nextno+1)*z) = *(tmat + x + (nextno+1)*z) + (float)(nodelen[x] + nodelen[z]);
			*(tmat + z + (nextno+1)*x) = *(tmat + x + (nextno+1)*z);
		}
	}
	

	return 6;
}

int FAR pascal GetPltVal(short int bootreps, int y, short int *t0, short int *t1, short int *t2, double *pltval)
{
	
	short int x;
	short int p1 = 0,p2 = 0,p3 = 0;
	
	for (x = 0; x < bootreps; x++){
        if (t0[x] < 32000 && t1[x] <32000 && t2[x] <32000){
			if (t0[x] < t1[x] && t0[x] < t2[x])
			   p1++;
			else if (t1[x] < t0[x] && t1[x] < t2[x])
			   p2++;
			else if (t2[x] < t0[x] && t2[x] < t1[x])
			   p3++;
		}
	}
	//return 1;
	*(pltval + y*3) = p1;
	*(pltval + y*3 + 1) = p2;
	*(pltval + y*3 + 2) = p3;
	return 1;
}

int FAR pascal FindBeginBS(int CircularFlag,  int BSStepSize, int BSStepWin, int MedHomol, int HighHomol, int LowHomol, long numwins, double BSCutOff, int BSBootReps, int PosCount, short int OverlapNum, double *totalprob,int *lastfull, int *probcounter, int *YVal, double *PVal, double *PPVal, char *EraseAll, int *curpos, double *PltVal){

//pltval - 2,numwins
	int ProbCounter,Z, CurPos, GoOnFlag, Y, LastFull;
	double  TotalProb;
	ProbCounter = 0;
	CurPos = *curpos;
	TotalProb = 0;
	GoOnFlag = 0;
	Y=0;
	LastFull=0;
	while (CurPos >= 0 && CurPos >= PosCount - OverlapNum){
		
		if (PltVal[MedHomol + CurPos*3] < BSCutOff * BSBootReps){
			GoOnFlag = 0;
			for (Z = 0; Z <= OverlapNum; Z++){
				Y = CurPos - Z;
				if (Y == PosCount){
					*EraseAll = 1;
					*PVal = 100000000;
					*PPVal = 1;
					*YVal = *YVal + BSStepWin + BSStepSize + 1;
					return(0);
				}
				if (Y < 1)
					Y = Y + numwins - 1;
				
				if (PltVal[MedHomol + Y*3] <= PltVal[HighHomol + Y*3] || PltVal[MedHomol + Y*3] <= PltVal[LowHomol + Y*3] || PltVal[MedHomol + Y*3] <= (0.4 * BSBootReps)){
					GoOnFlag = 0;
					break;
				}
					
				else if (PltVal[MedHomol + Y*3] >= BSCutOff * BSBootReps){
					GoOnFlag = 1;
					CurPos = Y;
					break;
				}
				ProbCounter++;
				TotalProb += PltVal[MedHomol + (CurPos - 1)*3] / BSBootReps;
			}

			if (GoOnFlag == 0){
				if (Y == CurPos && PltVal[MedHomol + Y*3] <= (0.4 * BSBootReps))
					CurPos++;
				break;
			}
		}
		else
			LastFull = CurPos;
		
        
		if (PltVal[MedHomol + CurPos*3] <= PltVal[HighHomol + CurPos*3] || PltVal[MedHomol + CurPos*3] <= PltVal[LowHomol + CurPos*3] || PltVal[MedHomol + CurPos*3] <= (0.5 * BSBootReps)){
			if (PltVal[MedHomol + Y*3] <= 0.4 * BSBootReps)
				CurPos++;
			break;
		}
		ProbCounter++;
    
		TotalProb = TotalProb + PltVal[MedHomol + (CurPos - 1)*3] / BSBootReps;
		CurPos--;
		
		if (CurPos == PosCount){
			*EraseAll = 1;
			*PVal = 100000000;
			*PPVal = 1;
			*YVal = *YVal + BSStepWin + BSStepSize + 1;
			return(0);
		}
		if (CurPos < 1){
			if (CircularFlag == 1)
				CurPos = numwins - 1;
			else{
				CurPos = 1;
				break;
			}
			
		}
	}
	*curpos = CurPos;
	*probcounter = ProbCounter;
	*totalprob = TotalProb;
	*lastfull = LastFull;
	return(1);
}

int FAR pascal FindEndBS(int Y, double BSCutOff, int BSBootReps,int numwins, int OverlapNum, int MedHomol, int HighHomol, int LowHomol,int gbcc,int *lastfull,int *probcounter, int *curpos, double *totalprob, double *PltVal){
	int CurPos, LastFull, GoOnFlag, Z, ProbCounter, os;
	double TotalProb;

	TotalProb = *totalprob;
	LastFull = *lastfull;
	CurPos = *curpos;
	ProbCounter = *probcounter;
	while (CurPos <= gbcc - 1){
		if (PltVal[MedHomol + CurPos*3] < BSCutOff * BSBootReps){
				GoOnFlag = 0;
				for (Z = 1; Z <= OverlapNum; Z++){
					if (CurPos + Z <= numwins){ 
						os =(CurPos + Z)*3;
						if (PltVal[MedHomol + os] <= PltVal[HighHomol + os] || PltVal[MedHomol + os] <= PltVal[LowHomol + os] || PltVal[MedHomol + os] <= 0.4 * BSBootReps){
							GoOnFlag = 0;
							break;
						}
						else if (PltVal[MedHomol + os] >= BSCutOff * BSBootReps){
							GoOnFlag = 1;
							CurPos++;
							break;
						}
					}
					else
						break;

					ProbCounter++;
					TotalProb = TotalProb + PltVal[MedHomol + (CurPos - 1)*3] / BSBootReps;
				}
				
				if (GoOnFlag == 0){
					if (Y == CurPos && PltVal[MedHomol + Y*3] <= 0.4 * BSBootReps)
						CurPos--;
					break;
				}
		}
		else
			LastFull = CurPos;
	
    
		ProbCounter++;
		TotalProb = TotalProb + PltVal[MedHomol + (CurPos - 1)*3] / BSBootReps;
		CurPos++;
	}
	*curpos = CurPos; 
	*lastfull = LastFull; 
	*probcounter = ProbCounter;
	*totalprob = TotalProb;
	return(1);
}

int FAR pascal FindFormula(int O, int UB, int UB2,double *ssa, double *ss, float *XTable,  double *TTable, double *Ex){
	int X,Y,Z, os1, os2, os3, os4, NumVals;
	double xt, hold, logV, SS, XS, YS, ZS, XT,YT,ZT,XQ,YQ,ZQ,XY,XZ,YZ, SSA;
	os1 = UB+1;
	os3 = UB2+1;
	SS=0.0;
	SSA=0.0;
	NumVals=0;
	for (X = 0; X<=UB;X++){
		XS = (double)(X*X);
		XT = (double)(XS*X);
		XQ = (double)(XT*X);
        for (Y = 0; Y<=UB;Y++){
		   YS = (double)(Y*Y);
		   YT = (double)(YS*Y);
		   YQ = (double)(YT*Y);
		   XY = (double)(X*Y);
           for (Z = 0; Z<=UB;Z++){
			    
			   os2 = X + Y*os1 + Z*os1*os1;
			   os4 = X + Y*os3 + Z*os3*os3;
			   xt = (double)(XTable[os4]);
			   if (xt < 1 && xt > 0){
				    ZS = (double)(Z*Z);
					ZT = (double)(ZS*Z);
					ZQ = (double)(ZT*Z);
					XZ = (double)(Z*X);
					YZ = (double)(Z*Y);
                    TTable[os2] = 0;
                    
					TTable[os2] = TTable[os2] + Ex[6];
					TTable[os2] = TTable[os2] + Ex[4] * (double)(X);
					TTable[os2] = TTable[os2] + Ex[18] * (double) (Z);
                    TTable[os2] = TTable[os2] + Ex[12] * (double)(Y);

					TTable[os2] = TTable[os2] + Ex[10] * YS;
					TTable[os2] = TTable[os2] + Ex[16] * ZS;
					TTable[os2] = TTable[os2] + Ex[2] * XS;
					TTable[os2] = TTable[os2] + Ex[34] * XY;
					TTable[os2] = TTable[os2] + Ex[36] * XZ;
					TTable[os2] = TTable[os2] + Ex[38] * YZ;
					
					if (O > 0){
						
						TTable[os2] = TTable[os2] + Ex[0] * XT;
						TTable[os2] = TTable[os2] + Ex[8] * YT;
						TTable[os2] = TTable[os2] + Ex[14] * ZT;
						TTable[os2] = TTable[os2] + Ex[20] * XS * Y;
						TTable[os2] = TTable[os2] + Ex[22] * XS * Z;
						TTable[os2] = TTable[os2] + Ex[24] * X * YS;
						TTable[os2] = TTable[os2] + Ex[26] * X * ZS; 
						TTable[os2] = TTable[os2] + Ex[28] * ZS * Y; 
						TTable[os2] = TTable[os2] + Ex[30] * Z * YS;
						TTable[os2] = TTable[os2] + Ex[32] * XY * Z;
                    
						if (O > 1){
							TTable[os2] = TTable[os2] + Ex[40] * XQ;
							TTable[os2] = TTable[os2] + Ex[42] * YQ;
							TTable[os2] = TTable[os2] + Ex[44] * ZQ;
							TTable[os2] = TTable[os2] + Ex[46] * XT * Z;
							TTable[os2] = TTable[os2] + Ex[48] * XS * ZS;
							TTable[os2] = TTable[os2] + Ex[50] * X * ZT;
							TTable[os2] = TTable[os2] + Ex[52] * XT * Y;
							TTable[os2] = TTable[os2] + Ex[54] * XS * YS;
							TTable[os2] = TTable[os2] + Ex[56] * X * YT;
							TTable[os2] = TTable[os2] + Ex[58] * YZ * YS;
							TTable[os2] = TTable[os2] + Ex[60] * ZS * YS;
							TTable[os2] = TTable[os2] + Ex[62] * ZT * Y;
							TTable[os2] = TTable[os2] + Ex[64] * ZS * XY;
							TTable[os2] = TTable[os2] + Ex[66] * XS * YZ;
							TTable[os2] = TTable[os2] + Ex[68] * YS * XZ;
						}
					}
					
                    logV = -log(xt);
					hold = logV-TTable[os2];
					hold = hold*hold;
                    SS = SS + hold;
                    
					if (logV > TTable[os2])
						SSA = SSA + (logV - TTable[os2]);
					else
						SSA = SSA + (TTable[os2] - logV);
                    NumVals++;
                
			   }
                
           }
		}
    }
	*ss=SS;
	*ssa=SSA;
	return(NumVals);
}



float FAR pascal Seq3PVals (int uba, int ubb, float nM, float nN, float nK, float *YTable){
	
	float K, dPValue, J;
	

	dPValue = 0;
	
	if (nK == 0 && nN > 0)
		dPValue = 1;
	else if (nK == 0 && nN == 0) 
		dPValue = 1;
    else if (nM == 0 && nK == nN)
        dPValue =  1;
    else if (nM == 0 && nK != nN)
		dPValue =  1;        
    else if (nN == 0 && nK > 0)
        dPValue =  1;  
    else if (nM < 0 || nN < 0 || nK < 0)
        dPValue =  1;  
    else {
		
		for (K = nK; K <= nN; K++){
			if (K <= nN && K >= nN - nM){
					for (J = 0; J <= K; J++)
						dPValue = dPValue + Get3SeqPvalC(uba, ubb, nM, nN, K, J, YTable);
				}

		}
	}
	return(dPValue);
}

float FAR pascal Get3SeqPvalC(int uba, int ubb, float m, float n, float k, float j, float *YTable){
//C version of VB version of Boni's float ytable::prob(int m, int n, int k, int j) in ProbTables.ccp
	int os1;
	float d;

	if (m > uba-1 || n > uba-1)
		return (111);
	if (k > ubb-1 || j > ubb-1)
		return(222);

	
	
	os1 = (int) (m + n*(uba +1) + k*(uba+1)*(ubb+1) + j*(uba+1)*(ubb+1)*(ubb+1));
	
    
    


	 // if it's in the table, just return it
       
    if (YTable[os1] >= 0)
        return(YTable[os1]);


    d = -1;




    if (j > k)
		return(0);
	else if (k > n || k < n - m || j > n || j < n - m)
        return(0);
    else if (n == 0){
    
        if (k == 0 && j == 0)
        
            return(1);
        
        else
            return(0);
        
	}
    else if (m == 0){
        if (k == n && j == n)
            return(1);
        else
            return(0);
	}
	else if (k == 0 && j == 0){
    
        if (n == 0)
        
            return(1);
        else
        
            return(0);
        
    }
    
       
    if (j == 0)
    
        d = (m / (n + m)) * (Get3SeqPvalC(uba,ubb,m - 1, n, k, 1, YTable) + Get3SeqPvalC(uba,ubb,m - 1, n, k, 0,YTable));
        
	else {
        if (k == j)
            d = (n / (n + m)) * (Get3SeqPvalC(uba,ubb,m, n - 1, j - 1, j - 1,YTable) + Get3SeqPvalC(uba,ubb,m, n - 1, j, j - 1,YTable));
        else // k > j Then
            d = (m / (n + m)) * Get3SeqPvalC(uba,ubb,m - 1, n, k, j + 1,YTable) + (n / (n + m)) * Get3SeqPvalC(uba,ubb,m, n - 1, k, j - 1,YTable);
        
    }
    
    YTable[os1] = d;
	
	return(d);
}

int FAR pascal Fill4DSingArray(int  b1,int b2,int b3,int b4,float fillval,float *array){
	int w,x,y,z, os1, os2, os3,os4, os5;
	os1 = b1+1;
	os2 = os1*(b2+1);
	os3 = os2*(b3+1);

	for (w = 0; w <= b1; w++){
		for (x = 0; x <= b2; x++){
			os4 = x*os1;
			for (y = 0; y <= b3; y++){
				os5 = y*os2 + w + os4;
				for (z = 0; z <= b4; z++){
					array[os5 + z*os3] = -1.0;
				}	
			}	
		}	
	}
	return(1);

}
int FAR pascal FindSubSeqTS(int LS, int Seq1, int Seq2, int Seq3, int *be, int *en, int *be2, int *en2, int *nm, int *nn, int *nk, int *nl, int *XPosdiff, int *XDiffpos, short int *SeqNum, int *XOverSeqNum){
	int BE, EN,BE2, EN2, X,Y,CurrentHeight,MaxDescentSeen,MaxAscentSeen, nM, nN, MaxSeen, MinSeen, os3,os1,os2, s1,s2,s3; 
	CurrentHeight = 0;
    MaxDescentSeen = 0;
	MaxAscentSeen = 0;
    Y = 0;
    nM = 0;
    nN = 0;
    MaxSeen = 0;
	MinSeen = 0;
	os1 = (LS+1)*Seq1;
	os2 = (LS+1)*Seq2;
	os3 = (LS+1)*Seq3;
	BE=0;
	EN=0;
	BE2=0;
	EN2=0;
	X=0;
    

    for (X = 0; X <= LS; X++){
		s1 = SeqNum[X+os1];
		s2 = SeqNum[X+os2];
		if (s2 != s1){	
			if (s1 != 46){
			
				if (s2 != 46){
					s3 = SeqNum[X+os3];
					if (s3 != 46){
                    
                        if (s3 == s1){
                            CurrentHeight++;

                            XOverSeqNum[Y] = CurrentHeight;

                            XDiffpos[Y] = X;
                            XPosdiff[X] = Y;
                            if (CurrentHeight > MaxSeen){
                                MaxSeen = CurrentHeight;
                                BE = X;
							}
							if (CurrentHeight-MinSeen > MaxAscentSeen){
								MaxAscentSeen = CurrentHeight-MinSeen;
								EN2 = X;
							}
                            nM++;

                            Y++;
							
						}
                        else if (s3 == s2){
							
                            CurrentHeight--;

                            XOverSeqNum[Y] = CurrentHeight;

                            XDiffpos[Y] = X;
                            XPosdiff[X] = Y;
                            nN ++;
							if (MaxSeen - CurrentHeight > MaxDescentSeen){
								MaxDescentSeen = MaxSeen - CurrentHeight;
								EN = X;
							}
                            if (CurrentHeight < MinSeen){
                                MinSeen = CurrentHeight;
                                BE2 = X;
							}

                            Y++;
						
						}
						
                    }
                }
			}
		}
    
    }
    
    *nk = MaxDescentSeen;
	*nl = MaxAscentSeen;
	*en = EN;
	*be = BE;
	*en2 = EN2;
	*be2 = BE2;
	*nn = nN;
	*nm = nM;


	return( Y - 1);
}

int FAR pascal FindSubSeqTS2(int LS, int Seq1, int Seq2, int Seq3, int *be, int *en, int *be2, int *en2, int *nm, int *nn, int *nk, int *nl, int *XPosdiff, int *XDiffpos, short int *SeqNum, int *XOverSeqNum, unsigned char *MissingData){
	int BE, EN,BE2, EN2, X,Y,CurrentHeight,MaxDescentSeen,MaxAscentSeen, nM, nN, MaxSeen, MinSeen, os3,os1,os2, s1,s2,s3; 
	CurrentHeight = 0;
    MaxDescentSeen = 0;
	MaxAscentSeen = 0;
    Y = 0;
    nM = 0;
    nN = 0;
    MaxSeen = 0;
	MinSeen = 0;
	os1 = (LS+1)*Seq1;
	os2 = (LS+1)*Seq2;
	os3 = (LS+1)*Seq3;
	BE=0;
	EN=0;
	BE2=0;
	EN2=0;
    for (X = 0; X <= LS; X++){
		/*if (missingdata[X+os1] == 1 || missingdata[X+os2] == 1 ||  missingdata[X+os3] == 1){
			
			MaxSeen = 0;
			MinSeen = 0;
		}*/
		XPosdiff[X] = Y;
		s1 = SeqNum[X+os1];
		s2 = SeqNum[X+os2];
        if (s2 != s1){
			if (s1 != 46){
				
				if (s2 != 46){
					s3 = SeqNum[X+os3];
					if (s3 != 46){
                    
                        if (s3 == s1){
                            CurrentHeight++;
                            XOverSeqNum[Y] = CurrentHeight;
                            XDiffpos[Y] = X;
                            
                            if (CurrentHeight > MaxSeen){
                                MaxSeen = CurrentHeight;
                                BE = X;
							}
							if (CurrentHeight-MinSeen > MaxAscentSeen){
								MaxAscentSeen = CurrentHeight-MinSeen;
								EN2 = X;
							}
                            nM++;
                            Y++;
							XPosdiff[X] = Y;
						}
                        else if (s3 == s2){
                            CurrentHeight--;
                            XOverSeqNum[Y] = CurrentHeight;
                            XDiffpos[Y] = X;
                            
                            nN ++;
							if (MaxSeen - CurrentHeight > MaxDescentSeen){
								MaxDescentSeen = MaxSeen - CurrentHeight;
								EN = X;
							}
                            if (CurrentHeight < MinSeen){
                                MinSeen = CurrentHeight;
                                BE2 = X;
							}
                            Y++;
							XPosdiff[X] = Y;
						}
                    }
                }
			}
		}
    
    }
    
    *nk = MaxDescentSeen;
	*nl = MaxAscentSeen;
	*en = EN;
	*be = BE;
	*en2 = EN2;
	*be2 = BE2;
	*nn = nN;
	*nm = nM;


	return( Y - 1);
}

int FAR pascal CheckwrapC(int LS, int LenXOverSeq, int NegMod, int CircularFlag, int *nk, int *be, int *en, int *XDiffPos, int *XPosDiff, int *XoverSeqNumTS){
	int h1,  MaxSeen, tempAscent, X, nK, BE, EN, TE, TBE;
	
	BE = *be;
	EN = *en;
	nK = *nk;
	if (BE == 0) 
		BE = XDiffPos[0];
    
    
    
    //need to carry on and check to see if mindescent gets lower with wrapping
   MaxSeen = XoverSeqNumTS[XPosDiff[BE]] * NegMod;
   tempAscent = XoverSeqNumTS[LenXOverSeq] * NegMod;
   
   if (BE < EN){
	   TBE = XPosDiff[BE];
	   for (X = 0; X <= TBE; X++){
           h1  = tempAscent + (XoverSeqNumTS[X] * NegMod);
		   if (h1 > MaxSeen){
                MaxSeen = h1;
                BE = XDiffPos[X];
				
		   }
		   if (MaxSeen - h1 > nK){
                nK = MaxSeen - h1;
                EN = XDiffPos[X];
		   }
	   }
   }
         
   else{
	   TBE = XPosDiff[EN];
       for (X = 0; X <= TBE; X++){
             
           h1  = tempAscent + (XoverSeqNumTS[X] * NegMod);
		   if (h1 > MaxSeen){
                MaxSeen = h1;
                BE = XDiffPos[X];
				
		   }
		   if (MaxSeen - h1 > nK){
                nK = MaxSeen - h1;
                EN = XDiffPos[X];
		   }
             
	   }
   }
    
        
   if (XPosDiff[BE] < LenXOverSeq)
        BE = XDiffPos[XPosDiff[BE] + 1];
   else
        BE = XDiffPos[0];     
    
   
   if (CircularFlag == 0){
       
	   if (BE > EN){
            if (XPosDiff[EN] < LenXOverSeq)
                TE = XDiffPos[XPosDiff[EN] + 1];
            else
                TE = 1;
            
            if (XPosDiff[BE] > 0)
                EN = XDiffPos[XPosDiff[BE] - 1];
            else
                EN = LS;
            
            BE = TE;
	   }
    
   }
	*be = BE;
	*en = EN;
	*nk = nK;
	return(1);
}

int FAR pascal GetPltVal2(short int bootreps, int start, int end, short int *t0, short int *t1, short int *t2, double *pltval)
{
	
	int x,y,os, os2, v0, v1, v2, o1;

	short int p1,p2,p3;
	
	for (y=start; y <=end; y++){
		p1 = 0,p2 = 0,p3 = 0;
		os = y*bootreps;
		for (x = 0; x < bootreps; x++){
			os2 = x+os;
			v0 = t0[os2]; 
			v1 = t1[os2];
			v2 = t2[os2];
			//if (t0[x+os] != 32000 && t1[x+os] != 32000 && t2[x+os] != 32000){
			
			/*if (v0 < v1 && v0 < v2)
				p1++;
			else if (v1 < v0 && v1 < v2)
				p2++;
			else if (v2 < v0 && v2 < v1)
				p3++;*/

			if (v0 < v1){
				if (v0 < v2)
				   p1++;
				else if (v2 < v0)
					p3++;
			}
			else if (v1 < v0){
				if (v1 < v2)
					p2++;
				else if (v2 < v1)
					p3++;
			}
			else if (v2 < v0) //v0 and v1 must be equil
					p3++;

			
		
		//	}
		}
		o1 = y*3;
		//return 1;
		pltval[o1] = p1;
		pltval[o1 + 1] = p2;
		pltval[o1 + 2] = p3;
	}
	return 1;
}

//ByVal B As Long, ByVal BSBootReps As Long, ByRef DstMat As Double, ByRef PltVal As Double
int FAR pascal GetPltValX (int B, int BSCBootReps, float *DstMat, double *PltVal){
	//dstmat - bsbootreps,2,2
	//pltval - 2,winnum
	int X, off0,off1,off2,o0,o1,o2;
	off0 = (BSCBootReps+1)*3;
	off1 = (BSCBootReps+1)*6;
	off2 = (BSCBootReps+1) + (BSCBootReps+1)*6;
	o0 = B*3;
	o1 = 1+o0;
	o2 = 2+o0;
	for (X = 0; X < BSCBootReps; X++){
		if (DstMat[X + off0] < 2){ 
			if (DstMat[X + off1] < 2){ 
				if (DstMat[X + off2] < 2){
					if (DstMat[X + off0] < DstMat[X + off1] && DstMat[X + off0] < DstMat[X + off2])
						PltVal[o0] = PltVal[o0] + 1;
					else if (DstMat[X + off1] < DstMat[X + off0] && DstMat[X + off1] < DstMat[X + off2])
						PltVal[o1] = PltVal[o1] + 1;
					else if (DstMat[X + off2] < DstMat[X + off0] && DstMat[X + off2] < DstMat[X + off1])
						PltVal[o2] = PltVal[o2] + 1;
				}
			}
		}
	}
	return(1);
}

double FAR pascal DNADIST(double cvi, double ttratio, short int tbff,short int tmodel, double tafreq, double tcfreq,double tgfreq,double ttfreq, int numsp, int sites, short int *seqnum,int *alias, int *ally, int *weight, int *location, short int *px,short int *xx1, short int *xx2, double *prod, double *prod2, double *prod3, float *dmat)
{
  
  double fracchange,freqr, freqy,freqa, freqc, freqg, freqt, 
	  freqar, freqgr, freqcy, freqty,xv,xi,w, suma, sumc, sumg,
	  sumt, rate,numerator,epsilon, ratxv, sum, sum1, sum2, sumyr, 
	  lz, aa, bb, cc, vv, p1, p2, p3, q1, q2, q3,
	  tt, delta, slope, xx1freqa, xx1freqc, xx1freqg, xx1freqt,
	  y1, z1, rat,  z1xv, z1yy ,z1zz , th1 , th2, th3, th4;
  int endsite, gap, i, j, jj, jg, k, itemp, num1, num2, m, n, 
	  it, idx,denominator;
  short int  b, quick,  kimquick, jinneiquick, 
	  iterations,done, flip, tied, h1, h2,found, completed;
  epsilon = 0.00001;

	 denominator=0;
	 numerator=0.0;

  for(i=1;i<=sites;i++){
	  alias[i-1]=i;
	  ally[i-1] = i;
	  weight[i-1]=0;
  }
	
  /* Shell sort of sites lexicographically - ie alphabetically */
  gap = sites / 2;
  while (gap > 0) {
    for (i = gap + 1; i <= sites; i++) {
      j = i - gap;
      flip = 1;
      while (j > 0 && flip == 1) {
        jj = *(alias + j - 1);
        jg = *(alias + j + gap - 1);
        tied = 1;
        k = 1;
        while (k <= numsp && tied == 1) {
          h1 = *(seqnum + jj + (k - 1)*(sites + 1));
		  h2 = *(seqnum + jg + (k - 1)*(sites + 1));
		  if (h1 > h2 )//(y[k - 1][jj - 1] > y[k - 1][jg - 1]);
              flip = 1;
		  else
			  flip = 0;
		  if (tied == 1 && h1 == h2)
              tied = 1;
		   else
			   tied = 0;
		  k++;
        }
        if (flip == 0)
          break;
        itemp = *(alias + j - 1);
        *(alias + j - 1) = *(alias + j + gap - 1);
        *(alias + j + gap - 1) = itemp;
        j -= gap;
      }
    }
    gap /= 2;
  }
  //return 1;
 // void sitecombine()

  /* combine sites that have identical patterns */

  i = 1;
  while (i < sites) {
    j = i + 1;
    tied = 1;
    while (j <= sites && tied == 1) {
      tied = 1;
      k = 1;
      while (k <= numsp && tied == 1) {
        h1 = *(seqnum + alias[i - 1] + (k - 1)*(sites + 1));
		h2 = *(seqnum + alias[j - 1] + (k - 1)*(sites + 1));
		if (tied == 1 && h1 == h2)
			tied = 1;
		else
			tied = 0;
		k++;
      }
      if (tied == 0)
        break;
      ally[alias[j - 1] - 1] = alias[i - 1];
      j++;
    }
    i = j;
  }

//void sitescrunch()

  /* move so one representative of each pattern of
     sites comes first */
  

  done = 0;
  i = 1;
  j = 2;
  while (done == 0) {
    if (ally[alias[i - 1] - 1] != alias[i - 1]) {
      if (j <= i)
        j = i + 1;
      if (j <= sites) {
        found = 0;
        do {
          if (ally[alias[j - 1] - 1] == alias[j - 1])
			  found = 1;
		  else
			  found = 0;
          j++;
          if (j > sites)
			  completed = 1;
		  else
			  completed = 0;
        } while (found == 0 && completed == 0);
        if (found == 1) {
          j--;
          itemp = alias[i - 1];
          alias[i - 1] = alias[j - 1];
          alias[j - 1] = itemp;
        } else
          done = 1;
      } else
        done = 1;
    }
    i++;
    if(done == 1 || i >= sites)
		done = 1;
	else
		done = 0;
  }

//void makeweights()

  /* make up weights vector to avoid duplicate computations */
  rate=1;
  endsite = 0;
  for (i = 1; i <= sites; i++) {
    if (ally[i - 1] == i)
      endsite++;
  }
  for (i = 1; i <= endsite; i++)
    location[alias[i - 1] - 1] = i;
  //sumrates = sites;
  for (i = 0; i < sites; i++)
    weight[location[ally[i] - 1] - 1] += 1;
  
  for (k = 0; k < endsite; k++){
    j = alias[k];
    for (i = 0; i < numsp; i++){
            if (*(seqnum + j + i*(sites + 1)) == 66) 
                *(px + k*numsp + i) = 0;
            else if (*(seqnum + j + i*(sites + 1)) == 68)
                *(px + k*numsp + i) = 1;
            else if (*(seqnum + j + i*(sites + 1)) == 72)
                *(px + k*numsp + i) = 2;
            else if (*(seqnum + j + i*(sites + 1)) == 85)
                *(px + k*numsp + i) = 3;
            else if (*(seqnum + j + i*(sites + 1)) == 46)
                *(px + k*numsp + i) = 4;
    }
  }

	freqa = 0.25;
	freqc = 0.25;
	freqg = 0.25;
	freqt = 0.25;
	if (tbff == 0 && tmodel == 3) {
		for (k = 1; k <= 8; k++){
			suma = 0.0;
			sumc = 0.0;
			sumg = 0.0;
			sumt = 0.0;
			for (i = 0; i < numsp; i++){
				for (j = 0; j < endsite;j++){
					w = weight[j];
					if (*(px + j*numsp + i) == 0) {
						xx1[0] = 1;
						xx1[1] = 0;
						xx1[2] = 0;
						xx1[3] = 0;
					}
					else if (*(px + j*numsp + i) == 1) {
						xx1[0] = 0;
						xx1[1] = 1;
						xx1[2] = 0;
						xx1[3] = 0;
					}
					else if (*(px + j*numsp + i) == 2) {
						xx1[0] = 0;
						xx1[1] = 0;
						xx1[2] = 1;
						xx1[3] = 0;
					}
					else if (*(px + j*numsp + i) == 3) {
						xx1[0] = 0;
						xx1[1] = 0;
						xx1[2] = 0;
						xx1[3] = 1;
					}
					else if (*(px + j*numsp + i) == 4) {
						xx1[0] = 1;
						xx1[1] = 1;
						xx1[2] = 1;
						xx1[3] = 1;
					}
					sum = freqa * xx1[0];
					sum = sum + freqc * xx1[1];
					sum = sum + freqg * xx1[2];
					sum = sum + freqt * xx1[3];
					suma = suma + w * freqa * xx1[0] / sum;
					sumc = sumc + w * freqc * xx1[1] / sum;
					sumg = sumg + w * freqg * xx1[2] / sum;
					sumt = sumt + w * freqt * xx1[3] / sum;
				}
			}
			sum = suma + sumc + sumg + sumt;
			freqa = suma / sum;
			freqc = sumc / sum;
			freqg = sumg / sum;
			freqt = sumt / sum;
		}
	}
	else {
		if (tbff == 1 && tmodel == 3){
			freqa = tafreq;
			freqc = tcfreq;
			freqg = tgfreq;
			freqt = ttfreq;
		}
	}

	/* compute or read in base frequencies */
	

	freqr = freqa + freqg;
	freqy = freqc + freqt;
	freqar = freqa / freqr;
	freqcy = freqc / freqy;
	freqgr = freqg / freqr;
	freqty = freqt / freqy;
	aa = ttratio * freqr * freqy - freqa * freqg - freqc * freqt;
	bb = freqa * freqgr + freqc * freqty;
	xi = aa / (aa + bb);
	xv = 1.0 - xi;
	ttratio = xi / xv;
	if(xi <= 0.0 && xi >= -epsilon)
		xi = 0.0;
	if (xi < 0.0){
		xi = 3.0 / 5;
		xv = 2.0 / 5;
	}
	fracchange = xi * (2 * freqa * freqgr + 2 * freqc * freqty) + xv * (1.0 - freqa * freqa - freqc * freqc - freqg * freqg - freqt * freqt);
	
  //makev
  iterations = 1000;
  ratxv = xv;
  rat = 1.0;
  /*To do bootstrap replicates I must fiddle with the weights here.
  It'll mean changing the weight values to reflect different datasets 
  - I may have to recalculate a series of weights from actual 
  bootstrapped sequences but I'd prefer to think of a way to simply 
  manipulate the weights directly.  Here is my idea: 
  If bootstrap replicates are to be used I save the weight 
  array and generate  BSnum weight arrays from it by selecting 'sites'
  number of bsweights from the original weights array.  
  The steps are as follows:
  1) Get sites number of rnd numbers between 0 and sites-1
  2) for each rnd number, say i, find the ith weight from the 
  end  (its quicker this way because the greater 
  weight values are at the end). - there are many reasonably quick
  ways to do this. Add 1 to the corresponding weigth position in the
  bootstrap weigth array 
  3) For each position from 0 to endsite calculate all bootstrap dists
  at the same time - ie this will mean making a numerator and
  denominator arrays the same size as the number of bootstrap replicates
  4) write the values to a 3D array bsrep-seq1-seq2*/
  
  for (m=1; m <= numsp - 1;m++){
	  for(n=m+1; n <= numsp; n++){
		  quick = 1;
		  vv=0;
		  if (tmodel == 0 || tmodel == 4) {
			numerator = 0;
			denominator = 0;
			for (i = 0; i < endsite; i++) {
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) =0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) = 1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  sum = 0.0;
			  sum1 = 0.0;
			  sum2 = 0.0;
			 for (b = 0; b <= 3; b++) {
				sum1 += *(xx1 + b);
				sum2 += *(xx2 + b);
				sum += *(xx1 + b) * *(xx2 + b);
			  }
			  if (quick == 1 && (sum1 == 1.0 || sum1 == 4.0) && (sum2 == 1.0 || sum2 == 4.0))
				  quick == 1;
			  else
				  quick == 0;
			  if (sum1 == 1.0 && sum2 == 1.0) {
				numerator += (*(weight + i) * sum);
				denominator += *(weight + i);
			  }
			}
		  }
  
		  

		  if (tmodel == 1 && quick == 1)
			  kimquick = 1;
		  else
			  kimquick = 0;

		  if (tmodel == 2 && quick == 1)
			  jinneiquick = 1;
		  else
			  jinneiquick = 0;
  
		  //vv = numerator / denominator;
		  //vv = -0.75 * log((4.0 * (numerator / denominator) - 1.0) / 3.0);
		  //return vv;
		  if (tmodel == 0){
			  if (denominator == 0 || numerator == 0)
						  vv = 10.0;
			  else{
				  if (numerator / denominator > 0.25){
					  th1 = (numerator / denominator);
					  th2 = (4.0 * th1 - 1.0) / 3.0;
					  th3 = log(th2);
					  vv = -0.75 * th3;
				  }
				  else
					  //if (vv > 10.0)
					  vv = 10.0;
			  }
		  }

		  else if (tmodel == 4){
			  if (denominator == 0 || numerator == 0)
						  vv = 1.0;
			  else
					  vv = 1 - (numerator / denominator);
			  
		  }
		  else if (kimquick == 1 || jinneiquick == 1) {
			num1 = 0;
			num2 = 0;
			denominator = 0;
			for (i = 0; i < endsite; i++) {
			  //memcpy(xx1, p->x[i], sizeof(sitelike));
			  //memcpy(xx2, q->x[i], sizeof(sitelike));
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) =0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) = 1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  sum = 0.0;
			  sum1 = 0.0;
			  sum2 = 0.0;
			  for (b = 0; b <= 3; b++) {
				sum1 += *(xx1 + b);
				sum2 += *(xx2 + b);
				sum += *(xx1 + b) * *(xx2 + b);
			  }
			  sumyr = (xx1[0] + xx1[2])
					* (xx2[0] + xx2[2]) +
					  (xx1[1] + xx1[3]) *
					  (xx2[1] + xx2[3]);


			  if (sum1 == 1.0 && sum2 == 1.0) {
				num1 += (int)(*(weight + i) * sum);
				num2 += (int)(*(weight + i) * (sumyr - sum));
				denominator += *(weight + i);
			  }
			}
			if (num1 == 0 || denominator == 0)
				vv =10;
			else{
				tt = 1.0 - num1 / denominator;
			//return tt;
				if (tt > 0.0) {
				  delta = 0.1;
				  tt = delta;
				  it = 0;
				  while (fabs(delta) > 0.00002 && it < iterations) {
				it++;
				if (tmodel == 1) {
				  p1 = exp(-tt);
					  p2 = exp(-xv * tt) - exp(-tt);
					  p3 = 1.0 - exp(-xv * tt);
				} else {
				  p1 = exp(-cvi * log(1 + tt / cvi));
				  p2 = exp(-cvi * log(1 + xv * tt / cvi))
						  - exp(-cvi * log(1 + tt / cvi));
				  p3 = 1.0 - exp(-cvi * log(1 + xv * tt / cvi));
				}
				q1 = p1 + p2 / 2.0 + p3 / 4.0;
				q2 = p2 / 2.0 + p3 / 4.0;
				q3 = p3 / 2.0;

				if (tmodel == 1){
					th1 = 0.5 * exp(-tt) * (num2 / q2 - num1 / q1);
					th2 = 0.25 * xv * exp(-xv * tt);
					th3 = ((denominator - num1 - num2) * 2.0 / q3 - num2 / q2 - num1 / q1);
					th4 = th2*th3;
				}
				else{
					th1 = 0.5 * (1 / (1 + tt / cvi)) * exp(-cvi * log(1 + tt / cvi)) * (num2 / q2 - num1 / q1);
					th2 = 0.25 * (xv / (1 + xv * tt / cvi)) * exp(-cvi * log(1 + xv * tt / cvi));
					th3 = ((denominator - num1 - num2) * 2 / q3 - num2 / q2 - num1 / q1);
					th4 = th2*th3;
				}
				slope  =  th1 + th4;
					//return slope;
				if (slope < 0.0)
				  delta = fabs(delta) / -2.0;
				else
				  delta = fabs(delta);
				tt += delta;
				  }
				}
				vv = fracchange * tt;

			  }
			}
		  if (tmodel == 3) {
			for (i = 0; i < endsite; i++) {
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) = 0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) =1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  xx1freqa = xx1[0] * freqa;
			  xx1freqc = xx1[1] * freqc;
			  xx1freqg = xx1[2] * freqg;
			  xx1freqt = xx1[3] * freqt;
			  sum1 = xx1freqa + xx1freqc + xx1freqg + xx1freqt;
			  sum2 = freqa * xx2[0] + freqc * xx2[1] +
					 freqg * xx2[2] + freqt * xx2[3];
			  prod[i] = sum1 * sum2;
			  prod2[i] = (xx1freqa + xx1freqg) *
						 (xx2[0] * freqar + xx2[2] * freqgr) +
				  (xx1freqc + xx1freqt) *
				  (xx2[1] * freqcy + xx2[3] * freqty);
			  prod3[i] = xx1freqa * xx2[0] + xx1freqc * xx2[1] +
				 xx1freqg * xx2[2] + xx1freqt * xx2[3];
			}
			tt = 0.1;
			delta = 0.1;
			it = 1;
			while (it < iterations && fabs(delta) > 0.00002) {
			  slope = 0.0;
			  if (tt > 0.0) {
			  lz = -tt;
			  z1 = exp(ratxv * lz);
			  y1 = 1.0 - z1;
			  z1zz = exp(rat * lz);
			  z1yy = z1 - z1zz;
			  z1xv = z1 * xv;
        
				for (i = 0; i < endsite; i++) {
				  idx = 1;
				  cc = prod[i];
				  bb = prod2[i];
				  aa = prod3[i];
			  slope += weight[i] * (z1zz * (bb - aa) +
				z1xv * (cc - bb)) /
				  (aa * z1zz + bb * z1yy + cc * y1);
				}
			  }
			  if (slope < 0.0)
			delta = fabs(delta) / -2.0;
			  else
			delta = fabs(delta);
			  tt += delta;
			  it++;
			}
			vv = tt * fracchange;
			for (i = 0; i <endsite; i++){ 
			   prod[i] = 0;
			   prod2[i] = 0;
			   prod3[i] = 0;
			}
		  }
		*(dmat + m-1 + (n-1)*numsp) = (float)(vv);
		*(dmat + n-1 + (m-1)*numsp ) = (float)(vv);
	}
  }
  return(1);
}  /* sitesort */

int FAR pascal StripDupInv(int Nextno, float *RCorr, double *RLScore, int *InPen, int *RNum, int *Rlist, int *InvList ){
	int X, Y, Z, Count, WinRL, s1, s2, WinPP;
	double MScore;
	MScore = 0.0;
	//rlscore 2,nextno
	//rcorr 2,2,nextno
	
	//strip duplicates
	if (MScore == 10.0){
		for (X = 0; X <= Nextno; X++){
			Count = 0;
			MScore = 0.0;
			for (Y = 0; Y < 3; Y++){
				if (RLScore[Y + X*3] > 0){
					Count++;
					if (RLScore[Y+ X*3] > MScore){
						MScore = RLScore[Y + X*3];
						WinRL = Y;
					}
				}
			}
			if (Count > 1){
				for (Y = 0; Y < 3; Y++){
					if (Y != WinRL){
						s2 = Rlist[Y + RNum[Y]*3]*9;
						for (Z = 0; Z <= RNum[Y]; Z++){
							s1 = Rlist[Y + Z*3];
							if (s1 == X){
								if (RCorr[Y + s1*9] < 0.83 || RCorr[Y + 3 + s1*9] < 0.83 || RCorr[Y + 6 + s1*9] < 0.83){ 
									if (Z < RNum[Y]){
										
										//RCorr[Y + s1*9] = RCorr[Y + s2];
										//RCorr[Y + 3 + s1*9] = RCorr[Y + 3 + s2];
										//RCorr[Y + 6 + s1*9] = RCorr[Y + 6 + s2];
										Rlist[Y + Z*3] = Rlist[Y + RNum[Y]*3];
										InvList[Y + Z*3] = InvList[Y + RNum[Y]*3];
										RLScore[Y + X*3] = 0.0;
									}
									RNum[Y] = RNum[Y] - 1;
									break;
								}
							}
						}
					}
				}
			}
		}
	}
    
    for (X = 0; X < 3; X++){
        for (Y = 0; Y <= RNum[X]; Y++){
            if (InvList[X + Y*3] > 0){
                InPen[X] = 1;
                break;
			}
		}
	}
    
    
    //strip inversions from rlist
    for (WinPP = 0; WinPP < 3; WinPP++){
        Z = 0;        
		while( Z <= RNum[WinPP]){
            if (InvList[WinPP + Z*3] == 1){
                if (Z < RNum[WinPP]){
                    s1 = Rlist[WinPP + Z*3]*9;
					s2 = Rlist[WinPP + RNum[WinPP]*3]*9;
                    //RCorr[WinPP + s1] = RCorr[WinPP + s2];
                    //RCorr[WinPP + 3 + s1] = RCorr[WinPP + 3 + s2];
                    //RCorr[WinPP + 6 + s1] = RCorr[WinPP + 6 + s2];
                    Rlist[WinPP + Z*3] = Rlist[WinPP + RNum[WinPP]*3];
                    InvList[WinPP + Z*3] = InvList[WinPP + RNum[WinPP]*3];
                    
                }
                        
                RNum[WinPP] = RNum[WinPP] - 1;
			}
            else
                Z++;
        }
    }
	return(1);

}

int FAR pascal TestRList(int WinPP, int *AA, int *ZZ, int *FoundOne, int *RNum, int *SQ, int *Rlist){
	int A, Z, GoOn = 0;
	A=0;
	for (Z = 0; Z < 3; Z++){
		if (FoundOne[Z] == 0){
			for (A = 0; A <= RNum[WinPP]; A++){
				if (SQ[Z] == Rlist[WinPP + A*3]){
					GoOn = 1;
                    break;
				}
			}
			if (GoOn == 1)
				break;
		}
	}
	*AA = A;
	*ZZ = Z;
	return(GoOn);
}

int FAR pascal MakeTMatch2(int tWinPP, int WinPP, int *TMatchX, int *SQ, double *tMatch, int *RNum, int *Rlist, int *CompMat){
	//compmat 2,1
	//tmatchx 1,1
	int A, Z, B, hMatch, s1, s2;

	for (A = 0; A < 2; A++){
		//How well do the parents overlap?
		s1 = CompMat[WinPP + A*3];
		for (Z = 0; Z < 2; Z++){
			s2 = SQ[CompMat[tWinPP + Z*3]];
			for (B = 0; B <= RNum[s1]; B++){
				if (Rlist[s1 + B*3] == s2)
					TMatchX[A + Z*2] = 1;
			}
		}
	}
                                
    hMatch = 0;
                                
	for (A = 0; A < 2; A++){
		if (TMatchX[A] + TMatchX[A + 2] > 0){
			if (TMatchX[A*2] + TMatchX[1 + A*2] > 0)
				hMatch++;
		}
	}
    tMatch[0] = hMatch + 1;
	return(1);
}

double FAR pascal MakeEventSeqs (int da, int mip, int map, int EN,int lseq, short int *EventSeq, short int *SeqNum){
	//eventseq 3,lenseq,1
	int X, o1,o2,o3,o4,o5;
	o2 = (lseq+1)*EN*4;
	o3 = (lseq+1)*da;
	o4 = (lseq+1)*mip;
	o5 = (lseq+1)*map;
	for(X = 1; X <= lseq; X++){
		o1 = X*4 + o2;
		EventSeq[o1] = SeqNum[X + o3];
		EventSeq[1+o1] = SeqNum[X + o4];
		EventSeq[2+o1] = SeqNum[X + o5];
	}
	return(1);
}

int FAR pascal CopySeqs (int LS, int Nextno, short int *SeqNum, short int *PermSeqNum){
	int X,  target;//Y, off1,
	target = LS+Nextno*(LS+1);
	for (X = 0; X <= target; X++)
		PermSeqNum[X] = SeqNum[X];
	
	//for (X = 0; X <= Nextno; X++){
	//	off1 = X*(LS+1);
	//	for (Y = 0; Y <= LS; Y++) 
	//		PermSeqNum[Y + off1] = SeqNum[Y + off1];
	//}
	return(1);
}


int FAR pascal CopyLongArray (int D1, int D2,int LS, int Nextno, int LS2, int Nextno2,int *SeqNum, int *PermSeqNum){
	int X, Y, off1, off2;
	
	for (X = 0; X <= D2; X++){
		off1 = X*(LS+1);
		off2 = X*(LS2+1);
		for (Y = 0; Y <= D1; Y++) 
			PermSeqNum[Y + off2] = SeqNum[Y + off1];
	}
	return(1);
}



int FAR pascal CopyDoubleArray (int D1, int D2, int LS, int Nextno, int LS2, int Nextno2, double *SeqNum, double *PermSeqNum){
	int X, Y, off1, off2;
	
	for (X = 0; X <= D2; X++){
		off1 = X*(LS+1);
		off2 = X*(LS2+1);
		for (Y = 0; Y <= D1; Y++) 
			PermSeqNum[Y + off2] = SeqNum[Y + off1];
	}
	return(1);
}


int FAR pascal DoAABlocks(int xRes, int yRes, int UBPC, int UBIX, int UBID22, int UBID23, int UBID12, int UBID13, int *PCount, int *ImageX, unsigned char *ImageData, unsigned char *ImageData2){
	int X, Y, Z, A, B, off1, off2, off3, off4, off6, off5, off7, off8, off9;
	float XRes, YRes;
	XRes=(float)(xRes);
	YRes=(float)(yRes);
	off1 = UBPC+1;
	off2 = 3*(UBIX+1);
	off3 = 4*(UBID22+1);
	off4 = 4*(UBID12+1);
	for (X = 0; X <= UBID22; X++){
		
		//x = (float)(X);
		A = (int)(X / XRes);
		off5 = A*3;
		off6 = X*4;
		for (Y = 0; Y <= UBID23; Y++){
			//y = (float)(Y);
			B = (int)(Y / YRes);
			//if (Y==50)
			//return(B);
			off9 =  B*off1;
			PCount[A + off9] = PCount[A + off9] + 1;
			off7 = B*off2 + off5;
			off8 = off6 + Y*off3;
			for (Z = 0; Z <= 2; Z++)
				ImageX[Z + off7] = ImageX[Z + off7] + (int)(ImageData2[Z + off8]);
			
		}
	}

	
	for (X = 0; X <= UBID12; X++){
		off6 = X*3;
		off8 = X*4;
		for (Y = 0; Y <= UBID13; Y++){
			off5 = X + Y*off1;
			off7= off6 + Y*off2;
			off9= off8 + Y*off4;
			for (Z = 0; Z <= 2; Z++)
				ImageData[Z + off9] = (unsigned char)(ImageX[Z + off7] / PCount[off5]);
			
		}
	}
	return(1);
}


int FAR pascal AddFPX(int UBFP1, int StepDir, int IY, int X1, int X2, float TopS, float BotS, float *FakePicture){
	int X, off1, off2, off3, x1, x2;
	off1 = UBFP1+1;
	off2 = off1*IY;
	off3 = off1*(IY+1);
	if (X1 < X2){
		x1=X1;
		x2=X2;
	}
	else{
		x1=X2;
		x2=X1;
	}

	for (X = x1; X <= x2; X++){
        FakePicture[X + off2] = FakePicture[X + off2] + TopS;
        FakePicture[X + off3] = FakePicture[X + off3] + BotS;
    }

	return(1);
}

int FAR pascal AddFPY(int UBFP1, int StepDir, int IX, int Y1, int Y2, float TopS, float BotS, float *FakePicture){
	int Y, off1, y1, y2;
	off1 = UBFP1+1;
	if (Y1 < Y2){
		y1=Y1;
		y2=Y2;
	}
	else{
		y1=Y2;
		y2=Y1;
	}
	for (Y = y1; Y <= y2; Y++){
        FakePicture[IX + Y*off1] = FakePicture[IX + Y*off1] + TopS;
        FakePicture[IX + 1 + Y*off1] = FakePicture[IX + 1 + Y*off1] + BotS;
	}

	return(1);
}


int FAR pascal FillObject(int UBFP1, int UBFP2, float *FakePicture, float *FakePicture2, float *FakePicture3){
	int X, Y, Z, A, C, off1, off2;
	off1 = UBFP1+1;
	for (Y = 0; Y <= UBFP2; Y++){
		off2 = Y*off1;
		X = 0;
		while (X <= UBFP1){
			
			if (FakePicture3[X + off2] == 1){
				Z = X + 1;
				while (Z < UBFP1){
					if (FakePicture3[Z + off2] == 0)
						break;
					Z = Z + 1;
				}
				if (Z < UBFP1 && Z >= X + 1){
					
					A = Z;
					Z = A + 1;
					while (Z < UBFP1){
						if (FakePicture3[Z + off2] > 0){
							Z = Z - 1;
							break;
						}
						Z = Z + 1;
						
					}
					if (Z < UBFP1 && Z >= A){
						for (C = A; C<= Z; C++)
							FakePicture2[C + off2] = 1;
						
					}
				}
				X = Z;
			}
			
			X = X + 1;
			//If X > UBFP1 Then Exit Do
		}
	}



	for (X = 0; X <= UBFP1; X++){
		Y = 0;
		
		while (Y <= UBFP2){
			
			if (FakePicture3[X + Y*off1] > 0){
				Z = Y + 1;
				while (Z < UBFP2){
					if (FakePicture3[X + Z*off1] == 0)
						break;
					Z = Z + 1;
					
				}
				if (Z < UBFP2 && Z >= Y + 1){
					
					A = Z;
					Z = A + 1;
					while (Z < UBFP2){
						if (FakePicture3[X + Z*off1] > 0){
							Z = Z - 1;
							break;
						}
						Z = Z + 1;
						
					}
					if (Z < UBFP2 && Z >= A){
						for (C = A; C <= Z; C++)
							FakePicture2[X + C*off1] = FakePicture2[X + C*off1] + 1;
						
					}
				}
				Y = Z;
			}
			Y = Y + 1;
			
		}
	}
	
	for (Y = 0; Y <= UBFP2; Y++){
			off2 = Y*off1;
		for (X = 0; X <= UBFP1; X++){
			if (FakePicture[X + off2] == 5)
				FakePicture2[X + off2] = 1;
			else if (FakePicture2[X + off2] == 2)
				FakePicture2[X + off2] = 0.5;
			else
				FakePicture2[X + off2] = 0;
		}
	}
	return(1);
}





int FAR pascal ModFP(int UBFP1, int UBFP2, float *maxv, float *FakePicture){
	int X, Y, off1, off2;
	float MaxV;

	off1 = UBFP1+1;
	MaxV = *maxv;
	
	if (MaxV == 0){
		for (Y = 0; Y <= UBFP2; Y++){
			off2 = Y*off1;
			for (X = 0; X <= UBFP1; X++){
				if (MaxV < FakePicture[X + off2]) 
					MaxV = FakePicture[X + off2];
			}
			
		}
		//MaxV = MaxV/2;
	//if (MaxV > 4)
	//	MaxV = 4;
	//else if (MaxV <1)
	//	MaxV=1;
		
	*maxv = MaxV;

	}
	

    

	for (Y = 0; Y <= UBFP2; Y++){
		off2 = Y*off1;
		for (X = 0; X <= UBFP1; X++){
			if (FakePicture[X + off2] > 0){
				if (FakePicture[X + off2] < MaxV)
					FakePicture[X + off2] = FakePicture[X + off2] / MaxV;
				else
					FakePicture[X + off2] = 1;
			}
			
		}
	}



	return(1);

}

int FAR pascal MakeImageDataBO(int R, int G, int B, int UBFP, int UBID1, int UBID2, int UBID3, float *FakePicture, unsigned char *ImageData){
	int X, Y, off1, off2, off3, off4, off5, off6;
	float holder;
	off1 = UBID1+1;
	off2 = (UBID2+1)*off1;
	off5 = UBFP+1;
	for (Y = 0; Y <= UBID3; Y++){
		off3 = Y*off2;
		off6 = Y*off5;
		
		for (X = 0; X <= UBID2; X++){
			holder = FakePicture[X+off6];
			if (holder > 0){
				off4 = X*off1+off3;
				ImageData[off4] = (unsigned char)((1 - holder) * ImageData[off4] + (float)(R) * holder);
				ImageData[off4 +1] = (unsigned char)((1 - holder) * ImageData[off4 + 1] + (float)(G) * holder);
				ImageData[off4 +2] = (unsigned char)((1 - holder) * ImageData[off4 + 2] + (float)(B) * holder);
			}
		}
	}
    


	return(1);
}

int FAR pascal CopyEventInfo(int SEventNumber, int Nextno, int UBoD, int UBD, int UBE, int UBOE, int *BestEvent, int *OBE, unsigned char *oD, unsigned char *oMi, unsigned char *oMa, unsigned char *Daught, unsigned char *MinorPar, unsigned char *MajorPar){
	int X,Y, off1,off2,off3, off4,off5, off6;
	off1 = UBoD+1;
	off3 = UBD+1;
	off5 = UBE+1;
	off6 = UBOE+1;
	for (X = 0; X <= SEventNumber - 1; X++){
        for (Y = 0; Y <= Nextno; Y++){
			off2 = Y*off1;
			off4 = Y*off3;
            Daught[X+off4] = oD[X+off2];
            MinorPar[X+off4] = oMi[X+off2];
            MajorPar[X+off4] = oMa[X+off2];
        }
        BestEvent[X] = OBE[X];
        BestEvent[X + off5] = OBE[X + off6];
    }

	return(1);

}




int FAR pascal CopySingleDist(int UB, int UBPVX, int UBPV, float *PermValidx, float *PermValid, float *PermDiffsx, float *PermDiffs){
	int X, Y, off1, off2, off3, off4, ub;
	off1 = UBPVX+1;
	off2 = UBPV+1;

	if (UB < UBPVX)
		ub = UB;
	else
		ub=UBPVX;

	for (Y = 0; Y <= ub; Y++){
		off3 = off1*Y;
		off4 = off2*Y;
        for (X = 0; X <= ub; X++){
            PermValidx[X + off3] = PermValid[X + off4];
            PermDiffsx[X + off3] = PermDiffs[X + off4];
        }
	}

	return(1);
}

int FAR pascal CopySingleArray (int D1, int D2, int LS, int Nextno, int LS2, int Nextno2, float *SeqNum, float *PermSeqNum){
	int X, Y, off1, off2;
	
	for (X = 0; X <= D2; X++){
		off1 = X*(LS+1);
		off2 = X*(LS2+1);
		for (Y = 0; Y <= D1; Y++) 
			PermSeqNum[Y + off2] = SeqNum[Y + off1];
	}
	return(1);
}

double FAR pascal MakeDistModPar(int Nextno, int UB1, int UB2, float *Tot, float *FMat, float *SMat, float *PermDiffs, float *PermValid){
	int X,Y, off1, off2;
    float TParDist;

	TParDist=0;

	off1 = UB1+1;
	off2 = UB2+1;
	for (X = 0; X <= Nextno; X++){
        for (Y = X + 1; Y <= Nextno; Y++){
            if (FMat[X + Y*off1] < 3 ){
                Tot[0] = Tot[0] + FMat[X + Y*off1];
                Tot[1] = Tot[1] + SMat[X + Y*off1];
                TParDist = (float)(1.0 - (PermDiffs[X + Y*off2] / PermValid[X + Y*off2]));
                if (TParDist > 0.25){
                    TParDist = (float)((4.0 * TParDist - 1.0) / 3.0);
                    TParDist = (float)(log(TParDist));
                    TParDist = (float)(-0.75 * TParDist);
				}
                else
                    TParDist = 1;
                
                Tot[2] = Tot[2] + TParDist;
            }
		}
	}

	return(TParDist);
}

int FAR pascal UpdateDistArrays(int NextNo, int X, int A, int UB1, int UB2, int UB3, int UB4, int UB5, int UB6, float *TreeFMat, float *TreeSMat, float *FMat, float *SMat,float *TreeMatrix, float *Distance){
	
	/*
	UB1 = UBound(TreeFMat, 1)
    UB2 = UBound(TreeSMat, 1)
    UB3 = UBound(FMat, 1)
    UB4 = UBound(SMat, 1)
    UB5 = UBound(TreeMatrix, 1)
    UB6 = UBound(Distance, 1)
	  */


	int B, Y, o1,o2,o3,o4,o5,o6, o7;
	o1 = UB1+1;//treefmat
	o2 = UB2+1;//treesmat
	o3 = X*(UB3+1);//fmat
	o4 = X*(UB4+1);//smat
	o5 = UB5+1;//treematrix
	o6 = X*(UB6+1);//distance
	o7 = UB3+1;
	B = A + 1;
	for (Y = X + 1; Y <= NextNo; Y++){
        if (FMat[Y + Y*o7] !=3 ){
            
            TreeMatrix[A + B*o5] = (float)(1.0 - Distance[Y + o6]);
            TreeMatrix[B + A*o5] = (float)(1.0 - Distance[Y + o6]);
            TreeFMat[A + B*o1] = FMat[Y + o3];
            TreeSMat[A + B*o2] = SMat[Y + o4];
            TreeFMat[B + A*o1] = FMat[Y + o3];
            TreeSMat[B + A*o2] = SMat[Y + o4];
            
            B++;
        }
                
	}


	return (1);
}


int FAR pascal AddToRegionMat(int LS, int ST, int EN, int RSize, float SConvert, float ParDist, float *RegionMat){
	int LS1,LS2,A, B, RS1, RS2, off1;
	float RM;
	LS1 = -1;
	LS2 = -1;

	off1 = RSize+2;//the regionmat array is dimentioned rsize+1 X rsize+1

    if (ST < EN){
        
        for (A = 1; A <= ST - 1; A++){
            RS1 = int(A * SConvert);
            if (LS1 != RS1){
                LS1 = RS1;
                
                for (B = ST; B <= EN; B++){
                    RS2 = int(B * SConvert);
                    if (LS2 != RS2){
                        LS2 = RS2;
                        RM=RegionMat[RS2 + RS1*off1];
                        if (ParDist > RM){
                            RegionMat[RS2 + RS1*off1] = ParDist;
                            RegionMat[RS1 + RS2*off1] = ParDist;
                        }
                    }
                }
            }
		}
       
        for (A = EN + 1; A <=LS; A++){
            RS1 = int(A * SConvert);
            if (LS1 != RS1){
                LS1 = RS1;
                
                for (B = ST; B <= EN; B++){
                    RS2 = int(B * SConvert);
                    if (LS2 != RS2){
                        LS2 = RS2;
                        RM=RegionMat[RS2 + RS1*off1];
                        if (ParDist > RM){
                            RegionMat[RS2 + RS1*off1] = ParDist;
                            RegionMat[RS1 + RS2*off1] = ParDist;
                        }
                    }
                }
            }
        }
	}
    else{
        
        for (A = EN + 1; A < ST; A++){
            RS1 = int(A * SConvert);
            if (LS1 != RS1){
                LS1 = RS1;
            
                for (B = 1; B <= EN; B++){
                    RS2 = int(B * SConvert);
                    if (LS2 != RS2){
                        LS2 = RS2;
                        RM=RegionMat[RS2 + RS1*off1];
                        if (ParDist > RM){
                            RegionMat[RS2 + RS1*off1] = ParDist;
                            RegionMat[RS1 + RS2*off1] = ParDist;
                        }
                    }
                }
                for (B = ST; B <= LS; B++){
                    RS2 = int(B * SConvert);
                    if (LS2 != RS2){
                        LS2 = RS2;
                        RM=RegionMat[RS2 + RS1*off1];
                        if (ParDist > RM){
                            RegionMat[RS2 + RS1*off1] = ParDist;
                            RegionMat[RS1 + RS2*off1] = ParDist;
                        }
                    }
                }
            }
        }
        
    }

	return(1);
}
/*int FAR pascal Copy1Seq (int LS, int Nextno, short int *SeqNum, short int *PermSeqNum){
	int X, Y, off1;
	for (X = 0; X <= Nextno; X++){
		off1 = X*(LS+1);
		for (Y = 1; Y <= LS; Y++) 
			PermSeqNum[Y + off1] = SeqNum[Y + off1];
	}
	return(1);
}*/

int FAR pascal StripUnfound2(int WinPP, int AddNum, int *RNum, int *WinnerPos, int *Rlist, int *BReaks){
	//winnerpos rnum(winpp), addnum
	int X, Z, GoOn, wo;
	Z=0;
	wo = RNum[WinPP]+1;
	while (Z <= RNum[WinPP]){
        GoOn = 1;
        for (X = 0; X <= AddNum; X++){
            if (WinnerPos[Z + X*wo] > 0){
                GoOn = 0;
                break;
            }
        }
        if (GoOn == 1){
            if (Z < RNum[WinPP]){
                Rlist[WinPP + Z*3] = Rlist[WinPP + RNum[WinPP]*3];
                for (X = 0; X <= AddNum; X++)
                    WinnerPos[Z + X*wo] = WinnerPos[RNum[WinPP] + X*wo];
                BReaks[Z*2] = BReaks[RNum[WinPP]*2];
                BReaks[1 + Z*2] = BReaks[1 + RNum[WinPP]*2];
            }
            RNum[WinPP] = RNum[WinPP] - 1;
		}
        else
            Z++;
	}
	return(1);
}

int FAR pascal MakeUninvolved(int WinPP, int Nextno, int *UnInvolved, int *RNum, int *Rlist){
	int X;
	for (X = 0; X <= Nextno; X++)
        UnInvolved[X] = 1;
    for (X = 0; X <= RNum[WinPP]; X++)
        UnInvolved[Rlist[WinPP + X*3]] = 0;
	return(1);
}

int FAR pascal SplitEvent (int xoverwin, int LS, int LenXoverSeq, int SeqDaughter, int SeqMinorP, int BTarget, int ETarget, int *XOverLength, int *NCommon, int *XPosDiff, char *XOverSeqNum){
	//xoverseqnum - ls,2
	int X, NumDifferent, TC;
	TC=0;
	if ((SeqDaughter == 0 && SeqMinorP == 1) || (SeqDaughter == 1 && SeqMinorP == 0))
		TC = 0;
	else if ((SeqDaughter == 0 && SeqMinorP == 2) || (SeqDaughter == 2 && SeqMinorP == 0))
		TC = 1;
	else if ((SeqDaughter == 2 && SeqMinorP == 1) || (SeqDaughter == 1 && SeqMinorP == 2))
		TC = 2;

	int os1 = xoverwin+TC*(LS+1+xoverwin*2);
	
	if (ETarget >= BTarget){
		for (X = XPosDiff[BTarget]; X <= XPosDiff[ETarget]; X++){
			if (XOverSeqNum[X + os1])
				*NCommon = *NCommon + 1;
		}
        *XOverLength = XPosDiff[ETarget] - XPosDiff[BTarget] + 1;
	}
	else{
		for (X = XPosDiff[BTarget]; X <= LenXoverSeq; X++){
			if (XOverSeqNum[X + os1])
				*NCommon = *NCommon + 1;
		}
                                        
		for (X = 1; X <= XPosDiff[ETarget]; X++){
			if (XOverSeqNum[X + os1])
				*NCommon = *NCommon + 1;                                            
		}
                                        
        *XOverLength = LenXoverSeq - XPosDiff[BTarget] + 1 + XPosDiff[ETarget];
                                            
	}
    NumDifferent = *XOverLength - *NCommon ;
	return(NumDifferent);
}


double FAR pascal MakeRMat(int Nextno, int WinPP, double *RMat, double *LMat, double *PDist, int *Iseqs, float *FMat, float *SMat, int *CompMat, double *Ttx){
	int D, X, A, B, Z, Y,ro1,ro2,ro3;

	//dims rmat 2,5,nextno
	//     lmat 2,3,1,nextno
	//     pdist 2,3
	//     compmat 2,1
	for (X = 0; X < 4; X++){ // position, 01 = bpos, 23 = epos
        
		for (Y = 0; Y < 2; Y++){// 'alternative iseqs
			if (X < 2){// ' ie if bpos
                    A = 0;
                    if (X == 0)// Then ' if lhs bpos
                        B = 0;// 'start with 1st position
                    else //' if rhs bpos
                        B = 3;// 'start with last position
                 
			}
			else{// ' ie if epos
                    A = 1;
                    if (X == 2)
                        B = 0;
                    else
                        B = 3;
			}
                for (Z = 0; Z <= Nextno; Z++)
                    //RMat(A, B + Y, Z) = LMat(WinPP, X, Y, Z)
                    RMat[A + (B + Y)*3 + Z*18] = LMat[WinPP + X*3 + Y*12 + Z*24];
               
		}
        
	}
       //add parental distances to one another to rmat
        
	for (X = 0; X <= Nextno; X++){
		ro1 = X*18;
        RMat[6 + ro1] = PDist[WinPP];
        RMat[15 + ro1] = PDist[WinPP + 3];
        RMat[7 + ro1] = PDist[WinPP + 6];
        RMat[16 + ro1] = PDist[WinPP + 9];
            
		//RMat(2, 2, X) = FMat(Iseqs(CompMat(WinPP, 1)), Iseqs(CompMat(WinPP, 0)))
        //RMat(2, 5, X) = SMat(Iseqs(CompMat(WinPP, 1)), Iseqs(CompMat(WinPP, 0)))
		ro2 = Iseqs[CompMat[WinPP]]*(Nextno+1);
		ro3 = Iseqs[CompMat[WinPP + 3]];
		RMat[8 + ro1] = FMat[ro3 + ro2];
        RMat[17 + ro1] = SMat[ro3 + ro2];
		
		//'Do full sequence rmat
		for (Y = 0; Y < 2; Y++){
			ro2 = Iseqs[CompMat[WinPP + Y*3]]*(Nextno+1);
            RMat[2 + Y*3 + ro1] = FMat[X + ro2];
            RMat[2 + (Y + 3)*3 + ro1] = SMat[X + ro2];
		}
	}
        
        //addjust rmat
        
	//for (Z = 0; Z < 3; Z++){
	Z=2;
		for (X = 0; X <= Nextno; X++){
               
                ro1 = X*18;
                Ttx[0] = 0.0;
				Ttx[1] = 0.0;
                for (D = 0; D < 3; D++){
                    Ttx[0] = Ttx[0] + RMat[Z + D*3 + ro1];
					Ttx[1] = Ttx[1] + RMat[Z + (D+3)*3 + ro1];
				}
				if (Ttx[0] > 0)
					Ttx[0] = 2/Ttx[0];
				else
					Ttx[0] = 0;
				
				if (Ttx[1] > 0)
					Ttx[1] = 2/Ttx[1];
				else
					Ttx[1] = 0;

				if (Ttx[0] > 0){
						for (D = 0; D < 3; D++)
							RMat[Z + D*3 + ro1] = 1-RMat[Z + D*3 + ro1] * Ttx[0];
				}
				else{
                    for (D = 0; D < 3; D++)
                        RMat[Z + D*3 + ro1] = 0.0;
				}
                
				if (Ttx[1] > 0){
						for (D = 3; D < 6; D++)
							RMat[Z + D*3 + ro1] = 1-RMat[Z + D*3 + ro1] * Ttx[1];
				}
				else{
                    for (D = 3; D < 6; D++)
                        RMat[Z + D*3 + ro1] = 0.0;
				}
		}
	//}
	return(1);
}


double FAR pascal MakePrintPoints(int lseq, int XDist, int YDist, int PicHeight,double XFactor, float *Theta, float *rScore, float *PrintPoints, int *Decompress){
	int x, off1, off2, xp, yp;
	off1 = XDist+1;
	//PrintPoints(XDist, YDist)
	for (x = 1; x<=lseq; x++){
		xp = 	(int)((Decompress[x] * XFactor) + 0.49);
		yp = (int)(((1 - (Theta[x] / 360.0)) * (PicHeight - 35))+0.49);
		off2 = yp*off1;
        PrintPoints[xp + off2] = PrintPoints[xp + off2] + rScore[x];
    
    }

	return(1);
}



int FAR pascal MakeFastLineList(int PC, int ExtraZ, int PHAdj, float dixb, float AmB, int LOffset,int GPrintLen, int PicHeight, float WFactor, int Y, int OriMod1, int UBDC, int OriMod2, int UBLL1, int UBGPP1, int UBGP1, float *CurveArray, float *GPrintMin, float *LineList, int *GPrintPos, float *GPrint, int *Decompress){
	int PosCount, A, GPP, off1, off2;
	
	A = Y;
	off1 = UBGP1+1;
	off2 = UBGPP1+1;
	for (PosCount = Y; PosCount <= GPrintLen; PosCount++){
        GPP = GPrintPos[ExtraZ + A*off2];           
		if (GPP > 0 && GPP <= UBDC){
                   
		   if (OriMod1 == 1) {
             if (GPrint[ExtraZ + A*off1] < GPrintMin[0])
                   GPrint[ExtraZ+ A*off1] = GPrintMin[0];
             else if (GPrint[ExtraZ+ A*off1] > GPrintMin[1])
                   GPrint[ExtraZ+ A*off1] = GPrintMin[1];
                  
		   }
		   else if (OriMod1 == 0){
			   if (OriMod2 * GPrint[ExtraZ+ A*off1] > GPrintMin[0]) 
                     GPrint[ExtraZ + A*off1] = GPrintMin[0];
               else if (OriMod2 * GPrint[ExtraZ+ A*off1] < GPrintMin[1])
                     GPrint[ExtraZ + A*off1] = GPrintMin[1];
		   }
               
               
            GPP = Decompress[GPP];
			
            LineList[PC*2] = LOffset + (float)(GPP * WFactor * CurveArray[GPP]);
            LineList[1 + PC*2] = PicHeight - (15 + ((OriMod2 * GPrint[ExtraZ+ A*off1] - dixb) / AmB) * PHAdj);
            
            PC = PC + 1;
                   
                   
		}
        A = A + 1;
           
	}


	return(PC);
}


int FAR pascal DoAALineY(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture){
	
	float X3, hold, hold2;
	int off1, Y, IX;
	off1 = UBFP1+1;
	do{
        Y = (long)(Y1+0.5);
		if (Y < UBFP2){
			if (X1 != X2)
				X3 = (Y1 - C) / M;
			else
				X3 = X1;
        
			if (X3 >= X1) {
				if (X3 <= X2){
					IX = (long)(X3);
					if (IX < UBFP1 ){
						hold = (float)(1.0 - (X3 - IX));
						hold2 = (float)(X3 - IX);
						if (FakePicture[IX + Y*off1] <= hold )
							FakePicture[IX + Y*off1] = hold;
						if (hold2 > FakePicture[IX + 1 + Y*off1])
							FakePicture[IX + 1 + Y*off1] = hold2;
					}
				}
			}
			Y1 = (float)(Y1 + 0.5);
		}
		else
			break;
        if (Y1 > Y2)
			break;
	} while (Y1 <=Y2);


	return(1);
}
int FAR pascal DoAALineYT(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture){
	
	float X3, hold, hold2;
	int off1, Y, IX;
	off1 = UBFP1+1;
	do{
        Y = (int)(Y1+0.5);
		if (Y < UBFP2){
			if (X1 != X2)
				X3 = (Y1 - C) / M;
			else
				X3 = X1;
        
			if (X3 >= X1) {
				if (X3 <= X2){
					IX = (int)(X3);
					if (IX < UBFP1 ){
						hold = (float)(1.0 - (X3 - IX));
						//hold=hold/4;
						hold2 = (float)(X3 - IX);
						//hold2=hold2/4;
						if (FakePicture[IX + Y*off1] < hold )
							FakePicture[IX + Y*off1] = hold;
						if (hold2 > FakePicture[IX + 1 + Y*off1])
							FakePicture[IX + 1 + Y*off1] = hold2;
					}
				}
			}
			
		}
		else
			break;
		if (Y1==Y2)
			break;
		Y1 = (float)(Y1 + 0.5);
        if (Y1 > Y2)
			Y1=Y2;
	} while (Y1 <=Y2);


	return(1);
}



int FAR pascal FillORFWin(int Z, int FrameRef, int SIL, int EIL, int UBOW1, int UBOW2, short int *ORFWin){
	int F, os;
	os = UBOW1+1;
	for (F = SIL; F <= EIL; F++){
        if (UBOW2 >= F)
            ORFWin[FrameRef + F*os] = Z;
        else
            ORFWin[FrameRef, UBOW2*os] = Z;
       
    }

	return(1);
}
int FAR pascal DoAALineXY(int UBFP1, int UBFP2, int UBLL1, int UBLL2, float *FakePicture, float *LineList){
//int FAR pascal DoAALineX(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture){
//int FAR pascal DoAALineY(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture){

	int  Z, os1, Dummy;
	float C,  M,  Y1,  Y2,  X1,  X2, X4, Y4, BigNum;

	BigNum = 10 ^ 10;
	os1 = UBLL1+1;
	Z=1;
	do{
        X1 = LineList[Z*os1];
        X2 = LineList[(Z + 1)*os1];
        if (X2 >= X1){
            Y1 = LineList[1 + Z*os1];
            if (X1 > 0 || Y1 > 0) {
                Y2 = LineList[1 + (Z + 1)*os1];
                if (X2 > 0 || Y2 > 0){
                    if (X2 != X1)
                        M = (Y2 - Y1) / (X2 - X1);
                    else
                        M = BigNum;
                    
                    C = Y1 - M * X1;
                    
                    if (X1 >= X2){
                        X4 = X1;
                        X1 = X2;
                        X2 = X4;
                    }

                    if (Y1 >= Y2){
                        Y4 = Y1;
                        Y1 = Y2;
                        Y2 = Y4;
                    }
                    
                    //do the middle bits
                    
                    
                    if (fabs((X1) - (X2)) >= fabs((Y1) - (Y2)))
						Dummy = DoAALineX(C, M, Y1, Y2, X1, X2, UBFP1, UBFP2, FakePicture);
                        
                    else {
                        if (Y1 != Y2)
							Dummy = DoAALineY(C, M, Y1, Y2, X1, X2, UBFP1, UBFP2, FakePicture);
                        
                    }
                }
            }
        }
        Z++;
        
        
    } while (Z < UBLL2);

	return(1);
}

int FAR pascal DoAALineX(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture){
	float Y3, hold, hold2;
	int off1, X, IY;
	off1 = UBFP1+1;
	do{
            
        if (Y1 != Y2)
            Y3 = M * X1 + C;
        else
            Y3 = Y1;
        

		if (Y3 <= UBFP2){
			X = (int)(X1+0.5);
			if (X < UBFP1) {
				if (Y3 >= Y1 && Y3 <= Y2){
					//if (X <= UBFP1){
						IY = (int)(Y3);
						hold = (float)(1.0 - (Y3 - IY));
						hold2 = (float)(Y3 - IY);
						if (hold> FakePicture[X + IY*off1])
							FakePicture[X + IY*off1] = hold;
						if (hold2 > FakePicture[X + (IY+1)*off1])
							FakePicture[X + (IY+1)*off1] = hold2;
						
					//}
				}
			}
		}
        
		if (X1==X2)
			break;
        X1 = (float)(X1 + 0.5);
        if (X1 > X2)
			X1=X2;
	}while (X1 <= X2);
	return(1);
}

int FAR pascal DoAALineXT(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture){
	float Y3, hold, hold2;
	int off1, X, IY;
	off1 = UBFP1+1;
	do{
            
        if (Y1 != Y2)
            Y3 = M * X1 + C;
        else
            Y3 = Y1;
        

		if (Y3 <= UBFP2){
			X = (int)(X1 +0.5);
			if (X < UBFP1) {
				if (Y3 >= Y1 && Y3 <= Y2){
					if (X <= UBFP1){
						IY = (int)(Y3);
						hold = (float)((1.0 - (Y3 - IY))/4);
						hold2 = (float)((Y3 - IY)/4);
						if (hold> FakePicture[X + IY*off1])
							FakePicture[X + IY*off1] = hold;
						if (hold2 > FakePicture[X + (IY+1)*off1])
							FakePicture[X + (IY+1)*off1] = hold2;
						
					}
				}
			}
		}
        
    
        X1 = (float)(X1 + 0.5);
        if (X1 > X2)
			break;
	}while (X1 <= X2);
	return(1);
}

double FAR pascal SuperDist(int X, int Nextno, int UB14, int UB04, int UB13, int UB03, int UB12, int UB02, int UB11, double *avdst, float *pd, float *pv, float *dist, short int *redodist, int *SeqCatCount, short int *ISeq14, short int *ISeq04, short int *ISeq13, short int *ISeq03, short int *ISeq12, short int *ISeq02, short int *ISeq11, char *CompressValid14, char *CompressDiffs14, char *CompressValid13, char *CompressDiffs13, char *CompressValid12, char *CompressDiffs12, char *CompressValid11, char *CompressDiffs11,  char *CompressDiffs04,  char *CompressDiffs03, char *CompressDiffs02){
	int Z, Y, TValid, TDiffs, os14, os04, os13, os03, os12, os02, os11, ps14, ps04, ps13, ps03, ps12, ps02, ps11, qs14, qs04, qs13, qs03, qs12, qs02, qs11;
	int cv14,cv04,cv13,cv03,cv12,cv02,cv11;
	

	double v1,d1, dX, ad, upper;
	int o3,o4;
	ad = *avdst;
	upper = 0.0;

	cv14 = 626;
	cv04 = 1025;
	cv13 = 1025;
	cv03 = 730;
	cv12 = 730;
	cv02 = 1025;
	cv11 = 1025;
	
	os14 = UB14+1;
	os04 = UB04+1;
	os13 = UB13+1;
	os03 = UB03+1;
	os12 = UB12+1;
	os02 = UB02+1;
	os11 = UB11+1;

	qs14 = os14*X;
	qs04 = os04*X;
	qs13 = os13*X;
	qs03 = os03*X;
	qs12 = os12*X;
	qs02 = os02*X;
	qs11 = os11*X;
	for (Y = X + 1; Y <= Nextno; Y++){
		if (redodist[X] + redodist[Y] >0){
			TValid = 0;
			TDiffs = 0;
			ps14 = os14*Y;
			ps04 = os04*Y;
			ps13 = os13*Y;
			ps03 = os03*Y;
			ps12 = os12*Y;
			ps02 = os02*Y;
			ps11 = os11*Y;
			v1=0;
			d1=0;
			
			//14
			for (Z = 1; Z <= UB14; Z++){
				TValid = TValid + CompressValid14[ISeq14[Z +qs14] + ISeq14[Z + ps14]*cv14];
				TDiffs = TDiffs + CompressDiffs14[ISeq14[Z +qs14] + ISeq14[Z + ps14]*cv14];
			}
       
			//13
			for (Z = 1; Z <= UB13; Z++){
				TValid = TValid + CompressValid13[ISeq13[Z +qs13] + ISeq13[Z + ps13]*cv13];
				TDiffs = TDiffs + CompressDiffs13[ISeq13[Z +qs13] + ISeq13[Z + ps13]*cv13];
			}
        
			//04
		   for (Z = 1; Z <= UB04; Z++){
				TDiffs = TDiffs + CompressDiffs04[ISeq04[Z +qs04] + ISeq04[Z + ps04]*cv04];
			}
        
			TValid = TValid + SeqCatCount[8];
        
			//12
			for (Z = 1; Z <= UB12; Z++){
				
				TValid = TValid + CompressValid12[ISeq12[Z +qs12] + ISeq12[Z + ps12]*cv12];
				TDiffs = TDiffs + CompressDiffs12[ISeq12[Z +qs12] + ISeq12[Z + ps12]*cv12];
			}
        
			//03
			for (Z = 1; Z <= UB03; Z++){
				TDiffs = TDiffs + CompressDiffs03[ISeq03[Z +qs03] + ISeq03[Z + ps03]*cv03];
			}        
			TValid = TValid + SeqCatCount[6];
        
			//11
			for (Z = 1; Z <= UB11; Z++){
				TValid = TValid + CompressValid11[ISeq11[Z +qs11] + ISeq11[Z + ps11]*cv11];
				TDiffs = TDiffs + CompressDiffs11[ISeq11[Z +qs11] + ISeq11[Z + ps11]*cv11];
			}
        
			//02
			for (Z = 1; Z <= UB02; Z++){
				TDiffs = TDiffs + CompressDiffs02[ISeq02[Z +qs02] + ISeq02[Z + ps02]*cv02];
			}        
			TValid = TValid + SeqCatCount[4];
			TValid = TValid + SeqCatCount[2];
       

			if (TValid >= 1) {
				v1 = (double)(TValid);
				d1 = (double)(TDiffs);
				if (v1 >= 1.0)
					dX = (double)((v1-d1) / v1);
				else
					dX = 0.0;
			}
			else
				dX = 0.0;
			
			o3 = X + Y*(Nextno+1);
			o4 = Y + X*(Nextno+1);
			dist[o3] = (float)(dX);
			dist[o4] = (float)(dX);
			pv [o3]= (float)(v1);
			pv [o4]= (float)(v1);
			pd [o3]= (float)(d1);
			pd [o4]= (float)(d1);
			ad = ad + (1.0 - dX);
			if(dX > upper)
				upper = dX;
		}
        
    }
	*avdst = ad; 
	return(upper);
}


int FAR pascal GetCoRec(int X, int PermNextno, int UBD, unsigned char *Daught) {
	int Y, CoRec, off;
	off=UBD+1;
	CoRec = 0;
	for (Y = 0; Y<= PermNextno; Y++){
        if (Daught[X + Y*off] != 0)
            CoRec = CoRec + 1;
    }

	return (CoRec);
}



int FAR pascal FinishDists2(int Nextno, float *PermValid, float *PermDiffs, float *TValid, float *TDiffs, float *Distance){
	int X, Y, off1, off2;
	off1=Nextno+1;
	for (X = 0; X <= Nextno; X++){
        off2 = off1*X;
		for (Y = 0; Y <= Nextno; Y++){
            PermValid[Y + off2] = TValid[Y + off2];
            PermDiffs[Y + off2] = TDiffs[Y + off2];
            if (PermValid[Y + off2] > 0)
                Distance[Y + off2] = (float)(1.0 - (float)(PermDiffs[Y + off2] / PermValid[Y + off2]));
            else
                Distance[Y + off2] = 10;
           
        }
    }
	return(1);
}

int FAR pascal SuperDist2(int Nextno, int UB14, int UB04, int UB13, int UB03, int UB12, int UB02, int UB11, int *SeqCatCount, short int *ISeq14, short int *ISeq04, short int *ISeq13, short int *ISeq03, short int *ISeq12, short int *ISeq02, short int *ISeq11, char *CompressValid14, char *CompressDiffs14, char *CompressValid13, char *CompressDiffs13, char *CompressValid12, char *CompressDiffs12, char *CompressValid11, char *CompressDiffs11,  char *CompressDiffs04,  char *CompressDiffs03, char *CompressDiffs02){
	int X, Z, Y, TValid, TDiffs, os14, os04, os13, os03, os12, os02, os11, ps14, ps04, ps13, ps03, ps12, ps02, ps11, qs14, qs04, qs13, qs03, qs12, qs02, qs11;
	int cv14,cv04,cv13,cv03,cv12,cv02,cv11;

	cv14 = 626;
	cv04 = 1025;
	cv13 = 1025;
	cv03 = 730;
	cv12 = 730;
	cv02 = 1025;
	cv11 = 1025;
	
	os14 = UB14+1;
	os04 = UB04+1;
	os13 = UB13+1;
	os03 = UB03+1;
	os12 = UB12+1;
	os02 = UB02+1;
	os11 = UB11+1;

	
	for (X = 0; X <= Nextno; X++){
		qs14 = os14*X;
		qs04 = os04*X;
		qs13 = os13*X;
		qs03 = os03*X;
		qs12 = os12*X;
		qs02 = os02*X;
		qs11 = os11*X;
		for (Y = X + 1; Y <= Nextno; Y++){
			TValid = 0;
			TDiffs = 0;
			ps14 = os14*Y;
			ps04 = os04*Y;
			ps13 = os13*Y;
			ps03 = os03*Y;
			ps12 = os12*Y;
			ps02 = os02*Y;
			ps11 = os11*Y;
				
			//14
			for (Z = 1; Z <= UB14; Z++){
				TValid = TValid + CompressValid14[ISeq14[Z +qs14] + ISeq14[Z + ps14]*cv14];
				TDiffs = TDiffs + CompressDiffs14[ISeq14[Z +qs14] + ISeq14[Z + ps14]*cv14];
			}
       
			//13
			for (Z = 1; Z <= UB13; Z++){
				TValid = TValid + CompressValid13[ISeq13[Z +qs13] + ISeq13[Z + ps13]*cv13];
				TDiffs = TDiffs + CompressDiffs13[ISeq13[Z +qs13] + ISeq13[Z + ps13]*cv13];
			}
        
			//04
		   for (Z = 1; Z <= UB04; Z++){
				TDiffs = TDiffs + CompressDiffs04[ISeq04[Z +qs04] + ISeq04[Z + ps04]*cv04];
			}
        
			TValid = TValid + SeqCatCount[8];
        
			//12
			for (Z = 1; Z <= UB12; Z++){
				
				TValid = TValid + CompressValid12[ISeq12[Z +qs12] + ISeq12[Z + ps12]*cv12];
				TDiffs = TDiffs + CompressDiffs12[ISeq12[Z +qs12] + ISeq12[Z + ps12]*cv12];
			}
        
			//03
			for (Z = 1; Z <= UB03; Z++){
				TDiffs = TDiffs + CompressDiffs03[ISeq03[Z +qs03] + ISeq03[Z + ps03]*cv03];
			}        
			TValid = TValid + SeqCatCount[6];
        
			//11
			for (Z = 1; Z <= UB11; Z++){
				TValid = TValid + CompressValid11[ISeq11[Z +qs11] + ISeq11[Z + ps11]*cv11];
				TDiffs = TDiffs + CompressDiffs11[ISeq11[Z +qs11] + ISeq11[Z + ps11]*cv11];
			}
        
			//02
			for (Z = 1; Z <= UB02; Z++){
				TDiffs = TDiffs + CompressDiffs02[ISeq02[Z +qs02] + ISeq02[Z + ps02]*cv02];
			}        
			TValid = TValid + SeqCatCount[4];
        
			TValid = TValid + SeqCatCount[2];
       
        
        
		}
	}
	return(1);
}



double FAR pascal MakeTheta(int plotf,int lseq, double SideB, double SideBs, double OD3, float *WinScoreV, float *rScore, float *Theta, float *VisRDOccupancyStat){

	int x, off, off2;
	double PF,hold1, hold2,SideRs,SideCs, SideC, DubHold1, DubHold2;
	PF = (double)(180.0 / 3.1415926535897);
	off =lseq+1;
	off2 = off*2;
	for (x = 1; x <= lseq; x++){	   
		SideRs = WinScoreV[x] - OD3;
		SideRs = SideRs*SideRs;
		hold1 = WinScoreV[x + off] - OD3;
		hold1=hold1*hold1;
		hold2 = WinScoreV[x + off2] - OD3;
		hold2=hold2*hold2;
		SideRs = SideRs + hold1 + hold2;
		hold1 = pow(SideRs,0.5);
		rScore[x] = (float)(hold1);
      
		SideCs = WinScoreV[x];
		SideCs = SideCs*SideCs;
		hold1 = WinScoreV[x + off] - 1;
		
		hold1=hold1*hold1;
		hold2 = WinScoreV[x + off2];
		hold2=hold2*hold2;
		SideCs = SideCs + hold1+hold2;
	
		
		
		hold2 = pow(SideCs,0.5);
        
		
		SideC = hold2;
		
		
		hold1 = rScore[x]*SideB;
	
		if (hold1 != 0.0){
			hold1 = (double) (rScore[x]);
			hold2 = (double)(2.0 * hold1 * SideB);
			DubHold1 = (double)(SideBs - SideCs + SideRs) ;
			DubHold1 = DubHold1/hold2;	
			
			DubHold2 = (double)(DubHold1); 	
			if (DubHold2 <= -1 || DubHold2 >= 1)
				DubHold2 = 0.9999999999;
			
			DubHold1 = acos(DubHold2);
			
			Theta[x] = (float)(DubHold1);
			Theta[x] = Theta[x] * (float)(PF);
		}
		else
			Theta[x] = (float)(90.0);

		
		if (WinScoreV[x] > WinScoreV[x+off2])
			Theta[x] = (float)(360.0) - Theta[x];
	
		
		if (rScore[x] > 0 && (WinScoreV[x] > 0 || WinScoreV[x+off] > 0 || WinScoreV[x + off2])){
			if (plotf == 0){
				if (Theta[x] > 300 || Theta[x] < 60)
					VisRDOccupancyStat[x] = VisRDOccupancyStat[x] + (float)(1.0);
				else if (Theta[x] < 180 && Theta[x] > 60 )
					VisRDOccupancyStat[x +off] = VisRDOccupancyStat[x +off] + (float)(1.0);
				else if (Theta[x] < 300 && Theta[x] > 180)
					VisRDOccupancyStat[x +off2] = VisRDOccupancyStat[x +off2] + (float)(1.0);
				else if (Theta[x] == 60){
					VisRDOccupancyStat[x] = VisRDOccupancyStat[x] + (float)(0.5);
					VisRDOccupancyStat[x +off] = VisRDOccupancyStat[x +off] + (float)(0.5);
				}
				else if (Theta[x] == 300){
					VisRDOccupancyStat[x] = VisRDOccupancyStat[x] + (float)(0.5);
					VisRDOccupancyStat[x +off2] = VisRDOccupancyStat[x +off2] + (float)(0.5);
				}
				else if (Theta[x] == 180){
					VisRDOccupancyStat[x +off] = VisRDOccupancyStat[x +off] + (float)(0.5);
					VisRDOccupancyStat[x +off2] = VisRDOccupancyStat[x +off2] + (float)(0.5);
				}
			}
		}
		else
			rScore[x] = 0;
			
		
		Theta[x] = Theta[x] + (float)(180.0);
		if (Theta[x] > 360)
			Theta[x] = Theta[x] - (float)(360.0);
		 
			
    
	}

	return(1);
}


double FAR pascal MakeWinScoreV(int Seq1, int Seq2,int Seq3,int Seq4,int lseq, int VWin, char *NucMat, short int *SeqNum, float *d, float *VScoreMat, float *WinScoreV){
	
	int x, NX, off1, off2, off3, off4, off5,  S1, S2, S3, s4, LP, NP;
	float FS, hold;
	//ReDim WinScoreV(Len(StrainSeq(0)), 2)
	off1 = (int)(1 - (VWin / 2));
	off2 = int(VWin / 2);
	

	d[0] = 0.0;
	d[1] = 0.0;
	d[2] = 0.0;
	off3 = lseq+1;
	for (NX = off1; NX <= off2; NX++){
	
		x = NX;
		off4 = off3*x;
		if (x < 1)
			x = lseq + x;
		if (x > lseq)
			x = x - lseq;
        
   
	
		S1 = NucMat[SeqNum[x + Seq1*off3]];
		S2 = NucMat[SeqNum[x + Seq2*off3]];
		S3 = NucMat[SeqNum[x + Seq3*off3]];
		s4 = NucMat[SeqNum[x + Seq4*off3]];
		off5 = S1 + S2*5 + S3*25 + s4*125;
		d[0] = d[0] + VScoreMat[off5];
		d[1] = d[1] + VScoreMat[off5+625];
		d[2] = d[2] + VScoreMat[off5+1250];
    
	}

	hold = (float)(d[0] + d[1] + d[2]);
	FS=hold;
	if (FS > 0.1){
		WinScoreV[1] = (float)(d[0] / FS);
		WinScoreV[1 + off3] = (float)(d[1] / FS);
		WinScoreV[1 + off3*2] =(float)(d[2] / FS);
	}
	else{
		WinScoreV[1] = (float)(1/3);
		WinScoreV[1 + off3] = (float)(1/3);
		WinScoreV[1 + off3*2] = (float)(1/3);
	}

	for (NX = 2; NX <=lseq; NX++){
		LP = NX - off2;
		NP = NX + off2;
		if (LP < 1)
			LP = lseq + LP;
		if (NP > lseq) 
			NP = NP - lseq;
		S1 = NucMat[SeqNum[LP + Seq1*off3]];
		S2 = NucMat[SeqNum[LP + Seq2*off3]];
		S3 = NucMat[SeqNum[LP + Seq3*off3]];
		s4 = NucMat[SeqNum[LP + Seq4*off3]];
		
		off5 = S1 + S2*5 + S3*25 + s4*125;
		d[0] = d[0] - VScoreMat[off5];
		d[1] = d[1] - VScoreMat[off5+625];
		d[2] = d[2] - VScoreMat[off5+1250];

		
		S1 = NucMat[SeqNum[NP + Seq1*off3]];
		S2 = NucMat[SeqNum[NP + Seq2*off3]];
		S3 = NucMat[SeqNum[NP + Seq3*off3]];
		s4 = NucMat[SeqNum[NP + Seq4*off3]];
		
		off5 = S1 + S2*5 + S3*25 + s4*125;
		d[0] = d[0] + VScoreMat[off5];
		d[1] = d[1] + VScoreMat[off5+625];
		d[2] = d[2] + VScoreMat[off5+1250];

		hold = (float)(d[0] + d[1] + d[2]);
	    FS=hold;
	
		if (FS > 0.1){
			WinScoreV[NX] = (float)(d[0] / FS);
			WinScoreV[NX + off3] = (float)(d[1] / FS);
			WinScoreV[NX + off3*2] = (float)(d[2] / FS);
		}
		else{
			WinScoreV[1] = (float)(1/3);
			WinScoreV[1 + off3] = (float)(1/3);
			WinScoreV[1 + off3*2] = (float)(1/3);
		}
	}


	return(1);
}

double FAR pascal MakeVScoreMat(float *ScoreMat){
	int x,y,Z,A, off1,off2,off3,off4;
	// ScoreMat(4, 4, 4, 4, 2)
	off1 = 5;

	for (x = 1; x < 5; x++){
		
		for (y = 1; y < 5; y++){
			off2 = y*5;
			for (Z = 1; Z <5; Z++){
				off3 = Z*25;
				for (A = 1; A <5; A++){
					off4 = x + off2 + off3 +A*125;
					if (x == y){
						if (x != Z){ 
                        
							if (Z == A)
							//ScoreMat(x, y, Z, A, 0) = 1; //xxyy
								ScoreMat[off4] = 1;
							else{
								if (A != x)//x = y and x <> z and x <> a and z <> a
									ScoreMat[off4] = 0.5; //xxyz
								
							}
						}
					}
					else {// x<>y
						if (x == Z){
							if (x != A){ // x<>y and x<>a and x=z
								if (A == y )
									ScoreMat[off4+625] = 1; //xyxy
								else
									ScoreMat[off4+625] = 0.5; //xyxz
								
							}
						}
						else {//x<>y AND x<>z
							if (x == A){ //x<>y and x<>z and x = a
								if (y == Z)
									ScoreMat[off4+1250] = 1; //xyyx
								else
									ScoreMat[off4+1250] = 0.5; //xyzx
								
							}
							else {//x is unique
								if (y == Z){
									if (y != A)
                                    
										ScoreMat[off4+1250] = 0.5; //xyyz
								
                                }
								else{
									if (Z == A){
										if (y != A)

											ScoreMat[off4] = 0.5; //xyzz
									
									}
									else{
										if (y == A)
											ScoreMat[off4+625] = 0.5; //xyzy
										
									}
								}
							}
						}
					}
				}
			}
		}
	}
	return(1);

}

double FAR pascal QuickDist(int lseq, int Nextno, int ub, int BPos3, int EPos3,float *FMat, float *SMat, float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum)
{

	int X, Y, Z, s1, xoff,yoff, count, valid, off3, off4, off5;
	int offset;
	float count2, valid2;
	offset = lseq+1;
	off3= Nextno+1;
    //Calculate valid sites and differences in the recombinant region
    
	if (BPos3 < EPos3){
		for (X = 0; X < Nextno; X++){
			xoff=offset*X;
			off4 = off3*X;
			for (Y = X + 1; Y <= Nextno; Y++){
				off5 = off3*Y;
				yoff=offset*Y;
				valid=0;
				count=0;
				for (Z = BPos3; Z <= EPos3; Z++){
					   s1 = SeqNum[Z + xoff];
					   if (s1 != 46){
							if (s1 == SeqNum[Z + yoff])
						   
								valid++;
						   
					   
						   else if (SeqNum[Z + yoff] != 46){
								valid++;
								count++;
									
						   }
					   }

			//		s1 = SeqNum [Z + xoff];
			//		if (s1 != 46){ 
			//		s2 = *(SeqNum + Z + yoff);
			//		if (s1 > 46 && s2 > 46){ 
			//			*(SubValid + X + Y*(Nextno+1)) = *(SubValid + X + Y*(Nextno+1)) + 1;
			//			if (s1 != s2) 
			//			   *(SubDiffs + X + Y*(Nextno+1)) = *(SubDiffs + X + Y*(Nextno+1)) + 1;
            //        
			//		}
				}
				count2 = (float)(count);
				valid2 = (float)(valid);
				SubValid [X + off5] = (float)(valid2);
				SubDiffs [X + off5] = (float)(count2);
				SubValid [Y + off4] = (float)(valid2);
				SubDiffs [Y + off4] = (float)(count2);
			}
		}
	}
	else{

		for (X = 0; X < Nextno; X++){
			xoff=offset*X;
			off4 = off3*X;
			for (Y = X + 1; Y <= Nextno; Y++){
				yoff=offset*Y;
				off5 = off3*Y;
				valid=0;
				count=0;
				for (Z = BPos3; Z <= lseq; Z++){
					s1 = SeqNum[Z + xoff];
			   
					 if (s1 != 46){
							if (s1 == SeqNum[Z + yoff])
						   
								valid++;
						   
					   
						   else if (SeqNum[Z + yoff] != 46){
								valid++;
								count++;
									
						   }
					   }
				}
				for (Z = 1; Z <= EPos3; Z++){
					   s1 = SeqNum[Z + xoff];
			   
					   if (s1 != 46){
							if (s1 == SeqNum[Z + yoff])
						   
								valid++;
						   
					   
						   else if (SeqNum[Z + yoff] != 46){
								valid++;
								count++;
									
						   }
					   }
				}
				count2 = (float)(count);
				valid2 = (float)(valid);
				SubValid [X + off5] = (float)(valid2);
				SubDiffs [X + off5] = (float)(count2);
				SubValid [Y + off4] = (float)(valid2);
				SubDiffs [Y + off4] = (float)(count2);
			}
		}


	}
	
	
     
    

	

	return(1);
}

double FAR pascal FinishDists(int lseq, int Nextno, int ub, int BPos3, int EPos3,float *FMat, float *SMat, float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum)
{

	int X, Y,  o1, off3;
	int offset;
	float th1,th2,th3,vv;
	offset = lseq+1;
	off3= Nextno+1;
    //Calculate valid sites and differences in the recombinant region
     
    for (X = 0; X < Nextno; X++){
        for (Y = X + 1; Y <= Nextno; Y++){
			o1 = Y*(off3);
			th1 = (float)(*(PermValid + X + Y*(ub+1)) - SubValid [X + o1]);
			if (th1 > 0 ){
				th2 = (float)(th1 - (*(PermDiffs + X + Y*(ub+1)) - SubDiffs [X + o1]));
				if (th1 == th2)
					*(FMat + X + o1)= (float)(0.0);
				else{
					th1 = (float)(th2 / th1);
					
					if (th1 > 0.25){
						th2 = (float)((4.0 * th1 - 1.0) / 3.0);
						th3 = (float)(log(th2));
						vv = (float)(-0.75 * th3);
						//if (vv > 1.0)
						//	vv=1.0;
						*(FMat + X + o1)= (float)(vv);
						//return (vv);
					}
					else
						*(FMat + X + o1) = 10.0;
                
                }
            }
			else
                *(FMat + X + o1) = 10.0;
                
            
            *(FMat + Y + X*(Nextno+1))= FMat [X + o1];
			
			//th1 = 0.0;
			//th2 = 0.0;
			th1 =  (float)(SubValid [X + o1]);
            if (th1 > 0 ){
				th2 = (float)(th1 - SubDiffs [X + o1]);
				if (th1 == th2)
					SMat [X + o1] =(float)(0.0);
				else{
					th1 = (float)(th2 / th1);
					if (th1 > 0.25){
						th2 = (float)((4.0 * th1 - 1.0) / 3.0);
						th3 = (float)(log(th2));
						vv = (float)(-0.75 * th3);
						SMat [X + o1] =(float)(vv);
					}
					else
						SMat [X + o1] = 10.0;
				}
                
                
            }
			else
                SMat [X + o1] = 10.0;
			
			
            *(SMat + Y + X*(Nextno+1))= SMat[X + o1];
        }
    }

	

	return(1);
}

double FAR pascal QuickDist5(int lseq, int Nextno, int ub, int BPos3, int EPos3, float *SMat, float *SubValid, float *SubDiffs, short int *SeqNum)
{

	int X, Y, Z, s1, xoff,yoff, count, valid,o1, off3, off4, off5;
	int offset;
	float th1,th2,th3,vv, count2, valid2;
	offset = lseq+1;
	off3= Nextno+1;
    //Calculate valid sites and differences in the recombinant region
    
	if (BPos3 < EPos3){
		for (X = 0; X < Nextno; X++){
			xoff=offset*X;
			off4 = off3*X;
			for (Y = X + 1; Y <= Nextno; Y++){
				off5 = off3*Y;
				yoff=offset*Y;
				valid=0;
				count=0;
				for (Z = BPos3; Z <= EPos3; Z++){
					   s1 = SeqNum[Z + xoff];
					   if (s1 != 46){
							if (s1 == SeqNum[Z + yoff])
						   
								valid++;
						   
					   
						   else if (SeqNum[Z + yoff] != 46){
								valid++;
								count++;
									
						   }
					   }

			//		s1 = SeqNum [Z + xoff];
			//		if (s1 != 46){ 
			//		s2 = *(SeqNum + Z + yoff);
			//		if (s1 > 46 && s2 > 46){ 
			//			*(SubValid + X + Y*(Nextno+1)) = *(SubValid + X + Y*(Nextno+1)) + 1;
			//			if (s1 != s2) 
			//			   *(SubDiffs + X + Y*(Nextno+1)) = *(SubDiffs + X + Y*(Nextno+1)) + 1;
            //        
			//		}
				}
				count2 = (float)(count);
				valid2 = (float)(valid);
				SubValid [X + off5] = (float)(valid2);
				SubDiffs [X + off5] = (float)(count2);
				SubValid [Y + off4] = (float)(valid2);
				SubDiffs [Y + off4] = (float)(count2);
			}
		}
	}
	else{

		for (X = 0; X < Nextno; X++){
			xoff=offset*X;
			off4 = off3*X;
			for (Y = X + 1; Y <= Nextno; Y++){
				yoff=offset*Y;
				off5 = off3*Y;
				valid=0;
				count=0;
				for (Z = BPos3; Z <= lseq; Z++){
					s1 = SeqNum[Z + xoff];
			   
					 if (s1 != 46){
							if (s1 == SeqNum[Z + yoff])
						   
								valid++;
						   
					   
						   else if (SeqNum[Z + yoff] != 46){
								valid++;
								count++;
									
						   }
					   }
				}
				for (Z = 1; Z <= EPos3; Z++){
					   s1 = SeqNum[Z + xoff];
			   
					   if (s1 != 46){
							if (s1 == SeqNum[Z + yoff])
						   
								valid++;
						   
					   
						   else if (SeqNum[Z + yoff] != 46){
								valid++;
								count++;
									
						   }
					   }
				}
				count2 = (float)(count);
				valid2 = (float)(valid);
				SubValid [X + off5] = (float)(valid2);
				SubDiffs [X + off5] = (float)(count2);
				SubValid [Y + off4] = (float)(valid2);
				SubDiffs [Y + off4] = (float)(count2);
			}
		}


	}
	
	
     
    for (X = 0; X < Nextno; X++){
        for (Y = X + 1; Y <= Nextno; Y++){
			o1 = Y*(Nextno+1);
			
			th1 =  (float)(SubValid [X + o1]);
            if (th1 > 0 ){
				th2 = (float)(th1 - SubDiffs [X + o1]);
				th1 = (float)(th2 / th1);
				if (th1 > 0.25){
					th2 = (float)((4.0 * th1 - 1.0) / 3.0);
					th3 = (float)(log(th2));
					vv = (float)(-0.75 * th3);
					SMat [X + o1] =(float)(vv);
				}
                else
                    SMat [X + o1] = 10.0;
                
                
            }
			else
                SMat [X + o1] = 10.0;
			
			
            *(SMat + Y + X*(Nextno+1))= SMat[X + o1];
        }
    }

	

	return(1);
}

double FAR pascal QuickDist6(int lseq, int Nextno, int ub, int BPos3, int EPos3, int *iseqs, float *SMat, float *SubValid, float *SubDiffs, short int *SeqNum)
{

	int X, Y, Z, s1, xoff,yoff, count, valid,o1, off3, off5;
	int offset;
	float th1,th2,th3,vv, count2, valid2;
	offset = lseq+1;
	off3= 3;
    //Calculate valid sites and differences in the recombinant region
    
	if (BPos3 < EPos3){
		for (X = 0; X < 3; X++){
			xoff=offset*iseqs[X];
			//off4 = off3*X;
			for (Y = 0; Y <= Nextno; Y++){
				off5 = off3*Y;
				yoff=offset*Y;
				valid=0;
				count=0;
				for (Z = BPos3; Z <= EPos3; Z++){
					   s1 = SeqNum[Z + xoff];
					   if (s1 != 46){
							if (s1 == SeqNum[Z + yoff])
						   
								valid++;
						   
					   
						   else if (SeqNum[Z + yoff] != 46){
								valid++;
								count++;
									
						   }
					   }

			//		s1 = SeqNum [Z + xoff];
			//		if (s1 != 46){ 
			//		s2 = *(SeqNum + Z + yoff);
			//		if (s1 > 46 && s2 > 46){ 
			//			*(SubValid + X + Y*(Nextno+1)) = *(SubValid + X + Y*(Nextno+1)) + 1;
			//			if (s1 != s2) 
			//			   *(SubDiffs + X + Y*(Nextno+1)) = *(SubDiffs + X + Y*(Nextno+1)) + 1;
            //        
			//		}
				}
				count2 = (float)(count);
				valid2 = (float)(valid);
				SubValid [X + off5] = (float)(valid2);
				SubDiffs [X + off5] = (float)(count2);
			}
		}
	}
	else{

		for (X = 0; X < 3; X++){
			xoff=offset*iseqs[X];
			//off4 = off3*X;
			for (Y = 0; Y <= Nextno; Y++){
				off5 = off3*Y;
				yoff=offset*Y;
				valid=0;
				count=0;
				for (Z = BPos3; Z <= lseq; Z++){
					s1 = SeqNum[Z + xoff];
				   if (s1 != 46){
						if (s1 == SeqNum[Z + yoff])
					   
							valid++;
					   
				   
					   else if (SeqNum[Z + yoff] != 46){
							valid++;
							count++;
								
					   }
				   }

				}
				for (Z = 1; Z <= EPos3; Z++){
					   
				   s1 = SeqNum[Z + xoff];
				   if (s1 != 46){
						if (s1 == SeqNum[Z + yoff])
					   
							valid++;
					   
				   
					   else if (SeqNum[Z + yoff] != 46){
							valid++;
							count++;
								
					   }
				   }

				}
				count2 = (float)(count);
				valid2 = (float)(valid);
				SubValid [X + off5] = (float)(valid2);
				SubDiffs [X + off5] = (float)(count2);
			}
		}


	}
	
	
     
    for (X = 0; X < 3; X++){
        for (Y = 0; Y <= Nextno; Y++){
			o1 = Y*3;
			
			th1 =  (float)(SubValid [X + o1]);
            if (th1 > 0 ){
				th2 = (float)(th1 - SubDiffs [X + o1]);
				th1 = (float)(th2 / th1);
				if (th1 > 0.25){
					th2 = (float)((4.0 * th1 - 1.0) / 3.0);
					th3 = (float)(log(th2));
					vv = (float)(-0.75 * th3);
					SMat [X + o1] =(float)(vv);
				}
                else
                    SMat [X + o1] = 10.0;
                
                
            }
			else
                SMat [X + o1] = 10.0;
			
			
            //SMat [Y + X*3]= SMat[X + o1];
        }
    }

	

	return(1);
}


int FAR pascal FillTempDataset (int X, int Y, int Nextno, int LSeq, char *TempDataset, int *TempMat) {

	int Z, off1, off2;
	off1 = LSeq+1;
	
//ReDim TempDataset(Len(StrainSeq(0)), Nextno)
	for (Z = 2; Z<= Nextno; Z++){
		off2 = off1*Z;
        if (TempDataset[X + off2] == 1 && TempDataset[Y + off2] == 1) 
            TempMat[0] = TempMat[0] + 1;
        else if (TempDataset[X + off2] == 1 && TempDataset[Y + off2] == 2)
            TempMat[1] = TempMat[1] + 1;
        else if (TempDataset[X + off2] == 2 && TempDataset[Y + off2] == 1)
            TempMat[2] = TempMat[2] + 1;
        else if (TempDataset[X + off2] == 2 && TempDataset[Y + off2] == 2)
            TempMat[3]= TempMat[3] + 1;
           
        
        
    }


	return(1);
}

int FAR pascal TreeGroupsX(int NextNo, char *THolder, int TLen, int NLen, char *DoneNode,char *TArray, char *TMatch, float *DLen){
	
	int X,Y,Z,Cnt, SeqID, NCount, Miss, Hit, off1;
	off1 = NextNo+1;
	NCount = -1;
	for (X = 1; X<= TLen; X++){
		if (THolder[X] == 40){// Then 'ie (
			Cnt = 1;
			NCount++;
			Y = X + 1;
			while (Cnt > 0){
				if(THolder[Y] == 40)// Then 'ie (
					Cnt++;
				else if (THolder[Y] == 41)// Then 'ie )
					Cnt--;
				else if (THolder[Y] == 83){//Then 'ie S
					SeqID = 0;
					for (Z = 1; Z<= NLen;Z++)
						SeqID = SeqID + (int)(0.1 + (THolder[Y + Z] - 48) * pow (10,NLen - Z));
					
					TArray[NCount + SeqID*off1] = 1;
				}
				Y++;
			}
		}

	}

	X=0;
	for (X = 0; X <= NextNo; X++){
		for (Y = 0; Y <= NextNo; Y++){
			if (DoneNode[Y] == 0){
				Miss = 0;
				Hit = 0;
				for (Z = 0; Z <= NextNo; Z++){
					if (TArray[Y + Z*off1] == TMatch[X+ Z*off1])
						Hit++;
					else
						Miss++;
					
					if (Miss > 0 && Hit > 0) 
						break;
				}
				if (Miss == 0 || Hit == 0){
					DLen[X] = DLen[X] + 1;
					DoneNode[Y] = 1;
				
				}
			}
		}
	}
	return(1);
}

double FAR pascal vQuickDist(int lseq, int Nextno, int ub, int BPos3, int EPos3,float *FMat, float *SMat,  float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum, int *iseqs)
{

	int A, B, X, Y, Z, s1, xoff,yoff, count, valid;
	int offset;
	float th1,th2,th3,vv, count2, valid2;
	offset = lseq+1;
    //Calculate valid sites and differences in the recombinant region
    
	if (BPos3 < EPos3){
		for (A = 0; A < 2; A++){
			X = iseqs[A];
			xoff=offset*X;

			for (B = A + 1; B < 3; B++){
				Y = iseqs[B];
				yoff=offset*Y;
				valid=0;
				count=0;
				for (Z = BPos3; Z <= EPos3; Z++){
					   s1 = SeqNum[Z + xoff];
			   
					   if (s1 == SeqNum[Z + yoff]){
						   if (s1 != 46){
								valid = valid + 1;
						   }
					   }
					   else if (s1 != 46){
								if (SeqNum[Z + yoff] != 46){
									valid = valid + 1;
									count=count+1;
								}
					   }
				}
				count2 = (float)(count);
				valid2 = (float)(valid);
				
				SubValid [Y + X*(Nextno+1)] = (float)(valid2);
				SubDiffs [Y + X*(Nextno+1)] = (float)(count2);
				SubValid [X + Y*(Nextno+1)] = (float)(valid2);
				SubDiffs [X + Y*(Nextno+1)] = (float)(count2);
			}
		}
	}
	else{

		for (A = 0; A < 2; A++){
			X = iseqs[A];
			xoff=offset*X;

			for (B = A + 1; B < 3; B++){
				Y = iseqs[B];
				yoff=offset*Y;
				valid=0;
				count=0;
				for (Z = BPos3; Z <= lseq; Z++){
					s1 = SeqNum[Z + xoff];
			   
					   if (s1 == SeqNum[Z + yoff]){
						   if (s1 != 46){
								valid = valid + 1;
						   }
					   }
					   else if (s1 != 46){
								if (SeqNum[Z + yoff] != 46){
									valid = valid + 1;
									count=count+1;
								}
					   }
				}
				for (Z = 1; Z <= EPos3; Z++){
					   s1 = SeqNum[Z + xoff];
			   
					   if (s1 == SeqNum[Z + yoff]){
						   if (s1 != 46){
								valid = valid + 1;
						   }
					   }
					   else if (s1 != 46){
								if (SeqNum[Z + yoff] != 46){
									valid = valid + 1;
									count=count+1;
								}
					   }
				}
				count2 = (float)(count);
				valid2 = (float)(valid);
				SubValid [X + Y*(Nextno+1)] = (float)(valid2);
				SubDiffs [X + Y*(Nextno+1)] = (float)(count2);
				SubValid [Y + X*(Nextno+1)] = (float)(valid2);
				SubDiffs [Y + X*(Nextno+1)] = (float)(count2);
			}
		}


	}
	
	

    for (A = 0; A < 2; A++){
		X = iseqs[A];
		for (B = A + 1; B < 3; B++){
			Y = iseqs[B];
			th1 = (float)(*(PermValid + X + Y*(ub+1)) - *(SubValid + X + Y*(Nextno+1)));
			if (th1 > 0 ){
				th2 = (float)(th1 - (*(PermDiffs + X + Y*(ub+1)) - *(SubDiffs + X + Y*(Nextno+1))));
				th1 = (float)(th2 / th1);
				
				if (th1 > 0.25){
					th2 = (float)((4.0 * th1 - 1.0) / 3.0);
					th3 = (float)(log(th2));
					vv = (float)(-0.75 * th3);
					//if (vv > 1.0)
					//	vv=1.0;
					*(FMat + X + Y*(Nextno+1))= (float)(vv);
					//return (vv);
				}
                else
                    *(FMat + X + Y*(Nextno+1)) = 10.0;
                
                
            }
			else
                *(FMat + X + Y*(Nextno+1)) = 10.0;
                
            
            *(FMat + Y + X*(Nextno+1))= *(FMat + X + Y*(Nextno+1));
			
			//th1 = 0.0;
			//th2 = 0.0;
			th1 =  (float)(*(SubValid + X + Y*(Nextno+1)));
            if (th1 > 0 ){
				th2 = (float)(th1 - *(SubDiffs + X + Y*(Nextno+1)));
				th1 = (float)(th2 / th1);
				if (th1 > 0.25){
					th2 = (float)((4.0 * th1 - 1.0) / 3.0);
					th3 = (float)(log(th2));
					vv = (float)(-0.75 * th3);
					*(SMat + X + Y*(Nextno+1)) =(float)(vv);
				}
                else
                    *(SMat + X + Y*(Nextno+1)) = 10.0;
                
                
            }
			else
                *(SMat + X + Y*(Nextno+1)) = 10.0;
			
			
            *(SMat + Y + X*(Nextno+1))= *(SMat + X + Y*(Nextno+1));
        }
    }

	

	return(1);
}

double FAR pascal QuickDist2(int lseq, int Nextno, int ub, int BPos3, int EPos3,  float *SubValid, float *SubDiffs, short int *SeqNum, long *iseqs)
{

	int A,X, Y, Z, s1,xoff,yoff, count, valid;
	int offset;
	double  count2, valid2;
	offset = lseq+1;
    //Calculate valid sites and differences in the recombinant region
    
	if (BPos3 < EPos3){
		for (A = 0; A < 3; A++){
			X = iseqs[A];
			xoff=offset*X;
			for (Y = 0; Y <= Nextno; Y++){
				if (Y != X){
					yoff=offset*Y;
					valid=0;
					count=0;
					for (Z = BPos3; Z <= EPos3; Z++){
						   s1 = SeqNum[Z + xoff];
				   
						   if (s1 == SeqNum[Z + yoff]){
							   if (s1 != 46){
									valid = valid + 1;
							   }
						   }
						   else if (s1 != 46){
									if (SeqNum[Z + yoff] != 46){
										valid = valid + 1;
										count=count+1;
									}
						   }
					}
					count2 = count;
					valid2 = valid;
					SubValid [X + Y*(Nextno+1)] = (float)(valid2);
					SubDiffs [X + Y*(Nextno+1)] = (float)(count2);
					SubValid [Y + X*(Nextno+1)] = (float)(valid2);
					SubDiffs [Y + X*(Nextno+1)] = (float)(count2);
				}
			}
		}
	}
	else{

		for (A = 0; A < 3; A++){
			X = iseqs[A];
			xoff=offset*X;
			for (Y = 0; Y <= Nextno; Y++){
				if (Y != X){
					yoff=offset*Y;
					valid=0;
					count=0;
					for (Z = BPos3; Z <= lseq; Z++){
						s1 = SeqNum[Z + xoff];
				   
						   if (s1 == SeqNum[Z + yoff]){
							   if (s1 != 46){
									valid = valid + 1;
							   }
						   }
						   else if (s1 != 46){
									if (SeqNum[Z + yoff] != 46){
										valid = valid + 1;
										count=count+1;
									}
						   }
					}
					for (Z = 1; Z <= EPos3; Z++){
						   s1 = SeqNum[Z + xoff];
				   
						   if (s1 == SeqNum[Z + yoff]){
							   if (s1 != 46){
									valid = valid + 1;
							   }
						   }
						   else if (s1 != 46){
									if (SeqNum[Z + yoff] != 46){
										valid = valid + 1;
										count=count+1;
									}
						   }
					}
					count2 = count;
					valid2 = valid;
					SubValid [X + Y*(Nextno+1)] = (float)(valid2);
					SubDiffs [X + Y*(Nextno+1)] = (float)(count2);
					SubValid [Y + X*(Nextno+1)] = (float)(valid2);
					SubDiffs [Y + X*(Nextno+1)] = (float)(count2);
				}
			}
		}


	}
	
	return(1);
}


double FAR pascal DNADIST2(double cvi, double ttratio, short int tbff,short int tmodel, double tafreq, double tcfreq,double tgfreq,double ttfreq, int numsp, int sites, short int *seqnum,int *alias, int *ally, int *weight, int *location, short int *px,short int *xx1, short int *xx2, double *prod, double *prod2, double *prod3, double *dmat)
{
  
  double fracchange,freqr, freqy,freqa, freqc, freqg, freqt, 
	  freqar, freqgr, freqcy, freqty,xv,xi,w, suma, sumc, sumg,
	  sumt, rate,numerator,epsilon, ratxv, sum, sum1, sum2, sumyr, 
	  lz, aa, bb, cc, vv, p1, p2, p3, q1, q2, q3,
	  tt, delta, slope, xx1freqa, xx1freqc, xx1freqg, xx1freqt,
	  y1, z1, rat,  z1xv, z1yy ,z1zz , th1 , th2, th3, th4;
  int endsite, gap, i, j, jj, jg, k, itemp, num1, num2, m, n, 
	  it, idx,denominator;
  short int  b, quick,  kimquick, jinneiquick, 
	  iterations,done, flip, tied, h1, h2,found, completed;
  epsilon = 0.00001;
	

  denominator=0;
  numerator = 0.0;
  for(i=1;i<=sites;i++){
	  alias[i-1]=i;
	  ally[i-1] = i;
	  weight[i-1]=0;
  }
	
  /* Shell sort of sites lexicographically - ie alphabetically */
  gap = sites / 2;
  while (gap > 0) {
    for (i = gap + 1; i <= sites; i++) {
      j = i - gap;
      flip = 1;
      while (j > 0 && flip == 1) {
        jj = *(alias + j - 1);
        jg = *(alias + j + gap - 1);
        tied = 1;
        k = 1;
        while (k <= numsp && tied == 1) {
          h1 = *(seqnum + jj + (k - 1)*(sites + 1));
		  h2 = *(seqnum + jg + (k - 1)*(sites + 1));
		  if (h1 > h2 )//(y[k - 1][jj - 1] > y[k - 1][jg - 1]);
              flip = 1;
		  else
			  flip = 0;
		  if (tied == 1 && h1 == h2)
              tied = 1;
		   else
			   tied = 0;
		  k++;
        }
        if (flip == 0)
          break;
        itemp = *(alias + j - 1);
        *(alias + j - 1) = *(alias + j + gap - 1);
        *(alias + j + gap - 1) = itemp;
        j -= gap;
      }
    }
    gap /= 2;
  }
  //return 1;
 // void sitecombine()

  /* combine sites that have identical patterns */

  i = 1;
  while (i < sites) {
    j = i + 1;
    tied = 1;
    while (j <= sites && tied == 1) {
      tied = 1;
      k = 1;
      while (k <= numsp && tied == 1) {
        h1 = *(seqnum + alias[i - 1] + (k - 1)*(sites + 1));
		h2 = *(seqnum + alias[j - 1] + (k - 1)*(sites + 1));
		if (tied == 1 && h1 == h2)
			tied = 1;
		else
			tied = 0;
		k++;
      }
      if (tied == 0)
        break;
      ally[alias[j - 1] - 1] = alias[i - 1];
      j++;
    }
    i = j;
  }

//void sitescrunch()

  /* move so one representative of each pattern of
     sites comes first */
  

  done = 0;
  i = 1;
  j = 2;
  while (done == 0) {
    if (ally[alias[i - 1] - 1] != alias[i - 1]) {
      if (j <= i)
        j = i + 1;
      if (j <= sites) {
        found = 0;
        do {
          if (ally[alias[j - 1] - 1] == alias[j - 1])
			  found = 1;
		  else
			  found = 0;
          j++;
          if (j > sites)
			  completed = 1;
		  else
			  completed = 0;
        } while (found == 0 && completed == 0);
        if (found == 1) {
          j--;
          itemp = alias[i - 1];
          alias[i - 1] = alias[j - 1];
          alias[j - 1] = itemp;
        } else
          done = 1;
      } else
        done = 1;
    }
    i++;
    if(done == 1 || i >= sites)
		done = 1;
	else
		done = 0;
  }

//void makeweights()

  /* make up weights vector to avoid duplicate computations */
  rate=1;
  endsite = 0;
  for (i = 1; i <= sites; i++) {
    if (ally[i - 1] == i)
      endsite++;
  }
  for (i = 1; i <= endsite; i++)
    location[alias[i - 1] - 1] = i;
  //sumrates = sites;
  for (i = 0; i < sites; i++)
    weight[location[ally[i] - 1] - 1] += 1;
  
  for (k = 0; k < endsite; k++){
    j = alias[k];
    for (i = 0; i < numsp; i++){
            if (*(seqnum + j + i*(sites + 1)) == 66) 
                *(px + k*numsp + i) = 0;
            else if (*(seqnum + j + i*(sites + 1)) == 68)
                *(px + k*numsp + i) = 1;
            else if (*(seqnum + j + i*(sites + 1)) == 72)
                *(px + k*numsp + i) = 2;
            else if (*(seqnum + j + i*(sites + 1)) == 85)
                *(px + k*numsp + i) = 3;
            else if (*(seqnum + j + i*(sites + 1)) == 46)
                *(px + k*numsp + i) = 4;
    }
  }

	freqa = 0.25;
	freqc = 0.25;
	freqg = 0.25;
	freqt = 0.25;
	if (tbff == 0 && tmodel == 3) {
		for (k = 1; k <= 8; k++){
			suma = 0.0;
			sumc = 0.0;
			sumg = 0.0;
			sumt = 0.0;
			for (i = 0; i < numsp; i++){
				for (j = 0; j < endsite;j++){
					w = weight[j];
					if (*(px + j*numsp + i) == 0) {
						xx1[0] = 1;
						xx1[1] = 0;
						xx1[2] = 0;
						xx1[3] = 0;
					}
					else if (*(px + j*numsp + i) == 1) {
						xx1[0] = 0;
						xx1[1] = 1;
						xx1[2] = 0;
						xx1[3] = 0;
					}
					else if (*(px + j*numsp + i) == 2) {
						xx1[0] = 0;
						xx1[1] = 0;
						xx1[2] = 1;
						xx1[3] = 0;
					}
					else if (*(px + j*numsp + i) == 3) {
						xx1[0] = 0;
						xx1[1] = 0;
						xx1[2] = 0;
						xx1[3] = 1;
					}
					else if (*(px + j*numsp + i) == 4) {
						xx1[0] = 1;
						xx1[1] = 1;
						xx1[2] = 1;
						xx1[3] = 1;
					}
					sum = freqa * xx1[0];
					sum = sum + freqc * xx1[1];
					sum = sum + freqg * xx1[2];
					sum = sum + freqt * xx1[3];
					suma = suma + w * freqa * xx1[0] / sum;
					sumc = sumc + w * freqc * xx1[1] / sum;
					sumg = sumg + w * freqg * xx1[2] / sum;
					sumt = sumt + w * freqt * xx1[3] / sum;
				}
			}
			sum = suma + sumc + sumg + sumt;
			freqa = suma / sum;
			freqc = sumc / sum;
			freqg = sumg / sum;
			freqt = sumt / sum;
		}
	}
	else {
		if (tbff == 1 && tmodel == 3){
			freqa = tafreq;
			freqc = tcfreq;
			freqg = tgfreq;
			freqt = ttfreq;
		}
	}

	/* compute or read in base frequencies */
	

	freqr = freqa + freqg;
	freqy = freqc + freqt;
	freqar = freqa / freqr;
	freqcy = freqc / freqy;
	freqgr = freqg / freqr;
	freqty = freqt / freqy;
	aa = ttratio * freqr * freqy - freqa * freqg - freqc * freqt;
	bb = freqa * freqgr + freqc * freqty;
	xi = aa / (aa + bb);
	xv = 1.0 - xi;
	ttratio = xi / xv;
	if(xi <= 0.0 && xi >= -epsilon)
		xi = 0.0;
	if (xi < 0.0){
		xi = 3.0 / 5;
		xv = 2.0 / 5;
	}
	fracchange = xi * (2 * freqa * freqgr + 2 * freqc * freqty) + xv * (1.0 - freqa * freqa - freqc * freqc - freqg * freqg - freqt * freqt);
	
  //makev
  iterations = 1000;
  ratxv = xv;
  rat = 1.0;
  /*To do bootstrap replicates I must fiddle with the weights here.
  It'll mean changing the weight values to reflect different datasets 
  - I may have to recalculate a series of weights from actual 
  bootstrapped sequences but I'd prefer to think of a way to simply 
  manipulate the weights directly.  Here is my idea: 
  If bootstrap replicates are to be used I save the weight 
  array and generate  BSnum weight arrays from it by selecting 'sites'
  number of bsweights from the original weights array.  
  The steps are as follows:
  1) Get sites number of rnd numbers between 0 and sites-1
  2) for each rnd number, say i, find the ith weight from the 
  end  (its quicker this way because the greater 
  weight values are at the end). - there are many reasonably quick
  ways to do this. Add 1 to the corresponding weigth position in the
  bootstrap weigth array 
  3) For each position from 0 to endsite calculate all bootstrap dists
  at the same time - ie this will mean making a numerator and
  denominator arrays the same size as the number of bootstrap replicates
  4) write the values to a 3D array bsrep-seq1-seq2*/
  
  for (m=1; m <= numsp - 1;m++){
	  for(n=m+1; n <= numsp; n++){
		  quick = 1;
		  vv=0;
		  if (tmodel == 0 || tmodel == 4) {
			numerator = 0;
			denominator = 0;
			for (i = 0; i < endsite; i++) {
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) =0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) = 1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  sum = 0.0;
			  sum1 = 0.0;
			  sum2 = 0.0;
			 for (b = 0; b <= 3; b++) {
				sum1 += *(xx1 + b);
				sum2 += *(xx2 + b);
				sum += *(xx1 + b) * *(xx2 + b);
			  }
			  if (quick == 1 && (sum1 == 1.0 || sum1 == 4.0) && (sum2 == 1.0 || sum2 == 4.0))
				  quick == 1;
			  else
				  quick == 0;
			  if (sum1 == 1.0 && sum2 == 1.0) {
				numerator += (*(weight + i) * sum);
				denominator += *(weight + i);
			  }
			}
		  }
  
		  

		  if (tmodel == 1 && quick == 1)
			  kimquick = 1;
		  else
			  kimquick = 0;

		  if (tmodel == 2 && quick == 1)
			  jinneiquick = 1;
		  else
			  jinneiquick = 0;
  
		  //vv = numerator / denominator;
		  //vv = -0.75 * log((4.0 * (numerator / denominator) - 1.0) / 3.0);
		  //return vv;
		  if (tmodel == 0){
			  if (denominator == 0 || numerator == 0)
						  vv = 10.0;
			  else{
				  if (numerator / denominator > 0.25){
					  th1 = (numerator / denominator);
					  th2 = (4.0 * th1 - 1.0) / 3.0;
					  th3 = log(th2);
					  vv = -0.75 * th3;
				  }
				  else
					  //if (vv > 10.0)
					  vv = 10.0;
			  }
		  }

		  else if (tmodel == 4){
			  if (denominator == 0 || numerator == 0)
						  vv = 1.0;
			  else
					  vv = 1 - (numerator / denominator);
			  
		  }
		  else if (kimquick == 1 || jinneiquick == 1) {
			num1 = 0;
			num2 = 0;
			denominator = 0;
			for (i = 0; i < endsite; i++) {
			  //memcpy(xx1, p->x[i], sizeof(sitelike));
			  //memcpy(xx2, q->x[i], sizeof(sitelike));
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) =0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) = 1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  sum = 0.0;
			  sum1 = 0.0;
			  sum2 = 0.0;
			  for (b = 0; b <= 3; b++) {
				sum1 += *(xx1 + b);
				sum2 += *(xx2 + b);
				sum += *(xx1 + b) * *(xx2 + b);
			  }
			  sumyr = (xx1[0] + xx1[2])
					* (xx2[0] + xx2[2]) +
					  (xx1[1] + xx1[3]) *
					  (xx2[1] + xx2[3]);


			  if (sum1 == 1.0 && sum2 == 1.0) {
				num1 += (int)(*(weight + i) * sum);
				num2 += (int)(*(weight + i) * (sumyr - sum));
				denominator += *(weight + i);
			  }
			}
			if (num1 == 0 || denominator == 0)
				vv =10;
			else{
				tt = 1.0 - num1 / denominator;
			//return tt;
				if (tt > 0.0) {
				  delta = 0.1;
				  tt = delta;
				  it = 0;
				  while (fabs(delta) > 0.00002 && it < iterations) {
				it++;
				if (tmodel == 1) {
				  p1 = exp(-tt);
					  p2 = exp(-xv * tt) - exp(-tt);
					  p3 = 1.0 - exp(-xv * tt);
				} else {
				  p1 = exp(-cvi * log(1 + tt / cvi));
				  p2 = exp(-cvi * log(1 + xv * tt / cvi))
						  - exp(-cvi * log(1 + tt / cvi));
				  p3 = 1.0 - exp(-cvi * log(1 + xv * tt / cvi));
				}
				q1 = p1 + p2 / 2.0 + p3 / 4.0;
				q2 = p2 / 2.0 + p3 / 4.0;
				q3 = p3 / 2.0;

				if (tmodel == 1){
					th1 = 0.5 * exp(-tt) * (num2 / q2 - num1 / q1);
					th2 = 0.25 * xv * exp(-xv * tt);
					th3 = ((denominator - num1 - num2) * 2.0 / q3 - num2 / q2 - num1 / q1);
					th4 = th2*th3;
				}
				else{
					th1 = 0.5 * (1 / (1 + tt / cvi)) * exp(-cvi * log(1 + tt / cvi)) * (num2 / q2 - num1 / q1);
					th2 = 0.25 * (xv / (1 + xv * tt / cvi)) * exp(-cvi * log(1 + xv * tt / cvi));
					th3 = ((denominator - num1 - num2) * 2 / q3 - num2 / q2 - num1 / q1);
					th4 = th2*th3;
				}
				slope  =  th1 + th4;
					//return slope;
				if (slope < 0.0)
				  delta = fabs(delta) / -2.0;
				else
				  delta = fabs(delta);
				tt += delta;
				  }
				}
				vv = fracchange * tt;

			  }
			}
		  if (tmodel == 3) {
			//prod = (double *)malloc(sites*sizeof(double));
			//prod2 = (double *)malloc(sites*sizeof(double));
			//prod3 = (double *)malloc(sites*sizeof(double));
			for (i = 0; i < endsite; i++) {
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) = 0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) =1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  xx1freqa = xx1[0] * freqa;
			  xx1freqc = xx1[1] * freqc;
			  xx1freqg = xx1[2] * freqg;
			  xx1freqt = xx1[3] * freqt;
			  sum1 = xx1freqa + xx1freqc + xx1freqg + xx1freqt;
			  sum2 = freqa * xx2[0] + freqc * xx2[1] +
					 freqg * xx2[2] + freqt * xx2[3];
			  prod[i] = sum1 * sum2;
			  prod2[i] = (xx1freqa + xx1freqg) *
						 (xx2[0] * freqar + xx2[2] * freqgr) +
				  (xx1freqc + xx1freqt) *
				  (xx2[1] * freqcy + xx2[3] * freqty);
			  prod3[i] = xx1freqa * xx2[0] + xx1freqc * xx2[1] +
				 xx1freqg * xx2[2] + xx1freqt * xx2[3];
			}
			tt = 0.1;
			delta = 0.1;
			it = 1;
			while (it < iterations && fabs(delta) > 0.00002) {
			  slope = 0.0;
			  if (tt > 0.0) {
			  lz = -tt;
			  z1 = exp(ratxv * lz);
			  y1 = 1.0 - z1;
			  z1zz = exp(rat * lz);
			  z1yy = z1 - z1zz;
			  z1xv = z1 * xv;
        
				for (i = 0; i < endsite; i++) {
				  idx = 1;
				  cc = prod[i];
				  bb = prod2[i];
				  aa = prod3[i];
			  slope += weight[i] * (z1zz * (bb - aa) +
				z1xv * (cc - bb)) /
				  (aa * z1zz + bb * z1yy + cc * y1);
				}
			  }
			  if (slope < 0.0)
			delta = fabs(delta) / -2.0;
			  else
			delta = fabs(delta);
			  tt += delta;
			  it++;
			}
			//return (double)(tt);
			vv = tt * fracchange;
			for (i = 0; i <endsite; i++){ 
			   prod[i] = 0;
			   prod2[i] = 0;
			   prod3[i] = 0;
			}
		  }
		*(dmat + m-1 + (n-1)*numsp) = vv;
		*(dmat + n-1 + (m-1)*numsp ) = vv;
	}
  }
  return(1);
}  /* sitesort */

double FAR pascal GCGetHiPVal(int lseq, int LenXoverSeq, int *FragCount, double *PVals, int *MaxY, int *MaxX, int *highenough){

	double MPV;
	int X, Y, os, os2, my, mx;

	//os = LenXoverSeq+1 ;
	os = lseq+1;
	MPV = 100;
	my=-1;
	mx=-1;
    for (X = 0; X < 6;X++){
		
		if (highenough[X] == 1){
			os2 = X*os;
			for (Y = 0; Y <= FragCount[X]; Y++){
				if (PVals[Y+os2] < MPV){
					my=Y;
					mx=X;
					MPV = PVals[Y+os2];
				}
			}
		}
	}
	*MaxX = mx;
	*MaxY = my;
	return(MPV);
}

double FAR pascal GCCalcPVal(int lseq, long LXover, long *FragMaxScore,double *PVals, long *FragCount, double *KMax,double *LL, int *highenough, double *critval){
	int X,Y,os, os2;
	double MaxScore,LenXoverSeq, THld;
	float KAScore, LKLen, warn;
	os = lseq+1;
	LenXoverSeq=(double)(LXover);
	MaxScore = 10;
	for (X = 0; X <= 5; X++){
		if (highenough[X] == 1){
		
			//10^2=100,log100 = 2; exp (10) = e^10 
			//only calculating scores over a critical maximum will massively speed this up
			if (KMax[X] > 0){
				
				//1-exp(-exp(-(ll(x)*score-log(kmax*lenxoverseq))))
				// work out which score corresponds with a particular p val
				//pval = 1-exp(-exp(-(ll(x)*score-log(kmax*lenxoverseq))))
				//1-pval = exp(-exp(-(ll(x)*score-log(kmax*lenxoverseq))))
				//-log(1-pval) = exp(-(ll(x)*score-log(kmax*lenxoverseq)))
				//-log(-log(1-pval)) = ll(x)*score-log(kmax*lenxoverseq)
				//log(kmax*lenxoverseq)-log(-log(1-pval))=ll(x)*score
				//(log(kmax*lenxoverseq)-log(-log(1-pval)))/ll(x) = score
				LKLen = (float)(log(KMax[X] * LenXoverSeq));
				for (Y = 0; Y <= FragCount[X]; Y++){
					os2 = Y + X*os;
					if (FragMaxScore[os2] > critval[X]){
						KAScore = (float)((LL[X] * FragMaxScore[os2]) - LKLen);
						if(KAScore > 0){
							if (KAScore < 32){
							
								THld = exp((double)(-KAScore));
								PVals[os2] = 1 - exp(-THld);
							}
							else{
								warn=0;
								if (KAScore > 700 ){
									
									warn = KAScore;
									KAScore = 701;
									
								}
								
								THld = exp(-KAScore);
								if (warn != 0 ){
									KAScore = (float)(warn - 700);
									THld = THld/KAScore;
								}
								PVals[os2] = THld;
							}
						}
						else
							PVals[os2] = 1;//THld;
						
						
						if (PVals[os2] < MaxScore) 
							MaxScore =PVals[os2];
					}
					else
						PVals[os2] = 1;
				}
			}
			else
				highenough[X] = 0;
		}
	}
	return (MaxScore);
}

int FAR pascal CalcKMax(short int GCMissmatchPen,int XOLen,double *MissPen, double *LL, double *KMax, int *NDiff, int *highenough){

	int X;
	double P,Q, LenXoverSeq, mP,k,ll0,Z,zm,Yy,zdel,mx, d1,d2,d3;

	LenXoverSeq = (double)(XOLen);
	for (X = 0; X < 6; X++){
		LL[X] = 0;
		if (highenough[X]==1){
			if (NDiff[X] > 0 && NDiff[X] < LenXoverSeq){
    
				P = NDiff[X] / LenXoverSeq;
				Q = 1 - P;
				
				/* If the mismatch penalty is infinite: */
				if (GCMissmatchPen == 0){
					LL[X] = -log(Q);
					KMax[X] = P;
				}
				else{
					mP = MissPen[X] * P;
					mx = MissPen[X];
					k = 0.0;
					ll0 = log(mP / Q);
					ll0= ll0 / (mx + 1);
					Z = exp(2 * ll0);
					zdel = 1;
					Yy=1;
					while (fabs(zdel) > 0.000001 || fabs(Yy) > 0.000001){
                
						zm = pow (Z, -mx);
						Yy = Q * Z + P * zm - 1;
						zdel = Yy / (Q - mP * zm / Z);
						Z = Z - zdel;

					} 
    
					LL[X] = log(Z);
					d1=exp(LL[X]);
					d1=d1-1;
					d2=-(mx + 1) * LL[X];
					d3=exp(d2);
					KMax[X] = d1 * (Q - (mP * d3));
            
				}
			}
		}
	}
	return(1);

}



double NormalZ(double Z){

	long double Y, X, w, temp, Temp2; 
	double Z_MAX, NormalZx, WinP;
	NormalZx=0.0;
	Z_MAX = 6;
    
	if (fabs(Z) < 5.9999999){
		if (Z == 0.0)
			X = 0.0;
		else{
			Y = 0.5 * fabs(Z);
			if (Y >= (Z_MAX * 0.5))
				X = 1.0;
			else if (Y < 1.0){
            
				w = Y * Y;
				X = ((((((((0.000124818987 * w - 0.001075204047) * w + 0.005198775019) * w - 0.019198292004) * w + 0.059054035642) * w - 0.151968751364) * w + 0.319152932694) * w - 0.5319230073) * w + 0.797884560593) * Y * 2.0;
            
			}
			else{
            
				Y = Y - 2.0;
				X = (((((((((((((-0.000045255659 * Y 
					+ 0.00015252929) * Y - 0.000019538132) * Y 
					- 0.000676904986) * Y + 0.001390604284) * Y 
					- 0.00079462082) * Y - 0.002034254874) * Y 
					+ 0.006549791214) * Y - 0.010557625006) * Y 
					+ 0.011630447319) * Y - 0.009279453341) * Y 
					+ 0.005353579108) * Y - 0.002141268741) * Y 
						+ 0.000535310849) * Y + 0.999936657524;
			}
           
			if ((X + 1.0) < (1.0 - X)) 
				NormalZx = ((double)(X) + 1.0);
			else
				NormalZx = (1.0 - (double)(X));
			
		}
	}
	else{
		temp = ((fabs(Z) - 5.999999) * 10);
		Temp2 = pow(1.6,temp);
		WinP = pow(10,-9);
		WinP = WinP / Temp2;
		NormalZx = WinP;
		
	}

	return (NormalZx);

}

double ChiPVal(double X){
	long double PValHolder;
	double ChiPValx;
    if (X == 0)
        ChiPValx = 1;
	else{
        
        PValHolder = (NormalZ(-sqrt(X)));
        
        if (PValHolder ==0){//< 0.0000000001){
			//if (X > 35)
			//	Y=X;
			//else
			//	X=35.1;
			PValHolder = 0.0;
            PValHolder = pow(10,-9);
			PValHolder = PValHolder / (X - 34);
		}
        
        ChiPValx = (double)(PValHolder);
    }
	return(ChiPValx);
    
}

double FAR pascal ChiPVal3(double X, int df){
	
	double  pochisq;
	int even;
	
	double a, y, s, e, c, Pi,z, bigx;
	y=0;
    
    double lnpi, ipi, dfx;
	
	//Pi = 4.0 * atan(1.0);
    Pi = 3.14159265359;
	bigx =20.0;
	lnpi = log(pow(Pi,0.5)); 
    
	ipi = 1 / log(Pi);
    
	if ((X <= 0) || (df < 1)) 
        return(1.0); 
    
    a = 0.5 * X; 
    dfx = (double)(df);
	if ((int)(dfx / 2) == dfx / 2) 
        even = 1;
    else 
        even = 0;
     
    if (df > 1)
        y = (int)(exp(-a));
    
    if (even)
        s = y;
    else 
        s = 2 * NormalZ(-sqrt(X)); 

	if (s ==0){//< 0.0000000001){
			//if (X > 35)
			//	Y=X;
			//else
			//	X=35.1;
			s = 0.0;
            s = pow(10,-9);
			s = s / (X - 34);
	}
    
    if (df > 2){
        X = 0.5 * (df - 1);
        if (even )
            z = 1; 
        else 
            z = 0.5;
         
        if (a > bigx){
            if (even)
                e = 0; 
            else 
                e = lnpi; 
            
             
            c = log(a); 
             
            while (z <= X){ 
                e = log(z) + e;
                s = s + exp(c * z - a - e);
                z++;
            }
            pochisq = s;
		}
        else {
            if (even)
                e = 1;
            else 
                e = ipi / (sqrt(a)); 
            
            c = 0; 
            while (z <= X) {
                e = e * (a / z); 
                c = c + e; 
                z ++; 
            }
            pochisq = c * y + s; 
		}
	}
    else 
        pochisq = s;
     

    
	return(pochisq);
    
}

double FAR pascal ChiPVal2(double X){
	
	long double PValHolder;
	double ChiPValx;
    if (X == 0)
        ChiPValx = 1;
	else{
        
        PValHolder = (NormalZ(-sqrt(X)));
        
        if (PValHolder ==0){//< 0.0000000001){
			//if (X > 35)
			//	Y=X;
			//else
			//	X=35.1;
			PValHolder = 0.0;
            PValHolder = pow(10,-9);
			PValHolder =PValHolder / (X - 34);
		}
        
        ChiPValx = (double)(PValHolder);
    }
	return(ChiPValx);
    
}


double CalcChiVx (double A, double B, double C, double D){
	double E, F;
	if (A + C > 0 && B + D > 0 ){
		E = A * D - B * C;
		F = (A + B + C + D) / 2;
		return (E * E * 2 / (F * (A + C) * (B + D)));
    }
                 
	else
		return(0);
	
}

double LOG10(double X){
	if (X > 0)
        return(log(X) / log(10.0));
    else
        return(log(10) / log(10.0));
    
}

int FAR pascal MakeMatrixMC(int LS, int LenXOverSeq, float *A, float *C, char *Scores, float *MatrixMC){
float B,D, CurMChi,thMChi, ax, cx;
int X,Y,Z, P, off1, off2;
off1 =LS+1;
off2 = LenXOverSeq+2;
//mmatrixmc - lenxoverseq+1,lenxoverseq+1
	for (X = 1; X<= LenXOverSeq - 3; X++){
		 for (Y = X + 3; Y <= LenXOverSeq; Y++){
				
			 if (Y == X + 3){
				   CurMChi = 0;
				   for (Z = 0; Z <3; Z++){
					   A[Z] = 0;
					   C[Z] = 0;
					   for (P = 1; P <= X; P++)
						   A[Z] = A[Z] + Scores[P + Z*off1];
					   
					   for (P = X + 1; P <= Y; P++)
						   C[Z] = C[Z] + Scores[P+ Z*off1];
					   
					   for (P = Y + 1; P <= LenXOverSeq; P++)
						   A[Z] = A[Z] + Scores[P+ Z*off1];
					   
					   ax = A[Z];
					   cx = C[Z];
					   B = (LenXOverSeq - (Y - X)) - A[Z];
					   D = (Y - X) - C[Z];
					   thMChi = (float)(CalcChiVx(ax, B, cx, D));
                   
					   if (thMChi > CurMChi)
						   CurMChi = thMChi;
				   }
			 }
			 else{
					CurMChi = 0;
					for (Z = 0; Z <3; Z++){
						A[Z] = A[Z] - Scores[Y + Z*off1];
						C[Z] = C[Z] + Scores[Y + Z*off1];
						ax = A[Z];
					    cx = C[Z];
						B = (LenXOverSeq - (Y - X)) - A[Z];
						D = (Y - X) - C[Z];
						thMChi = (float)(CalcChiVx(ax, B, cx, D));
						if (thMChi > CurMChi) 
							CurMChi = thMChi;
					}
			 }
            
				MatrixMC[X + Y*off2] = (float)(-LOG10(ChiPVal(CurMChi)));
				MatrixMC[Y + X*off2] = MatrixMC[X + Y*off2];
		 }
        
	}
return(0);

}



int FAR pascal MakeuBackups(int LSeq, int SE, int UBDaught, int Nextno, char *uMissingData, char *MissingData,char *uSeqNum, short int *SeqNum,int *uFFillCol, int *FFillCol,int *uSeqCol, int *SeqCol,unsigned char *uDaught, unsigned char *Daught, int *uTreeTrace, int *TreeTrace){
	int X, os1, os2, os3, os4, Y;
	os1 = UBDaught+1;
	os3 = LSeq+1;
	for (X = 0; X <= Nextno; X++){
			os2 = X*os1;
			os4 = X*os3;
            uTreeTrace[X] = TreeTrace[X];
            uDaught[SE + os2] = Daught[SE +os2];
            uSeqCol[X] = SeqCol[X];
            uFFillCol[X] = FFillCol[X];
            for (Y = 1; Y <= LSeq; Y++){
                uSeqNum[Y+os4] = (char)(SeqNum[Y+os4]);
                uMissingData[Y+os4] = MissingData[Y+os4];
            }

	}

	return(1);
}

int FAR pascal ReplaceuBackups(int LSeq, int SE, int UBDaught, int Nextno, char *uMissingData, char *MissingData,char *uSeqNum, short int *SeqNum,int *uFFillCol, int *FFillCol,int *uSeqCol, int *SeqCol,unsigned char *uDaught, unsigned char *Daught, int *uTreeTrace, int *TreeTrace){
	int X, os1, os2, os3, os4, Y;
	os1 = UBDaught+1;
	os3 = LSeq+1;
	for (X = 0; X <= Nextno; X++){
			os2 = X*os1;
			os4 = X*os3;
            TreeTrace[X] = uTreeTrace[X];
            Daught[SE + os2] = uDaught[SE +os2];
            SeqCol[X] = uSeqCol[X];
            FFillCol[X] = uFFillCol[X];
            for (Y = 1; Y <= LSeq; Y++){
                SeqNum[Y+os4] = (short int)(uSeqNum[Y+os4]);
                MissingData[Y+os4] = uMissingData[Y+os4];
            }

	}

	return(1);
}

int FAR pascal FindNextBranch(int TSH, float tTYF, int IStart, int TNum, int TType, int TDLenX, int *OS, char *GoOn, int *XX, float *TreeDraw){
//tdlen(3,4,2)


/*
'Treedraw(A,B,C,D,E)
    'A = treenumber (0-3)
    'B = treetype (0-4)
    'C = datatype (0=string,1 = line,2 = box)
    'D = coordinates/sequence number/colour etc - (0 = X ccord, 1=Y coord, 2 = sequence number,3 = colour;
    'E = element number


  */
	//ReDim TreeDraw(3, 4, 1, 4, (Nextno + 2) * 2)
	int startx, X, os1, os2, td, OSX;
	startx = *XX;
	OSX = *OS;
	os1 = TNum + TType*4 + 1*4*5 +4*4*5*2;
	os2 = TNum + TType*4 + 1*4*5 +3*4*5*2;
	for (X = startx; X <= TDLenX; X++){
		td = (int)(IStart + TreeDraw[os1 + X*200] * tTYF);
		if ( td >= 0 || IStart + TreeDraw[os2 + X*200] * tTYF >= 0 ){
			if (td <= TSH || IStart + TreeDraw[os2 + X*200]  * tTYF <= TSH)
            
				break;
           
			else{
				if (td > OSX){
					OSX = td;
					*GoOn = 1;
				}
			}
		}
	}
	
	*OS = OSX;

	*XX = X;
	return(1);

}




int FAR pascal MakeAnalysisListX(int UBAL, int MaxNums, int UBNTS, int SelGrpFlag,int NumSeqs, short int *TDist, unsigned char *GrpM, int *NTS, short int *AnalysisList, int *NTS2, int *SeqList)
{
	int Z, X, Y, os1, os2, os3, os4, os5, GoOn, N;
	short int TD1, TD2;
	//float rm;
	double rm, Frac, Testx, mn, nx;
	os1 = NumSeqs;
	os3 = UBNTS+1;
	os5 = UBAL+1;
	N=0;
	
	rm = (double)(RAND_MAX);
	srand(100);
	if (SelGrpFlag > 0){
        for (X = 0; X < NumSeqs - 2; X++){
            os2 = X*os1;
            for (Y = X + 1; Y < NumSeqs - 1; Y++){
                TD1 = TDist[Y + os2];
                for (Z = Y + 1; Z < NumSeqs; Z++){
                    if (GrpM[X] + GrpM[Y] + GrpM[Z] >= 2){
                        TD2 = TDist[Z + os2];
                        if (TD1 == TD2)
                           TD2 = TDist[Z + Y*os1];
                        
						os4 = TD1+TD2*os3;
						
						GoOn = 0;
                        
                        
                        
                        if (NTS[os4] <= MaxNums)
                            GoOn = 1;
                        else{
                            if (NTS2[os4] < MaxNums){
								mn=(double)(MaxNums);
								nx =  (double)(NTS[os4]);
                                Frac = mn/nx; 
                                
                                //Testx = (float)(rand());
								Testx = (double)(rand()/rm);
                                if (Frac > Testx) 
									GoOn = 1;
                            }
                            
                        }
                        if (GoOn == 1){
                            
                            NTS2[os4]  = NTS2[os4]  + 1;
                            NTS2[TD2 + TD1*os3] = NTS2[os4];
                            AnalysisList[N*3] = SeqList[X];
                            AnalysisList[1 + N*3] = SeqList[Y];
                            AnalysisList[2 + N*3] = SeqList[Z];
                            N++;
						}
                    }
                }
            }
        }
	}
    else{
        for (X = 0; X < NumSeqs - 2; X++){
            os2 = X*os1;
            for (Y = X + 1; Y < NumSeqs - 1; Y++){
                TD1 = TDist[Y + os2];
                for (Z = Y + 1; Z < NumSeqs; Z++){
                    //if (GrpM[X] + GrpM[Y] + GrpM[Z] >= 2){
                    TD2 = TDist[Z + os2];
                    if (TD1 == TD2)
                       TD2 = TDist[Z + Y*os1];
                    
					os4 = TD1+TD2*os3;
					
					GoOn = 0;
                    
                    
                    
                    if (NTS[os4] <= MaxNums)
                        GoOn = 1;
                    else{
                        if (NTS2[os4] < MaxNums){
                            mn=(double)(MaxNums);
							nx =  (double)(NTS[os4]);
                            Frac = mn/nx; 
                                
                            //Testx = (float)(rand());
							Testx = (double)(rand()/rm);
                            if (Frac > Testx) 
								GoOn = 1;
                        }
                        
                    }
                    if (GoOn == 1){
                        
                        NTS2[os4]  = NTS2[os4]  + 1;
                        NTS2[TD2 + TD1*os3] = NTS2[os4];
                        AnalysisList[N*3] = SeqList[X];
                        AnalysisList[1 + N*3] = SeqList[Y];
                        AnalysisList[2 + N*3] = SeqList[Z];
                        N++;
					}
                   // }
                }
            }
        }
    }


	return(N);
}

int FAR pascal MakeNTS(int NT, int SelGrpFlag,int NumSeqs, short int *TDist, unsigned char *GrpM, int *NTS)
{
	int X, Y, Z, os1,os2, os3;
	short int TD1, TD2;
	os1=NumSeqs;
	os3 = NT+1;
	if (SelGrpFlag){
        
        for (X = 0; X < NumSeqs - 2; X++){
			os2 = X*os1;
            for (Y = X + 1; Y < NumSeqs - 1; Y++){
                TD1 = TDist[Y + X*os1];
                for (Z = Y + 1; Z < NumSeqs; Z++){
                    if (GrpM[X] + GrpM[Y] + GrpM[Z] >= 2){
                        TD2 = TDist[Z + os2];
                        if (TD1 == TD2)
                           TD2 = TDist[Z + Y*os1];
                        
                        NTS[TD1 + TD2*os3] = NTS[TD1 + TD2*os3] + 1;
                        NTS[TD2 + TD1*os3] = NTS[TD1 + TD2*os3];
                    }
                }
            }
        }
	}
    else{
        for (X = 0; X < NumSeqs - 2; X++){
			os2 = X*os1;
            for (Y = X + 1; Y < NumSeqs - 1; Y++){
                TD1 = TDist[Y + X*os1];
                for (Z = Y + 1; Z < NumSeqs; Z++){
                    
                    TD2 = TDist[Z + os2];
                    if (TD1 == TD2)
                       TD2 = TDist[Z + Y*os1];
                    
                    NTS[TD1 + TD2*os3] = NTS[TD1 + TD2*os3] + 1;
                    NTS[TD2 + TD1*os3] = NTS[TD1 + TD2*os3];
                   
                }
            }
        }
    
    
    }



	return(1);
}

int FAR pascal DestroyPeaks(int MaxY, int LenXoverSeq, int LS, int LO, int RO, double *SmoothChi, double *ChiVals){
	int X, SLO, Circuit1, EraseAll, off1;
	off1 = MaxY*(LS+1);
	if (LO == 0) 
		LO = 1;
    if (RO == 0) 
		RO = 1;

    X=0;
	SLO = LO;
    Circuit1 = 0;
	EraseAll = 0;
	if (LenXoverSeq > 5){
		while (SmoothChi[LO + off1] >= SmoothChi[LO + off1 + 1] || SmoothChi[LO + off1] >= SmoothChi[LO + off1 + 2]){
			LO--;
            if (LO == RO){ 
				EraseAll = 1;
				break;
			}
			if (LO < 1){
				Circuit1++;
				if (Circuit1 == 2){
					EraseAll = 1;
                    break;
				}
                LO = LenXoverSeq +LO;
			}
            if (LO == RO){ 
				EraseAll = 1;
				break;
			}
            if (LO > LenXoverSeq - 2) 
				LO = LenXoverSeq - 2;
		}
        if (LO == RO) 
			EraseAll = 1;
        
		if (EraseAll == 0){
			Circuit1 = 0;
            while ((SmoothChi[LO + off1] <= SmoothChi[LO + off1 + 1] || SmoothChi[LO + off1] <= SmoothChi[LO + off1 + 2]) && SmoothChi[LO + off1]>1){
				LO--;
                if (LO == RO){ 
					EraseAll = 1;
					break;
				}
                if (LO < 1){
					Circuit1++;
					if (Circuit1 == 2){
						EraseAll = 1;
						break;
					}
					LO = LenXoverSeq +LO;
				}
				if (LO == RO){ 
					EraseAll = 1;
					break;
				}
                        
			}
		}
        if (LO == RO) 
			EraseAll = 1;

		if (EraseAll == 0){
			if (RO <= 0)
				RO = LenXoverSeq + RO;
            while (X==0){
					RO++;
                    if (LO == RO || RO == SLO){
						EraseAll = 1; 
						break;
					}
					if (RO > LenXoverSeq - 1){
						RO = 1;
                        if (RO > LO){
							EraseAll = 1;
                            break;
						}
					}
                            
                    if (LO == RO || RO == SLO){
						EraseAll = 1; 
						break;
					}
					if (SmoothChi[RO + off1] < SmoothChi[RO +off1 - 1])
						break;
                        
			}
		}
		if (EraseAll == 0){
			while (X==0){
                        RO++;
                        if (LO == RO || RO == SLO){
							EraseAll = 1; 
							break;
						}
                        if (RO > LenXoverSeq - 1){
							RO = 1;
							if (RO > LO){
								EraseAll = 1;
								break;
							}
						}
						if (SmoothChi[RO + off1] == 0 || SmoothChi[RO + off1] > SmoothChi[RO +off1 - 1] )
							break;
                        if (LO == RO || RO == SLO){
							EraseAll = 1; 
							break;
						}
			
			}
		}
	}
	else 
		EraseAll = 1;
	           
	if (EraseAll == 1){
		for (X = 0; X <= LenXoverSeq; X++)
			ChiVals[X + off1] = 0;
	}
	else{
		if (LO < RO){
			for (X = LO; X<= RO; X++)
				ChiVals[X + off1] = 0;
		}
		else{
			for (X = 0; X<= RO; X++)
				ChiVals[X + off1] = 0;
			for (X = LO; X<= LenXoverSeq; X++)
				ChiVals[X + off1] = 0;
		}
	}
	return(1);
}

int FAR pascal FindSide(int TopL, int TopR, int LS, int LO, int RO, int WinWin, int LenXoverSeq, int MaxY, char *Scores, double *HiLeft, double *HiRight){
	int e, X, off1, A, C, B, D;
	double hMChi, E;
	//Calc E for left
    e = 0;
	off1 = MaxY*(LS+1);
	for (X = LO - WinWin; X < LO; X++){
		if (X < 1)
			e = e + Scores[LenXoverSeq + X + off1];
        else if (X > LenXoverSeq)
			e = e + Scores[X - LenXoverSeq + off1];
        else
            e = e + Scores[X + off1];
	}
                
    A = TopL;
    C = e;
    B = WinWin - A;
    D = WinWin - C;
    if ((A + C > 0) && (B + D > 0)){
		E = A*D - B*C;
		hMChi = E*E*2/(WinWin*(A + C)*(B + D));
		/*hMChi = (A * D - B * C);
		hMChi =	hMChi * hMChi;
		hMChi = hMChi*WinWin*2;
		hMChi = hMChi / (A + B);
		hMChi = hMChi / (C + D);
		hMChi = hMChi / (A + C);
		hMChi = hMChi / (B + D);*/
	}
	else
		hMChi = 0;
                
    *HiLeft = hMChi;
                
                
    //Calc E for right
    e = 0;
    for (X = RO+1; X <= RO + WinWin; X++){
		if (X < 1)
			e = e + Scores[LenXoverSeq + X + off1];
        else if (X > LenXoverSeq)
			e = e + Scores[X - LenXoverSeq + off1];
        else
            e = e + Scores[X + off1];
	}
    
	A = TopR;
    C = e;
    B = WinWin - A;
    D = WinWin - C;
    if ((A + C > 0) && (B + D > 0)){
		E = A*D - B*C;
		hMChi = E*E*2/(WinWin*(A + C)*(B + D));
	}
	else
		hMChi = 0;
                
    *HiRight = hMChi;

	return(1);
}

int FAR pascal GrowMChiWin(int LO, int RO, int LenXoverSeq, int HWindowWidth, int TWin, int MaxY, int LS, int A, int C, int MaxFailCount, double *MPV, int *WinWin, double *MChi, int *TopL, int *TopR, int *TopLO, int *TopRO, char *Scores){
	//scores LS,2 
	int off1, FailCount, B, D;
	double hMChi, tpv, lxdh,lx,h ,t, E;
	
	off1 = MaxY*(LS+1);
	FailCount = 0;
	lx = LenXoverSeq;
	h = HWindowWidth;
	lxdh = lx/h;
	//TW2 = TWin*2;
	while (FailCount <= MaxFailCount){
            A = A + Scores[LO + off1];
            C = C + Scores[RO + off1];
            B = TWin - A;
            D = TWin - C;
            if (A + C > 0 && B + D > 0){
				E = A*D - B*C;
				hMChi = E*E*2/(TWin*(A + C)*(B + D));
				if (hMChi < 0)
					hMChi = fabs(hMChi);
                if (TWin < HWindowWidth){
                    t = (double)(TWin);
					h = (double)(LenXoverSeq);
					tpv = ChiPVal(hMChi) * (h / t);
				}
                else{
					t = (double)(TWin);
					h = (double)(HWindowWidth);
                    tpv = ChiPVal(hMChi) * lxdh;
                }
                if (tpv <= *MPV){
                    *TopLO = LO;
                    *TopRO = RO;
                    *MChi = hMChi;
                    *WinWin = TWin;
                    *MPV = tpv;
                    FailCount = 0;
                    *TopL = A;
                    *TopR = C;
				}
				else{
					if (TWin == HWindowWidth && *TopL == 0 && *TopR == 0){
                        *TopL = A;
                        *TopR = C;
                    }
                    FailCount++;
                    if (FailCount > MaxFailCount)
                        return(1);
                }
			}
            else{
                FailCount++;
                if (FailCount > MaxFailCount)
                    return(1);
                hMChi = 0;
            }
            RO++;
            LO--;
            if (LO < 1)
				LO = LenXoverSeq;
            if (RO > LenXoverSeq)
				RO = RO - LenXoverSeq;
            TWin++;
	}
	return(1);
}

int FAR pascal CMaxD(int Seq1, int Seq2, int Seq3, int SBP, int EBP, int Nextno, int SLen, short int *SeqNum, short int *SeqnumX, unsigned char *Identical, char *NucMat, char *IncSeq2, char *IncSeq, float *E, float *d, float *VScoreMat, float *AvDist, int *TotCount){
	int X,Y,SBPM,EBPP, off1, off2, Se1, Se2, Se3, Se4, S1, S2, S3, S4, SeX1, SeX2, SeX3, SeX4,v1;
	char GoOn;
	float FS, Dist1, Dist2, Dist3, Dist4, Dist;
	SBPM = SBP - 1;
	EBPP = EBP + 1;
	off2 = SLen+1;
	for (X = 0; X <=Nextno; X++){
		off1 = X*off2;
		for (Y = 0; Y <= SLen; Y++){
			SeqnumX[Y + off1] = NucMat[SeqNum[Y+off1]];
		}
	}
//VScoreMat(4, 4, 4, 4, 2)
	for (Se1 = 0; Se1 <= Nextno - 3; Se1++){
		if (IncSeq2[Se1] == 1){
			for (Se2 = Se1 + 1; Se2 <= Nextno - 2; Se2++){
				if (IncSeq2[Se2] == 1){
					for (Se3 = Se2 + 1; Se3 <= Nextno - 1; Se3++){
						if (IncSeq2[Se3] == 1){
							for (Se4 = Se3 + 1; Se4 <= Nextno; Se4++){
								if (IncSeq2[Se4] == 1){
									GoOn = IncSeq[Se1] + IncSeq[Se2] + IncSeq[Se3] + IncSeq[Se4];
									
									if (GoOn > 0){// Then 'Seq1 = Se1 Or Seq2 = Se1 Or Seq3 = Se1 Or Seq1 = Se2 Or Seq2 = Se2 Or Seq3 = Se2 Or Seq1 = Se3 Or Seq2 = Se3 Or Seq3 = Se3 Or Seq1 = Se4 Or Seq2 = Se4 Or Seq3 = Se4 Then
										
										E[0] = 0;
										E[1] = 0;
										E[2] = 0;
										d[0] = 0;
										d[1] = 0;
										d[2] = 0;
										SeX1 = Se1*off2;
										SeX2 = Se2*off2;
										SeX3 = Se3*off2;
										SeX4 = Se4*off2;
										if (SBP < EBP){
                        
											
											for (X = 1; X <= SBPM; X++){
												if (Identical[X] == 0){
													S1 = SeqnumX[X + SeX1]; //'85,72,66,68
													S2 = SeqnumX[X + SeX2];
													S3 = SeqnumX[X + SeX3];
                                
													if (S1 != S2 || S1 != S3){
														S4 = SeqnumX[X + SeX4];
														


														v1 = S1 + S2*5 + S3*25 + S4*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
												}
											}
											for (X = EBPP; X <= SLen; X++){
												if (Identical[X] == 0){
													S1 = SeqnumX[X + SeX1]; //'85,72,66,68
													S2 = SeqnumX[X + SeX2];
													S3 = SeqnumX[X + SeX3];
                                
													if (S1 != S2 || S1 != S3){
														S4 = SeqnumX[X + SeX4];
														v1 = S1 + S2*5 + S3*25 + S4*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
												}
											}
											FS = E[0] + E[1] + E[2];
											if (FS > 0){ 
												E[0] = E[0] / FS;
												E[1] = E[1] / FS;
												E[2] = E[2] / FS;
											
											
											
											
												for (X = SBP; X <= EBP; X++){
													if (Identical[X] == 0){
														S1 = SeqnumX[X + SeX1]; //'85,72,66,68
														S2 = SeqnumX[X + SeX2];
														S3 = SeqnumX[X + SeX3];
                                
														if (S1 != S2 || S1 != S3){
															S4 = SeqnumX[X + SeX4];
															v1 = S1 + S2*5 + S3*25 + S4*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
													}
												}
												
												FS = d[0] + d[1] + d[2];
												if (FS > 0){ 
													d[0] = d[0] / FS;
													d[1] = d[1] / FS;
													d[2] = d[2] / FS;
												}
												else{

													d[0] = double(1 / 3);
													d[1] = double(1 / 3);
													d[2] = double(1 / 3);
													E[0] = double(1 / 3);
													E[1] = double(1 / 3);
													E[2] = double(1 / 3);
												}
											}
											else{

												E[0] = double(1 / 3);
												E[1] = double(1 / 3);
												E[2] = double(1 / 3);
												d[0] = double(1 / 3);
												d[1] = double(1 / 3);
												d[2] = double(1 / 3);
											}
										}
										else{
											
                        
											for (X = EBPP; X<= SBPM; X++){
												if (Identical[X] == 0){
													S1 = SeqnumX[X + SeX1]; //'85,72,66,68
													S2 = SeqnumX[X + SeX2];
													S3 = SeqnumX[X + SeX3];
                                
													if (S1 != S2 || S1 != S3){
														S4 = SeqnumX[X + SeX4];
														v1 = S1 + S2*5 + S3*25 + S4*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
												}
											}
											FS = E[0] + E[1] + E[2];
											if (FS > 0){ 
												E[0] = E[0] / FS;
												E[1] = E[1] / FS;
												E[2] = E[2] / FS;
											
                                                
											
												for (X = 1; X <= EBP; X++){
													if (Identical[X] == 0){
														S1 = SeqnumX[X + SeX1]; //'85,72,66,68
														S2 = SeqnumX[X + SeX2];
														S3 = SeqnumX[X + SeX3];
                                
														if (S1 != S2 || S1 != S3){
															S4 = SeqnumX[X + SeX4];
															v1 = S1 + S2*5 + S3*25 + S4*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
													}
												}
												for (X = SBP; X <= SLen; X++){
													if (Identical[X] == 0){
														S1 = SeqnumX[X + SeX1]; //'85,72,66,68
														S2 = SeqnumX[X + SeX2];
														S3 = SeqnumX[X + SeX3];
                                
														if (S1 != S2 || S1 != S3){
															S4 = SeqnumX[X + SeX4];
															v1 = S1 + S2*5 + S3*25 + S4*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
													}
												}
												FS = d[0] + d[1] + d[2];
												if (FS > 0){ 
													d[0] = d[0] / FS;
													d[1] = d[1] / FS;
													d[2] = d[2] / FS;
												}
												else{

													d[0] = double(1 / 3);
													d[1] = double(1 / 3);
													d[2] = double(1 / 3);
													E[0] = double(1 / 3);
													E[1] = double(1 / 3);
													E[2] = double(1 / 3);
												}
											}
											else{

												E[0] = double(1 / 3);
												E[1] = double(1 / 3);
												E[2] = double(1 / 3);
												d[0] = double(1 / 3);
												d[1] = double(1 / 3);
												d[2] = double(1 / 3);
											}
										}
										//it doesn't matter what the actual distance is - the relative distance is what matters. or does it?
										if (d[0] != double(1 / 3) || d[1] != double(1 / 3)){
											Dist1 = (d[0] - E[0]);
											Dist1 = Dist1*Dist1;// ^ 2
											Dist2 = (d[1] - E[1]);
											Dist2 = Dist2*Dist2;
											Dist3 = (d[2] - E[2]);
											Dist3 = Dist3*Dist3;
											Dist4 = Dist1+Dist2+Dist3;
											Dist = (float)(pow(Dist4,0.5));

											if (Se1 == Seq1 || Se2 == Seq1 || Se3 == Seq1 || Se4 == Seq1){
												AvDist[0] = AvDist[0] + Dist;
												TotCount[0] = TotCount[0] + 1;
												
											}
											if (Se1 == Seq2 || Se2 == Seq2 || Se3 == Seq2 || Se4 == Seq2){
												AvDist[1] = AvDist[1] + Dist;
												TotCount[1] = TotCount[1] + 1;
												
											}
											if (Se1 == Seq3 || Se2 == Seq3 || Se3 == Seq3 || Se4 == Seq3){
												AvDist[2] = AvDist[2] + Dist;
												TotCount[2] = TotCount[2] + 1;
												
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}



	return(1);
}



int FAR pascal CMaxD3(int incnum, int SBP, int EBP, int Nextno, int SLen, short int *SeqNum, short int *SeqnumX, int *IdenticalR, int *IdenticalF, char *NucMat,int *IncSeq3, char *IncSeq2, int *ISeqs, float *E, float *d, float *VScoreMat, float *AvDist, int *TotCount){
	int  A, Seq1, Seq2, Seq3, Se1, Se2, Se3, Se4,osx, X,Y,SBPM,EBPP,  SeX1, SeX2, SeX3, SeX4,v1;
	unsigned int off1, off2, S1, S2, S3;
	//int A, B, C, D;
	
	float FS, Dist1, Dist2, Dist3, Dist4, Dist,d3;
	SBPM = IdenticalF[SBP - 1];
	EBPP = IdenticalF[EBP + 1];
	SBP = IdenticalF[SBP];
	EBP = IdenticalF[EBP];
	d3 = (float)(1/3);
	off2 = SLen+1;
	Seq1 = ISeqs[0];
	Seq2 = ISeqs[1];
	Seq3 = ISeqs[2];
	for (X = 0; X <=Nextno; X++){
		off1 = X*off2;
		for (Y = 0; Y <= SLen; Y++){
			SeqnumX[Y + off1] = NucMat[SeqNum[Y+off1]];
		}
	}
//VScoreMat(4, 4, 4, 4, 2)
//	for (A = 0; A <= incnum-3; A++){
    for (A = 0; A <= 2 ; A++){
		Se1 = ISeqs[A];
//		Se1 = IncSeq3[A];
//		if (IncSeq2[Se1] == 1){
//			for (B = A+1; B <= incnum-2; B++){
			IncSeq2[Se1] == 0;
			SeX1 = Se1*off2;
			for (Se2 = 0; Se2 <= Nextno - 2; Se2++){
//				Se2 = IncSeq3[B];
				if (IncSeq2[Se2] == 1){
//					for (C = B+1; C <= incnum-1; C++){
					//go1 = IncSeq[Se1] + IncSeq[Se2];
					SeX2 = Se2*off2;
					for (Se3 = Se2 + 1; Se3 <= Nextno - 1; Se3++){
//						Se3 = IncSeq3[C];
						if (IncSeq2[Se3] == 1){
//							for (D = C+1; D <= incnum; D++){
							//go = go1 + IncSeq[Se3];
							SeX3 = Se3*off2;
							for (Se4 = Se3 + 1; Se4 <= Nextno; Se4++){
//								Se4 = IncSeq3[D];
								if (IncSeq2[Se4] == 1){
//									GoOn =  go + IncSeq[Se4];
									
//									if (GoOn > 0){// Then 'Seq1 = Se1 Or Seq2 = Se1 Or Seq3 = Se1 Or Seq1 = Se2 Or Seq2 = Se2 Or Seq3 = Se2 Or Seq1 = Se3 Or Seq2 = Se3 Or Seq3 = Se3 Or Seq1 = Se4 Or Seq2 = Se4 Or Seq3 = Se4 Then
										
										E[0] = 0;
										E[1] = 0;
										E[2] = 0;
										d[0] = 0;
										d[1] = 0;
										d[2] = 0;
										
										
										
										SeX4 = Se4*off2;
										if (SBP < EBP){
                        
											
											for (X = 1; X <= SBPM; X++){
												//if (Identical[X] == 0){
													osx = IdenticalR[X];
													S1 = SeqnumX[osx + SeX1]; //'85,72,66,68
													S2 = SeqnumX[osx + SeX2];
													S3 = SeqnumX[osx + SeX3];
                                
													if (S1 != S2 ){
														//S4 = SeqnumX[osx + SeX4];
														

														//maybe use a lookup table for these
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
													else if (S1 != S3){
														
													//	S4 = SeqnumX[osx + SeX4];
														


														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
												//}
											}
											for (X = EBPP; X <= IdenticalF[SLen]; X++){
												//if (Identical[X] == 0){
													osx = IdenticalR[X];
													S1 = SeqnumX[osx + SeX1]; //'85,72,66,68
													S2 = SeqnumX[osx + SeX2];
													S3 = SeqnumX[osx + SeX3];
                                
													if (S1 != S2 ){
														//S4 = SeqnumX[osx + SeX4];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
													else if ( S1 != S3){
														//S4 = SeqnumX[osx + SeX4];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
												//}
											}
											FS = E[0] + E[1] + E[2];
											if (FS > 0){ 
												E[0] = E[0] / FS;
												E[1] = E[1] / FS;
												E[2] = E[2] / FS;
											
											
											
											
												for (X = SBP; X <= EBP; X++){
													//if (Identical[X] == 0){
														osx = IdenticalR[X];
														S1 = SeqnumX[osx + SeX1]; //'85,72,66,68
														S2 = SeqnumX[osx + SeX2];
														S3 = SeqnumX[osx + SeX3];
                                
														if (S1 != S2 ){
															//S4 = SeqnumX[osx + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
														else if ( S1 != S3){
															//S4 = SeqnumX[osx + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
													//}
												}
												
												FS = d[0] + d[1] + d[2];
												if (FS > 0){ 
													d[0] = d[0] / FS;
													d[1] = d[1] / FS;
													d[2] = d[2] / FS;
												}
												else{

													d[0] = d3;
													d[1] = d3;
													d[2] = d3;
													E[0] = d3;
													E[1] = d3;
													E[2] = d3;
												}
											}
											else{

												E[0] = d3;
												E[1] = d3;
												E[2] = d3;
												d[0] = d3;
												d[1] = d3;
												d[2] = d3;
											}
										}
										else{
											
                        
											for (X = EBPP; X<= SBPM; X++){
												//if (Identical[X] == 0){
													osx = IdenticalR[X];
													S1 = SeqnumX[osx + SeX1]; //'85,72,66,68
													S2 = SeqnumX[osx + SeX2];
													S3 = SeqnumX[osx + SeX3];
                                
													if (S1 != S2 || S1 != S3){
														//S4 = SeqnumX[osx + SeX4];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
												//}
											}
											FS = E[0] + E[1] + E[2];
											if (FS > 0){ 
												E[0] = E[0] / FS;
												E[1] = E[1] / FS;
												E[2] = E[2] / FS;
											
                                                
											
												for (X = 1; X <= EBP; X++){
													//if (Identical[X] == 0){
														osx = IdenticalR[X];
														S1 = SeqnumX[osx  + SeX1]; //'85,72,66,68
														S2 = SeqnumX[osx  + SeX2];
														S3 = SeqnumX[osx  + SeX3];
                                
														if (S1 != S2 ){
														//	S4 = SeqnumX[osx  + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4] *125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
														else if (S1 != S3){
															//S4 = SeqnumX[osx  + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
													//}
												}
												for (X = SBP; X <= IdenticalF[SLen]; X++){
													//if (Identical[X] == 0){
														osx = IdenticalR[X];
														S1 = SeqnumX[osx  + SeX1]; //'85,72,66,68
														S2 = SeqnumX[osx  + SeX2];
														S3 = SeqnumX[osx  + SeX3];
                                
														if (S1 != S2 ){
															//S4 = SeqnumX[osx  + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
														else if ( S1 != S3){
															//S4 = SeqnumX[osx  + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
													//}
												}
												FS = d[0] + d[1] + d[2];
												if (FS > 0){ 
													d[0] = d[0] / FS;
													d[1] = d[1] / FS;
													d[2] = d[2] / FS;
												}
												else{

													d[0] = d3;
													d[1] = d3;
													d[2] = d3;
													E[0] = d3;
													E[1] = d3;
													E[2] = d3;
												}
											}
											else{

												E[0] = d3;
												E[1] = d3;
												E[2] = d3;
												d[0] = d3;
												d[1] = d3;
												d[2] = d3;
											}
										}
										//it doesn't matter what the actual distance is - the relative distance is what matters. or does it?
										if (d[0] != d3 || d[1] != d3){
											Dist1 = (d[0] - E[0]);
											Dist1 = Dist1*Dist1;// ^ 2
											Dist2 = (d[1] - E[1]);
											Dist2 = Dist2*Dist2;
											Dist3 = (d[2] - E[2]);
											Dist3 = Dist3*Dist3;
											Dist4 = Dist1+Dist2+Dist3;
											Dist = (float)(pow(Dist4,0.5));

											if (Se1 == Seq1 || Se2 == Seq1 || Se3 == Seq1 || Se4 == Seq1){
												AvDist[0] = AvDist[0] + Dist;
												TotCount[0] = TotCount[0] + 1;
												
											}
											if (Se1 == Seq2 || Se2 == Seq2 || Se3 == Seq2 || Se4 == Seq2){
												AvDist[1] = AvDist[1] + Dist;
												TotCount[1] = TotCount[1] + 1;
												
											}
											if (Se1 == Seq3 || Se2 == Seq3 || Se3 == Seq3 || Se4 == Seq3){
												AvDist[2] = AvDist[2] + Dist;
												TotCount[2] = TotCount[2] + 1;
												
											}
										}
									//}
								}
							}
						}
					}
				}
			}
			IncSeq2[Se1] == 1;
		//}
	}



	return(1);
}

int FAR pascal CMaxD2(int incnum, int Seq1, int Seq2, int Seq3, int SBP, int EBP, int Nextno, int SLen, short int *SeqNum, short int *SeqnumX, int *IdenticalR, int *IdenticalF, unsigned char *NucMat,int *IncSeq3, unsigned char *IncSeq2, unsigned char *IncSeq, float *E, float *d, float *VScoreMat, float *AvDist, int *TotCount){
	int  Se1, Se2, Se3, Se4,osx, X,Y,SBPM,EBPP;
	unsigned int v1, off1, off2, S1, S2, S3, SeX1, SeX2, SeX3, SeX4;
	//int A, B, C, D;
	char GoOn, go, go1;
	float FS, Dist1, Dist2, Dist3, Dist4, Dist,d3;
	
	if (SBP > 0)
		SBPM = IdenticalF[SBP - 1];
	else
		SBPM = IdenticalF[SBP];		


	if  (EBP < SLen)
		EBPP = IdenticalF[EBP + 1];
	else
		EBPP = IdenticalF[EBP];


	SBP = IdenticalF[SBP];
	EBP = IdenticalF[EBP];
	d3 = (float)(1/3);
	off2 = SLen+1;
	for (X = 0; X <=Nextno; X++){
		off1 = X*off2;
		for (Y = 0; Y <= SLen; Y++){
			SeqnumX[Y + off1] = NucMat[SeqNum[Y+off1]];
		}
	}
//VScoreMat(4, 4, 4, 4, 2)
//	for (A = 0; A <= incnum-3; A++){
    for (Se1 = 0; Se1 <= Nextno - 3; Se1++){
//		Se1 = IncSeq3[A];
		if (IncSeq2[Se1] == 1){
//			for (B = A+1; B <= incnum-2; B++){
			SeX1 = Se1*off2;
			for (Se2 = Se1 + 1; Se2 <= Nextno - 2; Se2++){
//				Se2 = IncSeq3[B];
				if (IncSeq2[Se2] == 1){
//					for (C = B+1; C <= incnum-1; C++){
					go1 = IncSeq[Se1] + IncSeq[Se2];
					SeX2 = Se2*off2;
					for (Se3 = Se2 + 1; Se3 <= Nextno - 1; Se3++){
//						Se3 = IncSeq3[C];
						if (IncSeq2[Se3] == 1){
//							for (D = C+1; D <= incnum; D++){
							go = go1 + IncSeq[Se3];
							SeX3 = Se3*off2;
							for (Se4 = Se3 + 1; Se4 <= Nextno; Se4++){
//								Se4 = IncSeq3[D];
								if (IncSeq2[Se4] == 1){
									GoOn =  go + IncSeq[Se4];
									
									if (GoOn > 0){// Then 'Seq1 = Se1 Or Seq2 = Se1 Or Seq3 = Se1 Or Seq1 = Se2 Or Seq2 = Se2 Or Seq3 = Se2 Or Seq1 = Se3 Or Seq2 = Se3 Or Seq3 = Se3 Or Seq1 = Se4 Or Seq2 = Se4 Or Seq3 = Se4 Then
										
										E[0] = 0;
										E[1] = 0;
										E[2] = 0;
										d[0] = 0;
										d[1] = 0;
										d[2] = 0;
										
										
										SeX4 = Se4*off2;
										if (SBP < EBP){
                        
											
											for (X = 1; X <= SBPM; X++){
												//if (Identical[X] == 0){
													osx = IdenticalR[X];
													S1 = SeqnumX[osx + SeX1]; //'85,72,66,68
													S2 = SeqnumX[osx + SeX2];
													S3 = SeqnumX[osx + SeX3];
													

													v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
													E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
													E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
													E[2] = E[2] + VScoreMat[v1 + 1250];
/*
													if (S1 != S2 ){
														//S4 = SeqnumX[osx + SeX4];
														

														//maybe use a lookup table for these
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
													else if (S1 != S3){
														
													//	S4 = SeqnumX[osx + SeX4];
														


														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
												*/
												//}
											}
											for (X = EBPP; X <= IdenticalF[SLen]; X++){
												//if (Identical[X] == 0){
													osx = IdenticalR[X];
													S1 = SeqnumX[osx + SeX1]; //'85,72,66,68
													S2 = SeqnumX[osx + SeX2];
													S3 = SeqnumX[osx + SeX3];
													

													v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
													E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
													E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
													E[2] = E[2] + VScoreMat[v1 + 1250];

												/*	if (S1 != S2 ){
														//S4 = SeqnumX[osx + SeX4];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
													else if ( S1 != S3){
														//S4 = SeqnumX[osx + SeX4];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}
													*/
												//}
											}
											FS = E[0] + E[1] + E[2];
											if (FS > 0){ 
												E[0] = E[0] / FS;
												E[1] = E[1] / FS;
												E[2] = E[2] / FS;
											
											
											
											
												for (X = SBP; X <= EBP; X++){
													//if (Identical[X] == 0){
														osx = IdenticalR[X];
														S1 = SeqnumX[osx + SeX1]; //'85,72,66,68
														S2 = SeqnumX[osx + SeX2];
														S3 = SeqnumX[osx + SeX3];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
																
														d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														d[2] = d[2] + VScoreMat[v1 + 1250];
													/*	if (S1 != S2 ){
															//S4 = SeqnumX[osx + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
														else if ( S1 != S3){
															//S4 = SeqnumX[osx + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
													//}*/
												}
												
												FS = d[0] + d[1] + d[2];
												if (FS > 0){ 
													d[0] = d[0] / FS;
													d[1] = d[1] / FS;
													d[2] = d[2] / FS;
												}
												else{

													d[0] = d3;
													d[1] = d3;
													d[2] = d3;
													E[0] = d3;
													E[1] = d3;
													E[2] = d3;
												}
											}
											else{

												E[0] = d3;
												E[1] = d3;
												E[2] = d3;
												d[0] = d3;
												d[1] = d3;
												d[2] = d3;
											}
										}
										else{
											
                        
											for (X = EBPP; X<= SBPM; X++){
												//if (Identical[X] == 0){
													osx = IdenticalR[X];
													S1 = SeqnumX[osx + SeX1]; //'85,72,66,68
													S2 = SeqnumX[osx + SeX2];
													S3 = SeqnumX[osx + SeX3];
													v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
														
													E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
													E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
													E[2] = E[2] + VScoreMat[v1 + 1250];

														/*
													if (S1 != S2 || S1 != S3){
														//S4 = SeqnumX[osx + SeX4];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx + SeX4]*125;
															
														E[0] = E[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														E[1] = E[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														E[2] = E[2] + VScoreMat[v1 + 1250];
														
													}*/
												//}
											}
											FS = E[0] + E[1] + E[2];
											if (FS > 0){ 
												E[0] = E[0] / FS;
												E[1] = E[1] / FS;
												E[2] = E[2] / FS;
											
                                                
											
												for (X = 1; X <= EBP; X++){
													//if (Identical[X] == 0){
														osx = IdenticalR[X];
														S1 = SeqnumX[osx  + SeX1]; //'85,72,66,68
														S2 = SeqnumX[osx  + SeX2];
														S3 = SeqnumX[osx  + SeX3];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4] *125;
														d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														d[2] = d[2] + VScoreMat[v1 + 1250];
														/*if (S1 != S2 ){
														//	S4 = SeqnumX[osx  + SeX4];
															
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
														else if (S1 != S3){
															//S4 = SeqnumX[osx  + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}*/
													//}
												}
												for (X = SBP; X <= IdenticalF[SLen]; X++){
													//if (Identical[X] == 0){
														osx = IdenticalR[X];
														S1 = SeqnumX[osx  + SeX1]; //'85,72,66,68
														S2 = SeqnumX[osx  + SeX2];
														S3 = SeqnumX[osx  + SeX3];
														v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4]*125;
															
														d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
														d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
														d[2] = d[2] + VScoreMat[v1 + 1250];
													/*	if (S1 != S2 ){
															//S4 = SeqnumX[osx  + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}
														else if ( S1 != S3){
															//S4 = SeqnumX[osx  + SeX4];
															v1 = S1 + S2*5 + S3*25 + SeqnumX[osx  + SeX4]*125;
																
															d[0] = d[0] + VScoreMat[v1];  //1=2:3=4 = 1;1=2:3<>4 = 0.5;1<>2:3=4 = 0.5
															d[1] = d[1] + VScoreMat[v1 + 625]; //1=3:2=4 = 1; 1=3:2<>4 = 0.5
															d[2] = d[2] + VScoreMat[v1 + 1250];
															
														}*/
													//}
												}
												FS = d[0] + d[1] + d[2];
												if (FS > 0){ 
													d[0] = d[0] / FS;
													d[1] = d[1] / FS;
													d[2] = d[2] / FS;
												}
												else{

													d[0] = d3;
													d[1] = d3;
													d[2] = d3;
													E[0] = d3;
													E[1] = d3;
													E[2] = d3;
												}
											}
											else{

												E[0] = d3;
												E[1] = d3;
												E[2] = d3;
												d[0] = d3;
												d[1] = d3;
												d[2] = d3;
											}
										}
										//it doesn't matter what the actual distance is - the relative distance is what matters. or does it?
										if (d[0] != d3 || d[1] != d3){
											Dist1 = (float)(fabs(d[0] - E[0]));
											//Dist1 = Dist1*Dist1;// ^ 2
											Dist2 = (float)(fabs(d[1] - E[1]));
											//Dist2 = Dist2*Dist2;
											Dist3 = (float)(fabs(d[2] - E[2]));
											//Dist3 = Dist3*Dist3;
											Dist4 = Dist1+Dist2+Dist3;
											Dist = (float)Dist4;//(pow(Dist4,0.5));

											if (Se1 == Seq1 || Se2 == Seq1 || Se3 == Seq1 || Se4 == Seq1){
												AvDist[0] = AvDist[0] + Dist;
												TotCount[0] = TotCount[0] + 1;
												
											}
											if (Se1 == Seq2 || Se2 == Seq2 || Se3 == Seq2 || Se4 == Seq2){
												AvDist[1] = AvDist[1] + Dist;
												TotCount[1] = TotCount[1] + 1;
												
											}
											if (Se1 == Seq3 || Se2 == Seq3 || Se3 == Seq3 || Se4 == Seq3){
												AvDist[2] = AvDist[2] + Dist;
												TotCount[2] = TotCount[2] + 1;
												
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}



	return(1);
}

int FAR pascal UpdateMatrixRRP(int RSize, float *MatrixRRP, float *MatrixRX, float *MatrixRR){

	int X, Y, off1, off2, off3, off4, off5, offx, offy ;
	float h1,h2;
	off1 = RSize+2;
	offy=off1*off1;
//MatrixRRP(RSize + 1, RSize + 1, 1)
	for (X = 0; X <= RSize; X++){
		offx = X*(off1);
		for (Y = X + 1; Y<= RSize; Y++){
                off2 = Y + offx;
				h1 = MatrixRX[off2];
				h2 = MatrixRR[off2];
                if (h1 > h2){
					off4 = X + Y*(off1);
                    MatrixRRP[off2] = MatrixRRP[off2] + 1;
                    MatrixRRP[off4] = MatrixRRP[off2];
                }
                else{
					if (h1 < h2){
						off3 =off2+offy;
						off4 = X + Y*(off1);
						off5 = off4+offy;
						MatrixRRP[off3] = MatrixRRP[off3] + 1;
						MatrixRRP[off5] = MatrixRRP[off3];
                
					}
					else{
						off3 = off2+offy;
						off4 = X + Y*(off1);
						off5 = off4+offy;
						MatrixRRP[off2] = MatrixRRP[off2] + 1;
						MatrixRRP[off4] = MatrixRRP[off2];
						MatrixRRP[off3] = MatrixRRP[off3] + 1;
						MatrixRRP[off5] = MatrixRRP[off3];
					}


				}
		}
	}
	return(1);
}


int FAR pascal FillMatrixC(int NDone, int X, int VarNum, int Nextno, char *tCMat, char *BinMat, char *MatrixC){

	int nd, Y, Z, off1, off2, off3;
	char A, B, GoOn, tCnt;
	
	off1 = VarNum+1;
	off2 = off1*X;
	//ReDim tCMat(1, 1)
	//ReDim MatrixC(VarNum, VarNum)
	//ReDim BinMat(VarNum, Nextno)
	nd = NDone;
	for (Y = X + 1; Y <= VarNum; Y++){
            tCMat[0] = 0;
			tCMat[2] = 0;
			tCMat[1] = 0;
			tCMat[3] = 0;
            nd++;
            GoOn = 0;
			for (Z = 0; Z<= Nextno; Z++){
				off3 = Z*off1;
                A = BinMat[X + off3];
                if (A < 2) {
					B = BinMat[Y + off3];
					if (B < 2){
						if (tCMat[A + B*2] == 0){
							tCMat[A + B*2] = 1;
							tCnt = tCMat[0] + tCMat[1] + tCMat[2] + tCMat[3];
							if (tCnt == 4) {
								GoOn = 1;
								break;
							}
						}
					}
                }
            }
            
            if (GoOn == 1){
                MatrixC[X + Y*(off1)] = 1;
                MatrixC[Y + off2] = 1;
            }
            
	}

	return(nd);
}


int FAR pascal FillRegionMatX(int LSeq, int RSize, int ST, int EN, int *SCArray, float *PairDist, float *RegionMat){
	int LS1, LS2, RS1, RS2, A, B, off1, off2;
	float mdst;
	off1=RSize+2;
//ReDim RegionMat(RSize + 1, RSize + 1)
	LS1 = -1;
	LS2 = -1;
	if (ST < EN){
        for (A = 1; A < ST; A++){
            RS1 = SCArray[A];
            if (LS1 != RS1){
				off2 = RS1*off1;
                LS1 = RS1;
            
                for (B = ST; B<= EN; B++){
                    RS2 = SCArray[B];
                    if (LS2 != RS2){
                        LS2 = RS2;
                        
                        if (PairDist[A] > PairDist[B])
                            mdst = PairDist[B];
                        else
                            mdst = PairDist[A];
                        
                        if (mdst > RegionMat[RS2 + off2]){
                            RegionMat[RS2 + off2] = mdst;
                            RegionMat[RS1 + RS2*off1] = mdst;
                        }
                        
                    }
                }
               
            }
        }
        for (A = EN + 1; A <= LSeq; A++){ 
            RS1 = SCArray[A];
			if (LS1 != RS1){
				
                LS1 = RS1;
				off2 = RS1*off1;
				for (B = ST; B <= EN; B++){
                    RS2 = SCArray[B];
                    if (LS2 != RS2){
                        LS2 = RS2;
                        
                        if (PairDist[A] > PairDist[B])
                            mdst = PairDist[B];
                        else
                            mdst = PairDist[A];
                        
                        if (mdst > RegionMat[RS2 + off2]){
                            RegionMat[RS2 + off2] = mdst;
                            RegionMat[RS1 + RS2*off1] = mdst;
                        }
                        
                    }
                }
                
            }
        }
	}
    else{
        for (A = EN + 1; A < ST; A++){
            RS1 = SCArray[A];
            if (LS1 != RS1){
                LS1 = RS1;
				off2 = RS1*off1;
				for (B = 1; B<= EN; B++){
                    RS2 = SCArray[B];
                    if (LS2 != RS2){
                        LS2 = RS2;
                        
                        if (PairDist[A] > PairDist[B])
                            mdst = PairDist[B];
                        else
                            mdst = PairDist[A];
                        
                        if (mdst > RegionMat[RS2 + off2]){
                            RegionMat[RS2 + off2] = mdst;
                            RegionMat[RS1 + RS2*off1] = mdst;
                        }
                        
                    }
                }
                for (B = ST; B<=LSeq; B++){ 
                    RS2 = SCArray[B];
                    if (LS2 != RS2){
                        LS2 = RS2;
                        
                        if (PairDist[A] > PairDist[B])
                            mdst = PairDist[B];
                        else
                            mdst = PairDist[A];
                        
                        if (mdst > RegionMat[RS2 + off2]){
                            RegionMat[RS2 + off2] = mdst;
                            RegionMat[RS1 + RS2*off1] = mdst;
                        }
                        
                    }
                }
            }
        }
        
    }

	
	return(1);

}

int FAR pascal GrowMChiWin2(int LO, int RO, int LenXoverSeq, int HWindowWidth, int TWin, int MaxY, int LS, int A, int C, int MaxFailCount, double *MPV, int *WinWin, double *MChi, int *TopL, int *TopR, int *TopLO, int *TopRO, char *Scores, char *mdmap){
	//scores LS,2 
	int off1, FailCount, B, D;
	double hMChi, tpv, lxdh,lx,h ,t, E;
	off1 = MaxY*(LS+1);
	FailCount = 0;
	lx = LenXoverSeq;
	h = HWindowWidth;
	lxdh = lx/h;
	//TW2 = TWin*2;
	while (FailCount <= MaxFailCount){
            A = A + Scores[LO + off1];
            C = C + Scores[RO + off1];
            B = TWin - A;
            D = TWin - C;
            if (A + C > 0 && B + D > 0){
                E = A*D - B*C;
				hMChi = E*E*2/(TWin*(A + C)*(B + D));
				/*
				hMChi = (A * D - B * C);
				hMChi =	hMChi * hMChi;
				hMChi = hMChi*TWin*2;
                hMChi = hMChi / (A + B);
                hMChi = hMChi / (C + D);
                hMChi = hMChi / (A + C);
                hMChi = hMChi / (B + D);*/
                if (TWin < HWindowWidth){
                    t = (double)(TWin);
					h = (double)(LenXoverSeq);
					tpv = ChiPVal(hMChi) * (h / t);
				}
                else{
					t = (double)(TWin);
					h = (double)(HWindowWidth);
                    tpv = ChiPVal(hMChi) * lxdh;
                }
                if (tpv <= *MPV){
                    *TopLO = LO;
                    *TopRO = RO;
                    *MChi = hMChi;
                    *WinWin = TWin;
                    *MPV = tpv;
                    FailCount = 0;
                    *TopL = A;
                    *TopR = C;
				}
				else{
					if (TWin == HWindowWidth && *TopL == 0 && *TopR == 0){
                        *TopL = A;
                        *TopR = C;
                    }
                    FailCount++;
                    if (FailCount > MaxFailCount)
                        return(1);
                }
			}
            else{
                FailCount++;
                if (FailCount > MaxFailCount)
                    return(1);
                hMChi = 0;
            }
			if (mdmap[RO]==1 || mdmap[LO]==1)
				break;
            RO++;
            LO--;

			if (mdmap[RO]==1 || mdmap[LO]==1)
				break;

            if (LO < 1)
				LO = LenXoverSeq;
            if (RO > LenXoverSeq)
				RO = RO - LenXoverSeq;

            TWin++;
			if (TWin > LenXoverSeq)
				return(1);
	}
	return(1);
}

int FAR pascal ReplaceSeq(int NextNo, int LS, int S1, int S2, short int *SeqNum, unsigned char *MissingData){
	int Y,off;
	off = LS+1;
	for (Y = 1; Y <= LS;Y++)
		SeqNum[Y + S1*off] = SeqNum[Y + S2*off];
	for (Y = 1; Y <= LS;Y++)
           MissingData[Y + S1*off] = MissingData[Y + S2*off];

	return(1);
}

int FAR pascal ModSeqNumE(int NextNo, int LS, int FS, int BE,int EN, short int *SeqNum, unsigned char *MissingData){
	int Y,off;
	off = LS+1;
	if (BE < EN ){
		for (Y = BE; Y <= EN;Y++)
			SeqNum[Y + FS*off] = 46;
		for (Y = BE; Y <= EN;Y++)
            MissingData[Y + FS*off] = 1;
                       
	}
	else{
		for (Y = 1; Y <= EN; Y++)
			SeqNum[Y + FS*off] = 46;
		for (Y = 1; Y <= EN; Y++)
			MissingData[Y + FS*off] = 1;
                        
                        
        for (Y = BE; Y <= LS; Y++)
			SeqNum[Y + FS*off] = 46;
		for (Y = BE; Y <= LS; Y++)
			MissingData[Y + FS*off] = 1;
                        
	}
	return(1);
}
int FAR pascal ModSeqNumD(int NextNo, int LS, int FS, int BE,int EN, short int *SeqNum, unsigned char *MissingData){
	int Y, off;
	off = LS+1;
	if (BE < EN){
		for (Y = 1; Y<= BE; Y++)
			SeqNum[Y + NextNo*off] = 46;
		for (Y = 1; Y<= BE; Y++)
            MissingData[Y + NextNo*off] = 1;
	
        for (Y = BE + 1; Y < EN; Y++)
			SeqNum[Y + NextNo*off] = SeqNum[Y + FS*off];
		for (Y = BE + 1; Y < EN; Y++)
            MissingData[Y + NextNo*off] = MissingData[Y + FS*off];;
                        
        for (Y = EN; Y<= LS; Y++)
			SeqNum[Y + NextNo*off] = 46;
		for (Y = EN; Y<= LS; Y++)
            MissingData[Y + NextNo*off] = 1;

		
	}
    else{
        
		
		for (Y = 1; Y < EN; Y++)
			SeqNum[Y + NextNo*off] = SeqNum[Y + FS*off];
		for (Y = 1; Y < EN; Y++)
            MissingData[Y + NextNo*off] = MissingData[Y + FS*off];
		
		for (Y = EN ; Y <= BE; Y++)
			SeqNum[Y + NextNo*off] = 46;
		for (Y = EN ; Y <= BE; Y++)
            MissingData[Y + NextNo*off] = 1;
                        
        for (Y = BE+1; Y<= LS; Y++)
			SeqNum[Y + NextNo*off] = SeqNum[Y + FS*off];
		for (Y = BE+1; Y<= LS; Y++)
            MissingData[Y + NextNo*off] =  MissingData[Y + FS*off];
		
	}
	return(1);
}

double FAR pascal MakeSubProb(int X, int LS, int LenXoverSeq, int BTarget, int ETarget, char *SubSeq, double *LL, double *KMax, double *MissPen, double *critval){
	int C,t1,t2;
	t1=0;
	t2=0;
	double FragSc, Polys, LKLen, KAScore, PV, THld, warn;
	FragSc = 0.0;
	if (X<3){
		for (C = BTarget; C <= ETarget; C++)
			FragSc = FragSc + SubSeq[C + X*(LS+1)];
	}
	else{
		if (X == 3){
			t1=0;
			t2=1;
		}
		else if (X==4){
			t1=0;
			t2=2;
		}
		else if (X==5){
			t1=1;
			t2=2;
		}

		for (C = BTarget; C <= ETarget; C++)
			FragSc = FragSc + SubSeq[C + t1*(LS+1)] + SubSeq[C + t2*(LS+1)];

	}
	
    if (BTarget < ETarget)
		Polys = ETarget - BTarget + 1;
    else
		Polys = ETarget + LenXoverSeq - BTarget + 1;

    FragSc = FragSc - (Polys - FragSc) * MissPen[X];
                            
	if (FragSc > critval[X]){
		LKLen = log(KMax[X] * LenXoverSeq);
        KAScore = (LL[X] * FragSc) - LKLen;
        if (KAScore > 0){
			if (KAScore < 32){
				
				THld = exp(-KAScore);
				PV = 1 - exp(-THld);
				
			}
			else{
				warn=0;
				if (KAScore > 700 ){
									
					warn=KAScore;
					KAScore = 701;
									
				}
								
				THld = exp(-KAScore);
				if (warn != 0 ){
					KAScore = warn - 700;
					THld = THld/KAScore;
				}
				PV = THld;
			}

		}
		else
			PV=1;
		return (PV);
	}
	else
		return (1);
}

int FAR pascal GetMaxFragScore(int LenXoverSeq, int lseq,short int CircularFlag, short int GCMissmatchPen,double *MissPen, int *MaxScorePos,int *FragMaxScore,int *FragScore, int *FragCount, int *hiscore ){

	int fcx,fms,X,Y, Z, os, os2, Polys, Diffs, fs, ts, os3, os5, os6, os7;
	float MPen;

	os= lseq+1;
	os2 = lseq+1;

	if (GCMissmatchPen > 0){

		//Find the max score per frag by joing up frags, basically start at leftmost frag and
		//expand right, finding the max score including that frag -these are inner frags
    
    
		if (CircularFlag == 0){
			for (X = 0; X < 6; X++){
				hiscore[X] = 0;
				os3 = X*os2;
				os6 = X*os;
				MPen = (float)(MissPen[X]);
				fcx = FragCount[X];
				for (Y = 0; Y <= fcx;Y++){
					os5 = Y+os3;
					
					if (FragScore[os5] > 0){
						
						//fms = 0;
						//ts = (int)(FragScore[os5]);
						//ts=(int)(TempScore);
						Polys = FragScore[os5];
						fms = Polys;
						Diffs = 0;
						
						//FragMinScore = ts;
						MaxScorePos[os5] = Y;
						
						for (Z = Y + 1; Z <= fcx; Z++){
							
							
							fs = FragScore[Z + os3];
							if(fs <= 0){
								fs = -fs;
								Diffs += fs;
							}

							Polys += fs;
												
							ts = (int)((Polys - Diffs) - (Diffs * MPen));
							if (ts < 0)
								break;
							else if (ts >= fms){
								fms = ts;
								MaxScorePos[os5] = Z;
							}
							//else if (ts < 0) 
							//	break;
							
                     
						}
						
						FragMaxScore[os5]=fms;
						if (fms > hiscore[X])
							hiscore[X] = fms;
					}
					else
						FragMaxScore[os5]=0;
					
				}
			}
		}
		else{
			for (X = 0; X < 6; X++){
				hiscore[X] = 0;
				os3 = X*os2;
				MPen = (float)(MissPen[X]);
				fcx = FragCount[X];
				for (Y = 0; Y <= FragCount[X];Y++){
					os5 = Y+os3;
					
					if (FragScore[os5] > 0){
						//fms=0;
						//ts = (int)(FragScore[os5]);
						//ts = (int)(TempScore);
						Polys = FragScore[os5];
						Diffs = 0;
						fms = Polys;
						//FragMinScore = ts;
						MaxScorePos[os5] = Y;
						for (Z = Y + 1; Z <= fcx; Z++){
							
							
							fs = FragScore[Z + os3];
							if(fs <= 0){
								fs = -fs;
								Diffs += fs;
							}

							Polys += fs;
												
							ts = (int)((Polys - Diffs) - (Diffs * MPen));
							if (ts < 0)
								break;
							else if (ts >= fms){
								fms = ts;
								MaxScorePos[os5] = Z;
							}
							
                     
						}
						FragMaxScore[os5] =fms;
						if (fms > hiscore[X])
								hiscore[X] = fms;
					}
					else
						FragMaxScore[os5]=0;
					
					
				}
			}
			

			//0

			/*hiscore[0] = 0;
			//os3 = 0*os2;
			MPen = (float)(MissPen[0]);
			fcx = FragCount[0];
			for (Y = 0; Y <= FragCount[0];Y++){
				os5 = Y;
				
				if (FragScore[os5] > 0){
					//fms=0;
					//ts = (int)(FragScore[os5]);
					//ts = (int)(TempScore);
					Polys = FragScore[os5];
					Diffs = 0;
					fms = Polys;
					//FragMinScore = ts;
					MaxScorePos[os5] = Y;
					for (Z = Y + 1; Z <= fcx; Z++){
						
						
						fs = FragScore[Z];
						if(fs <= 0){
							fs = -fs;
							Diffs += fs;
						}

						Polys += fs;
											
						ts = (int)((Polys - Diffs) - (Diffs * MPen));
						if (ts < 0)
							break;
						else if (ts >= fms){
							fms = ts;
							MaxScorePos[os5] = Z;
						}
						
                 
					}
					FragMaxScore[os5] =fms;
					if (fms > hiscore[0])
							hiscore[0] = fms;
				}
				else
					FragMaxScore[os5]=0;
				
				
			}


			//1

			hiscore[1] = 0;
			//os3 = os2;
			MPen = (float)(MissPen[1]);
			fcx = FragCount[1];
			for (Y = 0; Y <= FragCount[1];Y++){
				os5 = Y+os2;
				
				if (FragScore[os5] > 0){
					//fms=0;
					//ts = (int)(FragScore[os5]);
					//ts = (int)(TempScore);
					Polys = FragScore[os5];
					Diffs = 0;
					fms = Polys;
					//FragMinScore = ts;
					MaxScorePos[os5] = Y;
					for (Z = Y + 1; Z <= fcx; Z++){
						
						
						fs = FragScore[Z + os2];
						if(fs <= 0){
							fs = -fs;
							Diffs += fs;
						}

						Polys += fs;
											
						ts = (int)((Polys - Diffs) - (Diffs * MPen));
						if (ts < 0)
							break;
						else if (ts >= fms){
							fms = ts;
							MaxScorePos[os5] = Z;
						}
						
                 
					}
					FragMaxScore[os5] =fms;
					if (fms > hiscore[1])
							hiscore[1] = fms;
				}
				else
					FragMaxScore[os5]=0;
				
				
			}

			//2

			hiscore[2] = 0;
			os3 = 2*os2;
			MPen = (float)(MissPen[2]);
			fcx = FragCount[2];
			for (Y = 0; Y <= FragCount[2];Y++){
				os5 = Y+os3;
				
				if (FragScore[os5] > 0){
					//fms=0;
					//ts = (int)(FragScore[os5]);
					//ts = (int)(TempScore);
					Polys = FragScore[os5];
					Diffs = 0;
					fms = Polys;
					//FragMinScore = ts;
					MaxScorePos[os5] = Y;
					for (Z = Y + 1; Z <= fcx; Z++){
						
						
						fs = FragScore[Z + os3];
						if(fs <= 0){
							fs = -fs;
							Diffs += fs;
						}

						Polys += fs;
											
						ts = (int)((Polys - Diffs) - (Diffs * MPen));
						if (ts < 0)
							break;
						else if (ts >= fms){
							fms = ts;
							MaxScorePos[os5] = Z;
						}
						
                 
					}
					FragMaxScore[os5] =fms;
					if (fms > hiscore[2])
							hiscore[2] = fms;
				}
				else
					FragMaxScore[os5]=0;
				
				
			}

			//3

			hiscore[3] = 0;
			os3 = 3*os2;
			MPen = (float)(MissPen[3]);
			fcx = FragCount[3];
			for (Y = 0; Y <= FragCount[3];Y++){
				os5 = Y+os3;
				
				if (FragScore[os5] > 0){
					//fms=0;
					//ts = (int)(FragScore[os5]);
					//ts = (int)(TempScore);
					Polys = FragScore[os5];
					Diffs = 0;
					fms = Polys;
					//FragMinScore = ts;
					MaxScorePos[os5] = Y;
					for (Z = Y + 1; Z <= fcx; Z++){
						
						
						fs = FragScore[Z + os3];
						if(fs <= 0){
							fs = -fs;
							Diffs += fs;
						}

						Polys += fs;
											
						ts = (int)((Polys - Diffs) - (Diffs * MPen));
						if (ts < 0)
							break;
						else if (ts >= fms){
							fms = ts;
							MaxScorePos[os5] = Z;
						}
						
                 
					}
					FragMaxScore[os5] =fms;
					if (fms > hiscore[3])
							hiscore[3] = fms;
				}
				else
					FragMaxScore[os5]=0;
				
				
			}

			//4

			hiscore[4] = 0;
			os3 = 4*os2;
			MPen = (float)(MissPen[4]);
			fcx = FragCount[4];
			for (Y = 0; Y <= FragCount[4];Y++){
				os5 = Y+os3;
				
				if (FragScore[os5] > 0){
					//fms=0;
					//ts = (int)(FragScore[os5]);
					//ts = (int)(TempScore);
					Polys = FragScore[os5];
					Diffs = 0;
					fms = Polys;
					//FragMinScore = ts;
					MaxScorePos[os5] = Y;
					for (Z = Y + 1; Z <= fcx; Z++){
						
						
						fs = FragScore[Z + os3];
						if(fs <= 0){
							fs = -fs;
							Diffs += fs;
						}

						Polys += fs;
											
						ts = (int)((Polys - Diffs) - (Diffs * MPen));
						if (ts < 0)
							break;
						else if (ts >= fms){
							fms = ts;
							MaxScorePos[os5] = Z;
						}
						
                 
					}
					FragMaxScore[os5] =fms;
					if (fms > hiscore[4])
							hiscore[4] = fms;
				}
				else
					FragMaxScore[os5]=0;
				
				
			}

			//5

			hiscore[5] = 0;
			os3 = 5*os2;
			MPen = (float)(MissPen[5]);
			fcx = FragCount[5];
			for (Y = 0; Y <= FragCount[5];Y++){
				os5 = Y+os3;
				
				if (FragScore[os5] > 0){
					//fms=0;
					//ts = (int)(FragScore[os5]);
					//ts = (int)(TempScore);
					Polys = FragScore[os5];
					Diffs = 0;
					fms = Polys;
					//FragMinScore = ts;
					MaxScorePos[os5] = Y;
					for (Z = Y + 1; Z <= fcx; Z++){
						
						
						fs = FragScore[Z + os3];
						if(fs <= 0){
							fs = -fs;
							Diffs += fs;
						}

						Polys += fs;
											
						ts = (int)((Polys - Diffs) - (Diffs * MPen));
						if (ts < 0)
							break;
						else if (ts >= fms){
							fms = ts;
							MaxScorePos[os5] = Z;
						}
						
                 
					}
					FragMaxScore[os5] =fms;
					if (fms > hiscore[5])
							hiscore[5] = fms;
				}
				else
					FragMaxScore[os5]=0;
				
				
			}*/

			


		}
	}
	else{
		for (X = 0; X <= 5; X++){
			os3 = X*os2;
			os7 = X*os;
			
			for (Y = 0; Y <= FragCount[X];Y++){
				os = Y + os3;
				FragMaxScore[Y + os7] = FragScore[os];
				MaxScorePos[os] = Y;
			}
		}
	}
	return (1);
}


int FAR pascal DelPVals(short int GCMaxOverlapFrags,int Y, int X, int LS, double *PVals, int *FragCount, int *FragSt, int *FragEn, int *MaxScorePos, int *DeleteArray){
	//pvals, fragsst/fragen/maxscorepos - lenseq,6
	int Z, off1, off2, off3, GoOn;
	off1 = FragSt[Y+X*(LS+1)];
	off2 = FragEn[MaxScorePos[Y+X*(LS+1)] + X*(LS+1)];
	off3 = Y+X*(LS+1);
	GoOn = 1;
	if(off1 < off2){
		for (Z = off1; Z <= off2; Z++){
			if (DeleteArray[Z] >= GCMaxOverlapFrags){
                    GoOn = 0;
                    PVals[off3] = 100;
                    break;
			}
		}
	}
	else{
		for (Z = off1; Z <= FragCount[X]; Z++){
             if (DeleteArray[Z] >= GCMaxOverlapFrags){
                    GoOn = 0;
                    PVals[off3] = 100;
                    break;
			}
		}
		if (Z >= FragCount[X]){
			for (Z = 1; Z <= off2; Z++){ 
				if (DeleteArray[Z] >= GCMaxOverlapFrags){
                    GoOn = 0;
                    PVals[off3] = 100;
                    break;
				}
			}
		}
	}


	return(GoOn);
}

int FAR pascal GetMaxFragScoreB(int LenXoverSeq, int lseq,short int CircularFlag, short int GCMissmatchPen,double *MissPen, int *MaxScorePos,int *FragMaxScore,int *FragScore, int *FragCount, int *hiscore ){

	int X,Y, Z, os, os2, Polys, Diffs, fs, ts, os3, os4, os5, os6;
	float TempScore, MPen;

	os= lseq+1;
	os2 = lseq+1;

	if (GCMissmatchPen > 0){

		//Find the max score per frag by joing up frags, basically start at leftmost frag and
		//expand right, finding the max score including that frag -these are inner frags
    
    
		if (CircularFlag == 0){
			for (X = 0; X < 6; X++){
				hiscore[X] =0;
				os3 = X*os2;
				os6 = X*os;
				MPen = (float)(MissPen[X]);
				for (Y = 0; Y <= FragCount[X];Y++){
					os5 = Y+os3;
					FragMaxScore[os5] = 0;
					if (FragScore[os5] > 0){
                 
						TempScore = (float)(FragScore[Y + os3]);
						ts=(int)(TempScore);
						Polys = ts;
						Diffs = 0;
						FragMaxScore[os5] = ts;
						//FragMinScore = ts;
						MaxScorePos[os5] = Y;
						
						for (Z = Y + 1; Z <= FragCount[X]; Z++){
							os4 = Z+os3;
							fs = abs(FragScore[os4]);
							Polys += fs;

							if(FragScore[os4] <= 0)
								Diffs += fs;
												
							TempScore = (Polys - Diffs) - (Diffs * MPen);
							ts=(int)(TempScore);

							if (ts >= FragMaxScore[os5]){
								FragMaxScore[os5] = ts;
								MaxScorePos[os5] = Z;
							}
							else if (ts < 0) 
								break;
							//else if (ts <= FragMinScore - 6) 
							//	break;
							
							//if (ts < FragMinScore) 
							//	FragMinScore = ts;
                     
						}
						if (FragMaxScore[os5] > hiscore[X])
							hiscore[X] = FragMaxScore[os5];
					}
				}
			}
		}
		else{
			for (X = 0; X < 6; X++){
				hiscore[X] = 0;
				os3 = X*os2;
				MPen = (float)(MissPen[X]);
				for (Y = 0; Y <= FragCount[X];Y++){
					os5 = Y+os3;
					FragMaxScore[Y+os3]=0;
					if (FragScore[os5] > 0){
                 
						TempScore = (float)(FragScore[os5]);
						ts = (int)(TempScore);
						Polys = ts;
						Diffs = 0;
						FragMaxScore[os5] = ts;
						//FragMinScore = ts;
						MaxScorePos[os5] = Y;
						for (Z = Y + 1; Z <= FragCount[X]; Z++){
							os4 = Z + os3;
							fs = abs(FragScore[os4]);
							Polys += fs;

							if(FragScore[os4] <= 0)
								Diffs += fs;
												
							TempScore = (Polys - Diffs) - (Diffs * MPen);
							ts=(int)(TempScore);

							if (ts >= FragMaxScore[os5]){
								FragMaxScore[os5] = ts;
								MaxScorePos[os5] = Z;
							}
							else if (ts < 0) 
								break;
							
                     
						}
					
						// taking this out makes it run like geneconv - I think that geneconv may be wrong though.
						
						/*if (ts >= 0 ){
							for (Z = 0; Z < Y; Z++){ 
								fs = abs(FragScore[Z + os3]);
								Polys += fs;

								if(FragScore[Z + os3] <= 0)
									Diffs += fs;
													
								TempScore = (Polys - Diffs) - (Diffs * MPen);
								ts=(int)(TempScore);

								if (ts >= FragMaxScore[Y+os3]){
									FragMaxScore[Y+os3] = ts;
									MaxScorePos[Y + os3] = Z;
								}
								else if (ts < 0) 
									break;
								//else if (ts <= FragMinScore - 6) 
								//	break;
								
                    
								//if (ts < FragMinScore) 
								//	FragMinScore = ts;
							}
						}*/
						
					}
					if (FragMaxScore[Y+os3] > hiscore[X])
							hiscore[X] = FragMaxScore[os5];
					
				}
			}
		}
	}
	else{
		for (X = 0; X <= 5; X++){
			os3 = X*os2;
			for (Y = 0; Y <= FragCount[X];Y++){
				FragMaxScore[Y + X*os] = FragScore[Y + os3];
				MaxScorePos[Y + os3] = Y;
			}
		}
	}
	return (1);
}




int FAR pascal GetFrags(short int CircularFlag,int LenXoverSeq,int LSeq, int maxcount, char *SubSeq, int *FragSt, int *FragEn, int *FragScore, int *FragCount){

	int SX,A,X,Y,Z,GoOn,os,os2,os3,  FE, FS, RR, FSc, FC6,os4, os5, target;

	GoOn=0;
	os = maxcount+1;
	RR = LenXoverSeq+1;
	FC6=0;
	os4=LSeq+1;
	os5 = maxcount+1;

	target =  6*os;
	Y=0;
	while (Y <= target){
		FragScore[Y]=0;
		
		Y++;
	}

	while (Y <= target){
		
		FragSt[Y] = 0;
		
		Y++;
	}
	while (Y <= target){
		
		FragEn[Y] = 0;
		
		Y++;
	}

	//target = 
	/*for (Y = 0; Y <= 6; Y++){
		osx = Y*os;
		for (X = 0; X < RR; X++)
			FragScore[X+osx] = 0;
	}
	for (Y = 0; Y <= 6; Y++){
		osx = Y*os;
		for (X = 0; X <= RR; X++){
			FragSt[X+osx] = 0;
			FragEn[X+osx] = 0;

		}
	}*/
	

	for (X = 1; X < RR; X++){
		for (Y = 0; Y < 3; Y++){
			if (SubSeq[X + Y*os4] == 1) 
				break;
		}
		if (Y == 3)
			Y = 6;

		os2 = Y*os4;
		os = FragCount[Y] + Y*os5;
		FragSt[os] = X;
		FS = X;
		SX = X;
		X++;
		if (CircularFlag == 0){
			while (SubSeq[os2+X] == 1){
				X++;
				if (X > LenXoverSeq) 
					break;
			}
		}
		else{
			
			while (SubSeq[os2+X] == 1){
				X++;
				if (X > LenXoverSeq){ 
					X = 1;
					GoOn = 1;
					break;
					
				}
			}
			if (X==1){
				while (SubSeq[os2+X] == 1 && X != SX){
					X++;
					
				}
			}

			if (X == SX)
				return(0);
		}
		

		
		X--;

		FragEn[os] = X;
		FE=X;
		if (FE > FS)
			FSc = FE - FS + 1;
		else if (FE < FS)
			FSc = FE - FS + RR;
		else
			FSc =  1;
		
		FragScore[os] = FSc;
	

		/*for (Z = 0; Z < 3; Z++){
			if (Y != Z){
				os3 = FragCount[Z] + Z*os5;
				FragSt[os3] = FS;
				FragEn[os3] = FE;
				FragScore[os3] = -FSc; 
				FragCount[Z] = FragCount[Z] + 1;
			}
		}*/

	
		if (Y != 0){
			os3 = FragCount[0];
			FragSt[os3] = FS;
			FragEn[os3] = FE;
			FragScore[os3] = -FSc; 
			FragCount[0] = FragCount[0] + 1;
		}
		
		if (Y != 1){
			os3 = FragCount[1] + os5;
			FragSt[os3] = FS;
			FragEn[os3] = FE;
			FragScore[os3] = -FSc; 
			FragCount[1] = FragCount[1] + 1;
		}
		if (Y != 2){
			os3 = FragCount[2] + 2*os5;
			FragSt[os3] = FS;
			FragEn[os3] = FE;
			FragScore[os3] = -FSc; 
			FragCount[2] = FragCount[2] + 1;
		}

			
		if (Y == 0) 
			Z = 5;
		else if (Y == 1)
			Z = 4;
		else if (Y == 2) 
			Z = 3;
		else if (Y == 6)
			Z = 6;

		if (Z < 6){
            os3 = FragCount[Z] + Z*os5;
			if (FragCount[Z] > 0){ 
				if (FragScore[os3-1] > 0){
					FragEn[os3-1] = FE;
					FragScore[os3-1] = FragScore[os3-1] + FSc;
				}
				else{
					FragSt[os3] = FS;
					FragEn[os3] = FE;
					FragScore[os3] = FSc;
					FragCount[Z] = FragCount[Z] + 1;
				}
			}
			else{
				FragSt[os3] = FS;
				FragEn[os3] = FE;
				FragScore[os3] = FSc;
				FragCount[Z] = FragCount[Z] + 1;
			}
            
			for (A = 3; A < 6; A++){
				if (A != Z){ 
					os3 = FragCount[A] + A*os5;
					FragSt[os3] = FS;
					FragEn[os3] = FE;
					FragScore[os3] = -FSc;
					FragCount[A] = FragCount[A] + 1;
				}
			}

			/*if (Z != 3){ 
				os3 = FragCount[3] + 3*os5;
				FragSt[os3] = FS;
				FragEn[os3] = FE;
				FragScore[os3] = -FSc;
				FragCount[3] = FragCount[3] + 1;
			}
			if (Z != 4){ 
				os3 = FragCount[4] + 4*os5;
				FragSt[os3] = FS;
				FragEn[os3] = FE;
				FragScore[os3] = -FSc;
				FragCount[4] = FragCount[4] + 1;
			}
			if (Z != 5){ 
				os3 = FragCount[5] + 5*os5;
				FragSt[os3] = FS;
				FragEn[os3] = FE;
				FragScore[os3] = -FSc;
				FragCount[5] = FragCount[5] + 1;
			}*/


		}
		else{
			if (FragCount[3] > 0){

				for (A = 3; A < 6; A++){
					os3 = FragCount[A] + A*os5;
					if (FragScore[os3-1] > 0){
                            
						FragEn[os3-1] = FE;
						FragScore[os3-1] = FragScore[os3-1] + FSc;
					}  
					else{
						FragSt[os3] = FS;
						FragEn[os3] = FE;
						FragScore[os3] = FSc;
						FragCount[A] = FragCount[A] + 1;
					}
				}//Next A
			}
			else{
				
				for (A = 3; A < 6; A++){
					os3 = FragCount[A] + A*os5;
					FragSt[os3] = FS;
					FragEn[os3] = FE;
					FragScore[os3] = FSc;
					FragCount[A] = FragCount[A] + 1;
				}//Next A
			}
		}
            
		if (Y <= 2)
			FragCount[Y] = FragCount[Y] + 1;
		
		 FC6++;

		if (GoOn == 1)
			break;
    
	}//next X
	FragCount[6] =FC6;
	return(1);
}



/*uble FAR pascal MakeTMatch(){


	double TM;
	TM=0.0;
	If tDon(0) = 0 And ((WinPP = 0 And Don(0, SQ(0)) = 0) Or (WinPP = 1 And Don(1, SQ(1)) = 0) Or (WinPP = 2 And Don(2, SQ(2)) = 0)) And TList(0, SQ(0)) = 1 And TList(1, SQ(1)) = 1 And TList(2, SQ(2)) = 1 Then
		tDon(0) = 1: TrS(0) = SQ(0): TrS(1) = SQ(1): TrS(2) = SQ(2): TMatch(0) = 3
    ElseIf tDon(1) = 0 And ((WinPP = 0 And Don(0, SQ(0)) = 0) Or (WinPP = 1 And Don(1, SQ(2)) = 0) Or (WinPP = 2 And Don(2, SQ(1)) = 0)) And TList(0, SQ(0)) = 1 And TList(1, SQ(2)) = 1 And TList(2, SQ(1)) = 1 Then
        tDon(1) = 1: TrS(0) = SQ(0): TrS(1) = SQ(2): TrS(2) = SQ(1): TMatch(0) = 3
    ElseIf tDon(2) = 0 And ((WinPP = 0 And Don(0, SQ(1)) = 0) Or (WinPP = 1 And Don(1, SQ(2)) = 0) Or (WinPP = 2 And Don(2, SQ(0)) = 0)) And TList(0, SQ(1)) = 1 And TList(1, SQ(2)) = 1 And TList(2, SQ(0)) = 1 Then
        tDon(2) = 1: TrS(0) = SQ(1): TrS(1) = SQ(2): TrS(2) = SQ(0): TMatch(0) = 3
    ElseIf tDon(3) = 0 And ((WinPP = 0 And Don(0, SQ(1)) = 0) Or (WinPP = 1 And Don(1, SQ(0)) = 0) Or (WinPP = 2 And Don(2, SQ(2)) = 0)) And TList(0, SQ(1)) = 1 And TList(1, SQ(0)) = 1 And TList(2, SQ(2)) = 1 Then
        tDon(3) = 1: TrS(0) = SQ(1): TrS(1) = SQ(0): TrS(2) = SQ(2): TMatch(0) = 3
    ElseIf tDon(4) = 0 And ((WinPP = 0 And Don(0, SQ(2)) = 0) Or (WinPP = 1 And Don(1, SQ(1)) = 0) Or (WinPP = 2 And Don(2, SQ(0)) = 0)) And TList(0, SQ(2)) = 1 And TList(1, SQ(1)) = 1 And TList(2, SQ(0)) = 1 Then
         tDon(4) = 1: TrS(0) = SQ(2): TrS(1) = SQ(1): TrS(2) = SQ(0): TMatch(0) = 3
    ElseIf tDon(5) = 0 And ((WinPP = 0 And Don(0, SQ(2)) = 0) Or (WinPP = 1 And Don(1, SQ(0)) = 0) Or (WinPP = 2 And Don(2, SQ(1)) = 0)) And TList(0, SQ(2)) = 1 And TList(1, SQ(0)) = 1 And TList(2, SQ(1)) = 1 Then
         tDon(5) = 1: TrS(0) = SQ(2): TrS(1) = SQ(0): TrS(2) = SQ(1): TMatch(0) = 3
    End If

	return(TM);
}*/
int FAR pascal MakeAnc(int Nextno, int lseq, int CurPos, int *BranchMap, double *THold, int *Path,unsigned char *Identical, char *Conv, short int *AncSeq,short int *SeqNum){


int X,Y,Z,A,os,os2,MaxT,P,S1,S2,S3;

	os =lseq+1;
	os2 = Nextno*2+1;


	for (X = 1; X <= lseq; X++){
		if (Identical[X] == 1){
			for (Y = 0;Y <=  Nextno; Y++)
				AncSeq[X + Y*os] = SeqNum[X];
		}
		else{
        
				for (Y=0; Y <= Nextno*2; Y++){
					for (Z=0; Z <= 4; Z++)
						THold[Y+Z*os2] = 0;
				}
			//Find known nt states at tips
			for (A = 0; A <= Nextno; A++)
				THold[A + Conv[SeqNum[X+ A*os]]*os2] = 1;

			//First Pass (down)
			for (Z = 0; Z <= CurPos; Z++){
            
				P = Path[Z];
				S1 = BranchMap[P + os2];
				S2 = BranchMap[P + os2*2];
				MaxT = 0;
				for (A = 0; A <= 4; A++){
					THold[P + A*os2] = THold[S1 + A*os2] + THold[S2 + A*os2];
					if (THold[P + A*os2] > MaxT)
						MaxT = (int)(THold[P + A*os2]);
				}
                        
				//Only Keep winners
				for (A = 0; A <= 4; A++){
					if (THold[P + A*os2] < MaxT) 
						THold[P + A*os2] = 0;
					else
						THold[P + A*os2] = 1;
                
				}
            
			}
        
			//Second Pass (up)
			for (Z = CurPos; Z >= 0; Z--){
                
					P = Path[Z];
					S1 = BranchMap[P];
					S2 = BranchMap[P + os2];
					S3 = BranchMap[P + os2*2];
					MaxT = 0;

					for (A = 0; A <= 4; A++){
						THold[P + A*os2] = THold[S1 + A*os2] + THold[S2 + A*os2] + THold[S3 + A*os2];
					if (THold[P + A*os2] > MaxT)
						MaxT = int(THold[P + A*os2]);
					}
                    
					//Only Keep winners
					for (A = 0; A <= 4; A++){
						if (THold[P + A*os2] < MaxT) 
							THold[P + A*os2] = 0;
						else
							THold[P + A*os2] = 1;
					}
			}
			for (Z = Nextno + 1; Z < Nextno * 2; Z++){
				if (THold[Z + 4*os2] > 0) 
					AncSeq[X + (Z - Nextno)*os] = 46;
				else if (THold[Z] > 0){
					if (THold[Z + os2] > 0) {
						if (THold[Z + 2*os2] > 0){
							if (THold[Z + 3*os2] > 0) //acgt
								AncSeq[X + (Z - Nextno)*os] = 11;
							else //acg
								AncSeq[X + (Z - Nextno)*os] = 7;
                        
						}
						else if (THold[Z + 3*os2] > 0) //act
							AncSeq[X + (Z - Nextno)*os] = 8;
						else //ac
							AncSeq[X + (Z - Nextno)*os] = 1;
                    
					}
					else if (THold[Z + 2*os2] > 0 ){
						if (THold[Z + 3*os2] > 0 ) //agt
							AncSeq[X + (Z - Nextno)*os] = 9;
						else //ag
							AncSeq[X + (Z - Nextno)*os] = 2;
                    
					}
					else if (THold[Z + 3*os2] > 0 ) //at
						AncSeq[X + (Z - Nextno)*os] = 3;
					else //a
						AncSeq[X + (Z - Nextno)*os] = 66;
                
				}
				else if (THold[Z + os2] > 0 ){
					if (THold[Z + 2*os2] > 0){
						if (THold[Z + 3*os2] > 0) //cgt
							AncSeq[X + (Z - Nextno)*os] = 10;
						else //cg
							AncSeq[X + (Z - Nextno)*os]  = 4;
					}
					else if (THold[Z + 3*os2] > 0 ) //ct
						AncSeq[X + (Z - Nextno)*os] = 5;
					else //c
						AncSeq[X + (Z - Nextno)*os]  = 68;
				}
				else if( THold[Z + 2*os2] > 0){
					if (THold[Z + 3*os2] > 0) //gt
						AncSeq[X + (Z - Nextno)*os]  = 6;
					else //g
						AncSeq[X + (Z - Nextno)*os]  = 72;
				}
				else if (THold[Z + 3*os2] > 0)//t
					AncSeq[X + (Z - Nextno)*os]  = 85;
  			}
		}
	}
	return(1);
}

int FAR pascal GetAncDst(int Nextno, int lseq, short int *AncSeq,short int *SeqNum, float *AncDstMat, double *ConDeg ){

	int X,Y,Z,s1,s2,os,os2;
	double Valid;
	os = Nextno*2+1;
	os2 = 86;
	for (X = 0; X < Nextno * 2; X++){
		for (Y = Nextno + 1; Y < Nextno * 2; Y++){
			//If BranchMap(X, 0) = Y Then
			if (X != Y){
				if (X > Nextno){ 
					Valid = 0;
					for (Z = 1; Z <= lseq; Z++){
						s1 = AncSeq[Z + (X - Nextno)*(lseq+1)];
						if (s1 != 46){
							s2 = AncSeq[Z + (Y - Nextno)*(lseq+1)];
							if (s2 != 46){
								Valid ++;
								AncDstMat[X + Y*os] = AncDstMat[X+Y*os] + (float)(ConDeg[s1 + s2*os2]);
							}
						}
					}
				}
				else{
					Valid = 0;
					for (Z = 1; Z <= lseq; Z++){
						s1 = SeqNum[Z + X*(lseq+1)];
						if (s1 != 46){
							s2 = AncSeq[Z + (Y - Nextno)*(lseq+1)];
							if (s2 != 46){
								Valid++;
								AncDstMat[X + Y*os] = AncDstMat[X+Y*os] + (float)(ConDeg[s1 + s2*os2]);
							}
						}
					}
				}
				if (Valid > 0){
					AncDstMat[X + Y*os] = AncDstMat[X + Y*os] / ((float)(Valid));
					AncDstMat[Y + X*os] = AncDstMat[X + Y*os];
				}
				else{
					AncDstMat[X + Y*os] = 1;
					AncDstMat[Y + X*os] = 1;
				}

			}	
    
		}
    
	}
	return(1);

}

int FAR pascal FindRightEnd(int S1, int S2, int S3, int SLen, int BE, int UBMD,unsigned char *MissingData){
	int X, os1, os2, os3;
	X = BE;
	os1 = S1*(UBMD+1);
	os2 = S2*(UBMD+1);
	os3 = S3*(UBMD+1);
    while (MissingData[X + os1] + MissingData[X + os2] + MissingData[X + os3] > 0){
        X++;
        if (X > SLen)
            X = 1;
        
        if (X == BE)
			break;
    }


	return(X);
}

int FAR pascal FindLeftEnd(int S1, int S2, int S3, int SLen, int BE, int UBMD,unsigned char *MissingData){
	int X, os1, os2, os3;
	X = BE;
	os1 = S1*(UBMD+1);
	os2 = S2*(UBMD+1);
	os3 = S3*(UBMD+1);
    while (MissingData[X + os1] + MissingData[X + os2] + MissingData[X + os3] > 0){
        X--;
        if (X < 1)
            X = SLen;
        
        if (X == BE)
			break;
    }


	return(X);
}



int FAR pascal FindSubSeqGCA(char gcindelflag,int LSeq, int seq1, int seq2, int seq3, short int *SeqNum, char *SubSeq, int *XPosDiff, int *XDiffPos, int *NDiff){

	int Z, X ,Y, SX;
	int s1,s2,s3, os1,os2,os3, mp,s1s,s2s,s3s,off1,off2,off3, GoOn;

	Y=0;

	os1 = seq1 * (LSeq+1);
	os2 = seq2 * (LSeq+1);
	os3 = seq3 * (LSeq+1);
	off1 = LSeq+1;
	off2 = (LSeq+1)*2;
	off3 = (LSeq+1)*6;
	X=0;
	//for (X = 0; X <= LSeq; X++)
	XPosDiff[X] = 0;
	XDiffPos[X] = 0;
	if (gcindelflag == 0) {
		for (X = 1; X <= LSeq; X++){
        
			XPosDiff[X] = Y;
			s1 = SeqNum[X + os1];
			s2 = SeqNum[X + os2];
			s3 = SeqNum[X + os3];
			
			if (s1 != s2 || s1 != s3){ 
				if (s1 != 46){
					if (s2 != 46){
						if (s3 != 46){

							Y++;
							XPosDiff[X] = Y;
							XDiffPos[Y] = X;
							SubSeq[Y] = (s1 == s2);
							SubSeq[Y + off1] = (s1 == s3);
							SubSeq[Y + off2] = (s2 == s3);
						}
					}
				}            
				
				SubSeq[Y + off3] = (SubSeq[Y] == 0 && SubSeq[Y+off1] == 0 && SubSeq[Y+off2] == 0);

			}
        
		}
	}
	else if (gcindelflag == 1) {
		for (X = 1; X <= LSeq; X++){
        
			
			s1 = SeqNum[X + os1];
			s2 = SeqNum[X + os2];
			s3 = SeqNum[X + os3];
			GoOn=0;
			if (s1 != s2){ 
            
				if (s1 != 46){
					if (s2 != 46){
						if (s3 != 46){
							Y++;
							XPosDiff[X] = Y;
							XDiffPos[Y] = X;
							SubSeq[Y] = 0;
							SubSeq[Y + off1] = (s1 == s3);
							SubSeq[Y + off2] = (s2 == s3);
						}
						else
							GoOn=1;
					}
					else
						GoOn=1;
				}
				else
					GoOn=1;

				if (GoOn == 1){
					XPosDiff[X] = Y;
					SX = X;


					if (s1 == s2){
						s1s=1;
						s2s=0;
						s3s=0;
					}
					else{
						s1s=0;
						if (s1 == s3){
							s2s=1;
							s3s=0;
						}
						else{
							s2s=0;
							if (s2 == s3)
								s3s=1;
							else
								s3s=0;
						}
					}

					
						X++;
                
						if (X <= LSeq){
                

							s1 = SeqNum[X + os1];
							s2 = SeqNum[X + os2];
							s3 = SeqNum[X + os3];
							
							//for (Z = X; Z <= LSeq; Z++){
							while (s1 == 46 || s2 == 46 || s3 == 46) {
							//	s1 = SeqNum[Z + os1];
							//	s2 = SeqNum[Z + os2];
							//	s3 = SeqNum[Z + os3];

								//if (s1 != 46 && s2 != 46 && s3 != 46) 
								//	break;	
								if (s1s != 0){
									if (s1 != s2)
										s1s=0;
								}

								if (s2s != 0){
									if (s1 != s3)
										s2s=0;
								}

								if (s3s != 0){
									if (s2 !=  s3)
										s3s=0;

								}
								X++;
								if (X > LSeq)
									break;

								s1 = SeqNum[X + os1];
							
								s2 = SeqNum[X + os2];
								s3 = SeqNum[X + os3];
								
							}
							//X=Z;
						}
					
					

					X--; 
					Y++;
                
					mp = (int)(SX + (X - SX) / 2) ;
					
					for (Z = SX+1; Z <= X; Z++)
						XPosDiff[Z] = 0;

					XPosDiff[mp] = Y;
					XDiffPos[Y] = mp;
                
					SubSeq[Y] = s1s;
					SubSeq[Y+off1] = s2s;
					SubSeq[Y+off2] = s3s;
  				}
            
				SubSeq[Y + off3] = (SubSeq[Y] == 0 && SubSeq[Y+off1] == 0 && SubSeq[Y+off2] == 0);
			}
			else if ( s1 != s3){ 
            
				if (s1 != 46){
					if (s2 != 46){
						if (s3 != 46){
							Y++;
							XPosDiff[X] = Y;
							XDiffPos[Y] = X;
							SubSeq[Y] = 1;
							SubSeq[Y + off1] = 0;
							SubSeq[Y + off2] = (s2 == s3);
						}
						else
							GoOn=1;
					}
					else
						GoOn=1;
				}
				else
					GoOn=1;

				if (GoOn == 1){
					XPosDiff[X] = Y;
					SX = X;


					if (s1 == s2){
						s1s=1;
						s2s=0;
						s3s=0;
					}
					else{
						s1s=0;
						if (s1 == s3){
							s2s=1;
							s3s=0;
						}
						else{
							s2s=0;
							if (s2 == s3)
								s3s=1;
							else
								s3s=0;
						}
					}

					
						X++;
                
						if (X <= LSeq){
                

							s1 = SeqNum[X + os1];
							s2 = SeqNum[X + os2];
							s3 = SeqNum[X + os3];
							
							//for (Z = X; Z <= LSeq; Z++){
							while (s1 == 46 || s2 == 46 || s3 == 46) {
							//	s1 = SeqNum[Z + os1];
							//	s2 = SeqNum[Z + os2];
							//	s3 = SeqNum[Z + os3];

								//if (s1 != 46 && s2 != 46 && s3 != 46) 
								//	break;	
								if (s1s != 0){
									if (s1 != s2)
										s1s=0;
								}

								if (s2s != 0){
									if (s1 != s3)
										s2s=0;
								}

								if (s3s != 0){
									if (s2 !=  s3)
										s3s=0;

								}
								X++;
								if (X > LSeq)
									break;

								s1 = SeqNum[X + os1];
								s2 = SeqNum[X + os2];
								s3 = SeqNum[X + os3];
								
							}
							//X=Z;
						}
					
					

					X--; 
					Y++;
                
					mp = (int)(SX + (X - SX) / 2) ;
					
					for (Z = SX+1; Z <= X; Z++)
						XPosDiff[Z] = 0;

					XPosDiff[mp] = Y;
					XDiffPos[Y] = mp;
                
					SubSeq[Y] = s1s;
					SubSeq[Y+off1] = s2s;
					SubSeq[Y+off2] = s3s;
  				}
            
				SubSeq[Y + off3] = (SubSeq[Y] == 0 && SubSeq[Y+off1] == 0 && SubSeq[Y+off2] == 0);
			}
			else


				XPosDiff[X] = Y;
        
		}
	}
	else if (gcindelflag == 2){
		for (X = 1; X <= LSeq; X++){
        
			XPosDiff[X] = Y;
			s1 = SeqNum[X + os1];
			s2 = SeqNum[X + os2];
			s3 = SeqNum[X + os3];
			
			if (s1 != s2 || s1 != s3){ 
				if (s1 != 46 && s2 != 46 && s3 != 46){
					Y++;
					XPosDiff[X] = Y;
					XDiffPos[Y] = X;
					SubSeq[Y] = (s1 == s2);
					SubSeq[Y + LSeq+1] = (s1 == s3);
					SubSeq[Y + (LSeq+1)*2] = (s2 == s3);
				}            
				
				else { 
					Y++;
					XPosDiff[X] = Y;
					XDiffPos[Y] = X;
					SubSeq[Y] =  (s1 == s2);
					SubSeq[Y+(LSeq+1)] = (s1 == s3);
					SubSeq[Y+(LSeq+1)*2] = (s2 == s3);
				}
			
        
				SubSeq[Y + (LSeq+1)*6] = (SubSeq[Y] == 0 && SubSeq[Y+(LSeq+1)] == 0 && SubSeq[Y+(LSeq+1)*2] == 0);
            
        
			}
        
		}

	}
	for (X = 1 ; X <= Y; X++){
        NDiff[0] = NDiff[0] + SubSeq[X];
        NDiff[1] = NDiff[1] + SubSeq[X + off1];
        NDiff[2] = NDiff[2] + SubSeq[X + off2];
	}
	
	XDiffPos[Y + 1] = LSeq;

	Z = XDiffPos[Y] + 1;

	for (X = Z; X <= LSeq; X++)
		XPosDiff[X] = Y;
	
	return(Y);
}

int FAR pascal FindSubSeqGCA2(unsigned char *Identical, char gcindelflag,int LSeq, int seq1, int seq2, int seq3, short int *SeqNum, char *SubSeq, int *XPosDiff, int *XDiffPos, int *NDiff){

	int Z, X ,Y, SX;
	int s1,s2,s3, os1,os2,os3, mp,s1s,s2s,s3s,off1,off2,off3, GoOn;

	Y=0;

	os1 = seq1 * (LSeq+1);
	os2 = seq2 * (LSeq+1);
	os3 = seq3 * (LSeq+1);
	off1 = LSeq+1;
	off2 = (LSeq+1)*2;
	off3 = (LSeq+1)*6;
	X=0;
	for (X = 0; X <= LSeq; X++)
		XPosDiff[X] = 0;
	XDiffPos[0] = 0;
	if (gcindelflag == 0) {
		for (X = 1; X <= LSeq; X++){
        
			XPosDiff[X] = Y;
			s1 = SeqNum[X + os1];
			s2 = SeqNum[X + os2];
			s3 = SeqNum[X + os3];
			
			if (s1 != s2 || s1 != s3){ 
				if (s1 != 46){
					if (s2 != 46){
						if (s3 != 46){

							Y++;
							XPosDiff[X] = Y;
							XDiffPos[Y] = X;
							SubSeq[Y] = (s1 == s2);
							SubSeq[Y + off1] = (s1 == s3);
							SubSeq[Y + off2] = (s2 == s3);
						}
					}
				}            
				
				SubSeq[Y + off3] = (SubSeq[Y] == 0 && SubSeq[Y+off1] == 0 && SubSeq[Y+off2] == 0);

			}
        
		}
	}
	else if (gcindelflag == 1) {
		for (X = 1; X <= LSeq; X++){
        
			XPosDiff[X] = Y;
			if (Identical[X]==0){
				s1 = SeqNum[X + os1];
				s2 = SeqNum[X + os2];
				s3 = SeqNum[X + os3];
				GoOn=0;
				if (s1 != s2 || s1 != s3){ 
            
					if (s1 != 46){
						if (s2 != 46){
							if (s3 != 46){
								Y++;
								XPosDiff[X] = Y;
								XDiffPos[Y] = X;
								SubSeq[Y] = (s1 == s2);
								SubSeq[Y + off1] = (s1 == s3);
								SubSeq[Y + off2] = (s2 == s3);
							}
							else
								GoOn=1;
						}
						else
							GoOn=1;
					}
					else
						GoOn=1;

					if (GoOn == 1){
						SX = X;


						if (s1 == s2){
							s1s=1;
							s2s=0;
							s3s=0;
						}
						else{
							s1s=0;
							if (s1 == s3){
								s2s=1;
								s3s=0;
							}
							else{
								s2s=0;
								if (s2 == s3)
									s3s=1;
								else
									s3s=0;
							}
						}

						
							X++;
                
							if (X <= LSeq){
                

								s1 = SeqNum[X + os1];
								s2 = SeqNum[X + os2];
								s3 = SeqNum[X + os3];
								
								//for (Z = X; Z <= LSeq; Z++){
								while (s1 == 46 || s2 == 46 || s3 == 46) {
								//	s1 = SeqNum[Z + os1];
								//	s2 = SeqNum[Z + os2];
								//	s3 = SeqNum[Z + os3];

									//if (s1 != 46 && s2 != 46 && s3 != 46) 
									//	break;	
									if (s1s != 0){
										if (s1 != s2)
											s1s=0;
									}

									if (s2s != 0){
										if (s1 != s3)
											s2s=0;
									}

									if (s3s != 0){
										if (s2 !=  s3)
											s3s=0;

									}
									X++;
									if (X > LSeq)
										break;

									s1 = SeqNum[X + os1];
									s2 = SeqNum[X + os2];
									s3 = SeqNum[X + os3];
									
								}
								//X=Z;
							}
						
						

						X--; 
						Y++;
                
						mp = (int)(SX + (X - SX) / 2) ;
						
						//for (Z = SX+1; Z <= X; Z++)
						//	XPosDiff[Z] = 0;

						XPosDiff[mp] = Y;
						XDiffPos[Y] = mp;
                
						SubSeq[Y] = s1s;
						SubSeq[Y+off1] = s2s;
						SubSeq[Y+off2] = s3s;
  					}
            
					SubSeq[Y + off3] = (SubSeq[Y] == 0 && SubSeq[Y+off1] == 0 && SubSeq[Y+off2] == 0);
				}
			}
        
		}
	}
	else if (gcindelflag == 2){
		for (X = 1; X <= LSeq; X++){
        
			XPosDiff[X] = Y;
			s1 = SeqNum[X + os1];
			s2 = SeqNum[X + os2];
			s3 = SeqNum[X + os3];
			
			if (s1 != s2 || s1 != s3){ 
				if (s1 != 46 && s2 != 46 && s3 != 46){
					Y++;
					XPosDiff[X] = Y;
					XDiffPos[Y] = X;
					SubSeq[Y] = (s1 == s2);
					SubSeq[Y + LSeq+1] = (s1 == s3);
					SubSeq[Y + (LSeq+1)*2] = (s2 == s3);
				}            
				
				else { 
					Y++;
					XPosDiff[X] = Y;
					XDiffPos[Y] = X;
					SubSeq[Y] =  (s1 == s2);
					SubSeq[Y+(LSeq+1)] = (s1 == s3);
					SubSeq[Y+(LSeq+1)*2] = (s2 == s3);
				}
			
        
				SubSeq[Y + (LSeq+1)*6] = (SubSeq[Y] == 0 && SubSeq[Y+(LSeq+1)] == 0 && SubSeq[Y+(LSeq+1)*2] == 0);
            
        
			}
        
		}

	}
	for (X = 1 ; X <= Y; X++){
        NDiff[0] = NDiff[0] + SubSeq[X];
        NDiff[1] = NDiff[1] + SubSeq[X + off1];
        NDiff[2] = NDiff[2] + SubSeq[X + off2];
	}
	
	XDiffPos[Y + 1] = LSeq;

	Z = XDiffPos[Y] + 1;

	for (X = Z; X <= LSeq; X++)
		XPosDiff[X] = Y;
	
	return(Y);
}

int FAR pascal MakeSubAlign(int nextno, int lenseq, int winnum, int stepsize, int winsize, short int *tseqnum, short int *seqnum)
{
	int x, y;
	int os;
	
		os = winnum * stepsize - winsize / 2;
		if (os >= 1 && os <= lenseq - winsize){
			for (x = 1; x <= winsize; x++){
				for (y = 0; y <= nextno; y++)
					*(tseqnum + x + y*(winsize+1)) = *(seqnum + x + os + y*(lenseq+1));
			}
		}
		else if (os > 1) {
			for (x = 1; x <= winsize; x++){
				for (y = 0; y <= nextno; y++){
					if (x + os <= lenseq) 
						*(tseqnum + x + y*(winsize+1)) = *(seqnum + x + os + y*(lenseq+1));
					else
						*(tseqnum + x + y*(winsize+1)) = *(seqnum + x + os - lenseq + y*(lenseq+1));
				}
			}
		}
		else{
			for (x = 1; x <= winsize; x++){
				for (y = 0; y <= nextno; y++){
					if (x + os > 0)
						*(tseqnum + x + y*(winsize+1)) = *(seqnum + x + os + y*(lenseq+1));
					else
						*(tseqnum + x + y*(winsize+1)) = *(seqnum + x + os + lenseq + y*(lenseq+1));
					
				}
			}
		}
	
	return 1;
}

int FAR pascal SingleToInt(int s1, int s2, short int bootreps, int nextno,float *in, short int *out){
	int b;
	for (b = 0; b < bootreps; b++){
		*(out + b) = (int)(*(in + (bootreps + 1)*(nextno+1)*s1 + (bootreps +1)*s2 + b) * 3200);
	}
	return 1;
}



//#pragma optimize( "", off )
int FAR pascal BootDist(short int bootreps, double cvi, double ttratio,short int tmodel, int numsp, int sites, short int *seqnum,int *alias, int *ally, int *weight, int *location, short int *px,short int *xx1, short int *xx2, double *prod, double *prod2, double *prod3, float *dmat, double *vv, int *num1, int *num2, int *denominator, double *numerator, int *wmod)
{
  
  double fracchange, xv, xi,rate ,epsilon, ratxv,
	  sum, sum1, sum2, sumyr, aa, p1, p2, p3, q1, 
	  q2, q3,tt, delta, slope, rat,  th1 , th2, th3, th4;
  int  os2, os, endsite, gap, i, j, jj, jg, k, itemp, m, n, it;
  short int l, bs, b,  iterations,done, flip, tied, 
	  h1, h2,found, completed;
  epsilon = 0.00001;
  bs = bootreps;
  for(i=1;i<=sites;i++){
	  alias[i-1]=i;
	  ally[i-1] = i;
  }

  for (n = 0; n <=bootreps; n++){
	for (m=0; m<=sites; m++)
		weight[n + m*(bootreps+1)] = 0;
  }
  /* Shell sort of sites lexicographically - ie alphabetically */
  gap = sites / 2;
  while (gap > 0) {
    for (i = gap + 1; i <= sites; i++) {
      j = i - gap;
      flip = 1;
      while (j > 0 && flip == 1) {
        jj = alias [j - 1];
        jg = alias [j + gap - 1];
        tied = 1;
        k = 1;
        while (k <= numsp && tied == 1) {
          os = (k-1)*(sites+1);
		  h1 = seqnum [jj + os];
		  h2 = seqnum [jg + os];
		  if (h1 > h2 )//(y[k - 1][jj - 1] > y[k - 1][jg - 1]);
              flip = 1;
		  else
			  flip = 0;
		  if (tied == 1 && h1 == h2)
              tied = 1;
		   else
			   tied = 0;
		  k++;
        }
        if (flip == 0)
          break;
        itemp = alias [j - 1];
        alias [j - 1] = alias [j + gap - 1];
        alias [j + gap - 1] = itemp;
        j -= gap;
      }
    }
    gap /= 2;
  }
  //return 1;
 // void sitecombine()

  /* combine sites that have identical patterns */

  i = 1;
  while (i < sites) {
    j = i + 1;
    tied = 1;
    while (j <= sites && tied == 1) {
      tied = 1;
      k = 1;
      while (k <= numsp && tied == 1) {
        os = (k - 1)*(sites + 1);
		h1 = seqnum [alias[i - 1] + os];
		h2 = seqnum [alias[j - 1] + os];
		if (tied == 1 && h1 == h2)
			tied = 1;
		else
			tied = 0;
		k++;
      }
      if (tied == 0)
        break;
      ally[alias[j - 1] - 1] = alias[i - 1];
      j++;
    }
    i = j;
  }

//void sitescrunch()

  /* move so one representative of each pattern of
     sites comes first */
  

  done = 0;
  i = 1;
  j = 2;
  while (done == 0) {
    if (ally[alias[i - 1] - 1] != alias[i - 1]) {
      if (j <= i)
        j = i + 1;
      if (j <= sites) {
        found = 0;
        do {
          if (ally[alias[j - 1] - 1] == alias[j - 1])
			  found = 1;
		  else
			  found = 0;
          j++;
          if (j > sites)
			  completed = 1;
		  else
			  completed = 0;
        } while (found == 0 && completed == 0);
        if (found == 1) {
          j--;
          itemp = alias[i - 1];
          alias[i - 1] = alias[j - 1];
          alias[j - 1] = itemp;
        } else
          done = 1;
      } else
        done = 1;
    }
    i++;
    if(done == 1 || i >= sites)
		done = 1;
	else
		done = 0;
  }

//void makeweights()

  /* make up weights vector to avoid duplicate computations */
  rate=1;
  endsite = 0;
  for (i = 1; i <= sites; i++) {
    if (ally[i - 1] == i)
      endsite++;
  }
  for (i = 1; i <= endsite; i++)
    location[alias[i - 1] - 1] = i;
  //sumrates = sites;
  os=bootreps+1;
  for(l = 0; l <= bootreps; l++){
	for (i = 0; i < sites; i++)
		weight[(location[ally[i] - 1] - 1)*os + l] += wmod [i*os + l];
	//weight[location[ally[i] - 1] - 1] += 1;
  }
  
  os2 = sites+1;
   //return 1;
  for (k = 0; k < endsite; k++){
    j = alias[k];
	os= k*numsp;
	
    for (i = 0; i < numsp; i++){
        
		h1 =  seqnum [j + i*os2];   
		
		if (h1 == 66) 
                *(px + os + i) = 0;
        else if (h1 == 68)
                *(px + os + i) = 1;
        else if (h1 == 72)
                *(px + os + i) = 2;
        else if (h1 == 85)
                *(px + os + i) = 3;
        else if (h1 == 46)
                *(px + os + i) = 4;
    }
  }

	/* compute or read in base frequencies */
	
	aa = ttratio * 0.25 - 0.25;
	xi = aa / (aa + 0.5);
	xv = 1.0 - xi;
	ttratio = xi / xv;
	if(xi <= 0.0 && xi >= -epsilon)
		xi = 0.0;
	if (xi < 0.0){
		xi = 0.6;
		xv = 0.4;
	}
	fracchange = xi * 0.5 + xv * 0.75;
	
  //makev
  iterations = 1000;
  ratxv = xv;
  rat = 1.0;
  
  
  //for (m=1; m <= numsp - 1;m++){
	//  for(n=m+1; n <= numsp; n++){
		  //quick = 1;
		  
		if (tmodel == 0 || tmodel == 4) {
			for (m=1; m <= numsp - 1;m++){
				for(n=m+1; n <= numsp; n++){
					for(l = 0; l <= bootreps; l++){
					  numerator[l]= 0;
					  denominator[l]= 0;
					}
					for (i = 0; i < endsite; i++) {
					  h1 = *(px + i*numsp + (m-1));
					  h2 = *(px + i*numsp + (n-1));
						/*
					  if (h1 < 4){
							xx1[0] = 0;
							xx1[1] =0;
							xx1[2] = 0;
							xx1[3] = 0;
							xx1[h1] = 1;
						  }
						  else {
							*(xx1) = 1;
							*(xx1 + 1) = 1;
							*(xx1 + 2) = 1;
							*(xx1 + 3) = 1;
						  }

						if (h2 < 4){
							*(xx2) = 0;
							*(xx2 + 1) = 0;
							*(xx2 + 2) = 0;
							*(xx2 + 3) = 0;
							*(xx2 + h2) =1;
						  }
						  else {
							*(xx2) = 1;
							*(xx2 + 1) = 1;
							*(xx2 + 2) = 1;
							*(xx2 + 3) = 1;
						  }
					  sum = 0.0;
					  sum1 = 0.0;
					  sum2 = 0.0;
					 
					 for (b = 0; b <= 3; b++) {
						sum1 += *(xx1 + b);
						sum2 += *(xx2 + b);
						sum += *(xx1 + b) * *(xx2 + b);
					  }
					  //if (quick == 1 && (sum1 == 1.0 || sum1 == 4.0) && (sum2 == 1.0 || sum2 == 4.0))
					  //	  quick == 1;
					  //else
					  //	  quick == 0;
					  if (sum1 == 1.0 && sum2 == 1.0) {
						*/
					  if (h1 == h2 && h1 < 4){
						  for(l= 0; l<= bootreps; l++){
							numerator[l] += (*(weight + i*(bootreps+1) + l));
							denominator[l] += *(weight + i*(bootreps+1) + l);
						  }
					  }
					  else if (h1<4 && h2 <4){
						for(l= 0; l<= bootreps; l++)
							denominator[l] += *(weight + i*(bootreps+1) + l);
					  }
					
					}
					//return (int(denominator[2]));
					if (tmodel == 0){
						for(l = 0; l<= bootreps; l++){			  
						
							if (denominator[l] == 0 || numerator[l] == 0)
							  *(vv+l) = 10.0;
							else{
								if (numerator[l] / denominator[l] > 0.25){
									//*(vv+l) = 1-(double)(numerator[l] / denominator[l]);  
									th1 = (double)(numerator[l] / denominator[l]);
									 th2 = (4.0 * th1 - 1.0) / 3.0;
									 th3 = log(th2);
									 *(vv+l) = -0.75 * th3;
								}
								else
									*(vv+l) = 10.0;
							}
						}
					}
					else if (tmodel == 4){
						for(l = 0; l<= bootreps; l++){			  
						
							if (denominator[l] == 0 || numerator[l] == 0)
								*(vv+l) = 1.0;
							else
								*(vv+l) = 1-(numerator[l] / denominator[l]); 
							
						}
					}
					
					
					for(l= 0; l<= bootreps; l++){
						*(dmat + (bootreps + 1)*(numsp)*(m - 1) + (bootreps +1)*(n - 1) + l) = (float)(vv[l]);
						*(dmat + (bootreps + 1)*(numsp)*(n - 1) + (bootreps +1)*(m - 1) + l) = (float)(vv[l]);
					}
				}
			}	  
		}
		else{
			
			for (m=1; m <= numsp - 1;m++){
				for(n=m+1; n <= numsp; n++){
					for(l = 0; l <= bootreps; l++){
						num1[l] = 0;
						num2[l] = 0;
						denominator[l] = 0;
					}
					for (i = 0; i < endsite; i++) {
						h1 = *(px + i*numsp + (m-1));
						h2 = *(px + i*numsp + (n-1));
						if (h1 < 4){
							*(xx1) = 0;
							*(xx1 + 1) =0;
							*(xx1 + 2) = 0;
							*(xx1 + 3) = 0;
							*(xx1 + h1) = 1;
						}
						else {
							*(xx1) = 1;
							*(xx1 + 1) = 1;
							*(xx1 + 2) = 1;
							*(xx1 + 3) = 1;
						}

						if (h2 < 4){
							*(xx2) = 0;
							*(xx2 + 1) = 0;
							*(xx2 + 2) = 0;
							*(xx2 + 3) = 0;
							*(xx2 + h2) =1;
						 }
						 else {
							*(xx2) = 1;
							*(xx2 + 1) = 1;
							*(xx2 + 2) = 1;
							*(xx2 + 3) = 1;
						 }
					  sum = 0.0;
					  sum1 = 0.0;
					  sum2 = 0.0;
					  for (b = 0; b <= 3; b++) {
						sum1 += *(xx1 + b);
						sum2 += *(xx2 + b);
						sum += *(xx1 + b) * *(xx2 + b);
					  }
					  sumyr = (xx1[0] + xx1[2])
							* (xx2[0] + xx2[2]) +
							  (xx1[1] + xx1[3]) *
							  (xx2[1] + xx2[3]);


					  if (sum1 == 1.0 && sum2 == 1.0) {
						
							for(l= 0; l<= bootreps; l++){
								num1[l]+= (int)(*(weight + i*(bootreps+1) + l) * sum);
								num2[l]+= (int)(*(weight + i*(bootreps+1) + l) * (sumyr - sum));
								denominator[l] += *(weight + i*(bootreps+1) + l);
							}
					  }
					}//next i

					for(l= 0; l<= bootreps; l++){
						if (denominator[l] == 0 || num1[l] == 0)
							vv[l] = 10.0;
					
						else{
						
							tt = 1.0 - num1[l] / denominator[l];
							
							if (tt > 0.0) {
								delta = 0.1;
								tt = delta;
								it = 0;
								while (fabs(delta) > 0.00002 && it < iterations) {
									it++;
									if (tmodel == 1) {
										p1 = exp(-tt);
										p2 = exp(-xv * tt) - exp(-tt);
										p3 = 1.0 - exp(-xv * tt);
									} else {
										p1 = exp(-cvi * log(1 + tt / cvi));
										p2 = exp(-cvi * log(1 + xv * tt / cvi))
										-exp(-cvi * log(1 + tt / cvi));
										p3 = 1.0 - exp(-cvi * log(1 + xv * tt / cvi));
									}
									q1 = p1 + p2 / 2.0 + p3 / 4.0;
									q2 = p2 / 2.0 + p3 / 4.0;
									q3 = p3 / 2.0;

									if (tmodel == 1){
										th1 = 0.5 * exp(-tt) * (num2[l]/ q2 - num1[l]/ q1);
										th2 = 0.25 * xv * exp(-xv * tt);
										th3 = ((denominator[l]- num1[l]- num2[l]) * 2.0 / q3 - num2[l]/ q2 - num1[l]/ q1);
										th4 = th2*th3;
									}
									else{
										th1 = 0.5 * (1 / (1 + tt / cvi)) * exp(-cvi * log(1 + tt / cvi)) * (num2[l]/ q2 - num1[l]/ q1);
										th2 = 0.25 * (xv / (1 + xv * tt / cvi)) * exp(-cvi * log(1 + xv * tt / cvi));
										th3 = ((denominator[l]- num1[l]- num2[l]) * 2 / q3 - num2[l]/ q2 - num1[l] / q1);
										th4 = th2*th3;
									}
									slope  =  th1 + th4;

									if (slope < 0.0)
										delta = fabs(delta) / -2.0;
									else
										delta = fabs(delta);
									tt += delta;
								}
							}
							vv[l]= fracchange * tt;
						} //end if
					}//next l
				 
					 for(l= 0; l<= bootreps; l++){
							*(dmat + (bootreps + 1)*(numsp)*(m - 1) + (bootreps +1)*(n - 1) + l) = (float)(vv[l]);
							*(dmat + (bootreps + 1)*(numsp)*(n - 1) + (bootreps +1)*(m - 1) + l) = (float)(vv[l]);
					 }
				}//next n
			}//next m
		  
		}//end if
//	}
//}
  return(1);
}  /* BootDist */





int FAR pascal AddScores (int bpos, int epos, int nextno, int numtoadd, int seqnumber,int *hitsperseq)
{
	int  os,z;
	os = nextno+1;
	for (z = bpos; z <= epos; z++)
		*(hitsperseq + seqnumber + os*z) = *(hitsperseq + seqnumber + os*z)+numtoadd;
	
	return 1;
}

int FAR pascal DoHits (int bpos, int epos, int nextno, int seqd, int seqmi, int seqma,int *hitsperseq,int *numhits)
{
	int  os,z;
	os = nextno+1;
	for (z = bpos; z <= epos; z++){
		numhits[0] += *(hitsperseq + seqd + os*z);
		numhits[1] += *(hitsperseq + seqmi + os*z);
		numhits[2] += *(hitsperseq + seqma + os*z);
	}
	return 1;
}

int FAR pascal TSeqPerms(int Seq1, int Seq2, int Seq3, int lseq, int *THold, unsigned char *tMissingData, short int *SeqNum, short int *SeqRnd){
	int Z, off1, off2, os3, os1, os2, NewPos, o1, o2, no1, no2;
	double rn, rm, rf, ld, dh;
	ld = (double)(lseq);

	rn = rand();
    rm = RAND_MAX;
	dh = ld/rm;


	off1 = lseq+1;
	off2=off1*2;
    os1 = Seq1*off1;
	os2 = Seq2*off1;
	os3 = Seq3*off1;
	for (Z = 1; Z <= lseq; Z++){
            
            SeqRnd[Z] = SeqNum[Z + os1];
            SeqRnd[Z+off1] = SeqNum[Z + os2];
            SeqRnd[Z+off2] = SeqNum[Z + os3];
	}
       
    for (Z = 1; Z <= lseq; Z++){
        
        o1 = Z+off1;
		o2 = Z+off2;
		if (tMissingData[Z] == 0){
			if(tMissingData[o1] == 0){
				if(tMissingData[o2] == 0){
					rn = rand();
					rf = (rn*dh)+0.49;
					NewPos = (int)(rf);
					no1 = NewPos + off1;
					no2 = NewPos + off2;
					if(tMissingData[NewPos] == 0){
						if(tMissingData[no1] == 0){
							if (tMissingData[no2] == 0 ){
								THold[0] = SeqRnd[Z];
								THold[1] = SeqRnd[o1];
								THold[2] = SeqRnd[o2];
								SeqRnd[Z] = SeqRnd[NewPos];
								SeqRnd[o1] = SeqRnd[no1];
								SeqRnd[o2] = SeqRnd[no2];
								SeqRnd[NewPos] = THold[0];
								SeqRnd[no1] = THold[1];
								SeqRnd[no2] = THold[2];
							}
						 }
					}
				}
			}
		}
        
    }

	return(1);
}
int FAR pascal  DoChiPerms (double mChi, int WinWin, int LenXoverSeq, int LenR, int MCPerms, int LO, char *MCPScore, char *Scores)
{
	int pChi, E, A, C, D, B, X, Z, Curnt, Tempnt, Randum;
	double ChiH, rf,rn, rm;
	rn = rand();
	rm = RAND_MAX;
	pChi = 0;
	for (X = 1; X <= MCPerms; X++){
		//Make Randomised version of scores
        for (Z = 1; Z <= LenR * 2; Z++){
			Curnt = LO + Z - 1;
            if (Curnt > LenXoverSeq) 
				Curnt = Curnt - LenXoverSeq;
            MCPScore[Z] = Scores[Curnt];
		}
        for (Z = 1; Z <= LenR * 2; Z++){
			rn = rand();
			rf = (rn/rm)*(LenR*2);

			Randum = (int)(rf);
			//return Randum;
            if (Randum > LenXoverSeq) 
				Randum = Randum - LenXoverSeq;
            Tempnt = MCPScore[Z];
            MCPScore[Z] = MCPScore[Randum];
            MCPScore[Randum] = Tempnt;
		}
        A = 0;
        C = 0;
        for (Z = 1; Z <= WinWin; Z++){
			A = A + MCPScore[Z];
            C = C + MCPScore[Z + WinWin];
		}
        B = WinWin - A;
        D = WinWin - C;
        if (A + C > 0 && B + D >0){
			E = A*D - B*C;
			ChiH = E*E*2/(WinWin*(A + C)*(B + D));
			if (ChiH > mChi)
				pChi++;
		}
	}
	return pChi;
}



int FAR pascal DoHits2 (int bpos, int epos, int nextno, int seqd, int seqmi, int seqma,int *hitsperseq,int *numhits)
{
	int  os,z;
	os = nextno+1;
	for (z = bpos; z <= epos; z++){
		if (numhits[0] < *(hitsperseq + seqd + os*z))
			numhits[0] = *(hitsperseq + seqd + os*z);
		if (numhits[1] < *(hitsperseq + seqmi + os*z))
			numhits[1] = *(hitsperseq + seqmi + os*z);
		if (numhits[2] < *(hitsperseq + seqma + os*z))
			numhits[2] = *(hitsperseq + seqma + os*z);
	}
	return 1;
}


int FAR pascal BlankSSArrays (int ub1, int ub2, int ub3, int ub4, double *zssh, double *zpsh){
	int x, os1, os2, y;

	os1 = ub1+1;

	for (x = 0; x <=ub2; x++){
		os2 = x*os1;
		for (y = 0; y <=ub1; y++)
			zssh[y+os2]=0.0;

	}

	os1 = ub3+1;

	for (x = 0; x <=ub4; x++){
		os2 = x*os1;
		for (y = 0; y <=ub3; y++)
			zpsh[y+os2]=0.0;

	}
	return(1);
}

double FAR pascal MakeZValue ( int shpos, int numwins, short int numgroups, int ssnumperms, int ssnumperms2, char *dogroup, int *permpscores, double *zpscoreholder)
{


	int z, b, os, os2, os3, os4,ng, ms ;
	double pps, meanpscore, sdpscore, sqhold, permno;
	os = ssnumperms+1;
	os3 = numwins+1;
	permno = ssnumperms2;
	ng= numgroups;



	/*zpscoreholder[shpos + os3] = permpscores[os];
    zpscoreholder[shpos + 2*os3] = permpscores[os*2];
    zpscoreholder[shpos + 3*os3] = permpscores[os*3];
    zpscoreholder[shpos + 4*os3] = permpscores[os*4];
    zpscoreholder[shpos + 5*os3] = permpscores[os*5];
    zpscoreholder[shpos + 7*os3] = permpscores[os*7];*/
	

    for (z = 1; z <= ng; z++){
		
		if (dogroup[z] == 0){
			os2 = z*os;
			os4 = z*os3;

			//Calculate means
			ms = 0;
            for (b = 1; b <= ssnumperms2; b++)
				ms += permpscores[b + os2];
           
			  
            
		
			meanpscore = (double)(ms);
			meanpscore /= permno;   
			
			
			
			//sqmean = meanpscore*meanpscore;

			/* - old code*/

            //Calculate Standard deviations 
            sdpscore = 0;
            for (b = 1; b <= ssnumperms2; b++){
				pps = permpscores[b + os2]- meanpscore;
				//pps = pps ;
				sdpscore +=  pps*pps;
			}
			

            sdpscore /= (double)(permno - 1);
            sqhold = sqrt(sdpscore);
			sdpscore = sqhold;

			//if (meanpscore > 0)
			//	return (sdpscore);


			/*//////////////New sd calc////////////////////
			sdpscore=0;
			for (b = 1; b <= ssnumperms2; b++){
				pps =  permpscores[b + os2];
				sdpscore = sdpscore + pps*pps;
			
			}
			
			sdpscore = sdpscore/(permno-1);
			sdpscore = sdpscore - sqmean;
			sqhold = sqrt (sdpscore);
			sdpscore = sqhold;
			
			/////////////////////////////////////////*/
			

            //Calculate Z-Scores
            pps = permpscores[os2];

			if (sdpscore > 0)
				zpscoreholder[shpos + os4] = (pps - meanpscore) / sdpscore;
			else
				zpscoreholder[shpos + os4] = 0;

		}
	}

	return 1;
}

double FAR pascal MakeZValue2 (int shpos, int numwins, short int numgroups, int ssnumperms, int ssnumperms2, char *dogroup, int *permpscores, double *zpscoreholder)
{

//MakeZValue2 0, 1, 12, SSNumPerms, SSNumPerms, DG2(0), PermSScores(0, 0), tZSScore(0, 0)
                                        
	int z, b, os, os2, os3, os4,ng, ms ;
	double pps, meanpscore, sdpscore, sqhold, permno, sqmean;
	os = ssnumperms+1;
	os3 = numwins+1;
	permno = ssnumperms2;
	ng= numgroups;



	/*zpscoreholder[shpos + os3] = permpscores[os];
    zpscoreholder[shpos + 2*os3] = permpscores[os*2];
    zpscoreholder[shpos + 3*os3] = permpscores[os*3];
    zpscoreholder[shpos + 4*os3] = permpscores[os*4];
    zpscoreholder[shpos + 5*os3] = permpscores[os*5];
    zpscoreholder[shpos + 7*os3] = permpscores[os*7];*/
	

    for (z = 1; z <= ng; z++){
		
		if (dogroup[z] == 0){
			os2 = z*os;
			os4 = z*os3;
			if (permpscores[os2] > 0){
				//Calculate means
				ms = 0;
				for (b = 1; b <= ssnumperms2; b++)
					ms += permpscores[b + os2];
			
				meanpscore = (double)(ms);
				meanpscore /= double(permno);   

				sqmean = meanpscore*meanpscore;


				sdpscore=0;
				for (b = 1; b <= ssnumperms2; b++){
					pps =  permpscores[b + os2];
					sdpscore = sdpscore + pps*pps;
				
				}
				
				sdpscore = sdpscore/(double)(permno);
				sdpscore = sdpscore - sqmean;
				sqhold = sqrt (sdpscore);
				sdpscore = sqhold;
				
				

				//Calculate Z-Scores
				pps = permpscores[os2];

				if (sdpscore > 0)
					zpscoreholder[shpos + os4] = (pps - meanpscore) / sdpscore;
				else
					zpscoreholder[shpos + os4] = 0;
			}

			else
				zpscoreholder[shpos + os4] = 0;

			
		}
	}

	return 1;
}

double FAR pascal MakeZValue3 (double *sqa,int shpos, int numwins, short int numgroups, int ssnumperms, int ssnumperms2, char *dogroup, int *permpscores, double *zpscoreholder)
{

//although this uses a squareing lookup table it is a bit slower than without it - ie it
	//takes more time to look stuff up in an array that it does to multiply a number with itself.
	int z, b, os, os2, os3, os4,ng, ms ;
	double pps, meanpscore, sdpscore, sqhold, permno, sqmean;
	os = ssnumperms+1;
	os3 = numwins+1;
	permno = ssnumperms2;
	ng= numgroups;



	/*zpscoreholder[shpos + os3] = permpscores[os];
    zpscoreholder[shpos + 2*os3] = permpscores[os*2];
    zpscoreholder[shpos + 3*os3] = permpscores[os*3];
    zpscoreholder[shpos + 4*os3] = permpscores[os*4];
    zpscoreholder[shpos + 5*os3] = permpscores[os*5];
    zpscoreholder[shpos + 7*os3] = permpscores[os*7];*/
	

    for (z = 1; z <= ng; z++){
		
		if (dogroup[z] == 0){
			os2 = z*os;
			os4 = z*os3;
			if (permpscores[os2] > 0){
				//Calculate means
				ms = 0;
				for (b = 1; b <= ssnumperms2; b++)
					ms += permpscores[b + os2];
           
				  
            
			
				meanpscore = (double)(ms);
				meanpscore /= double(permno);   
				
				


				sqmean = meanpscore*meanpscore;


				///////////////New sd calc////////////////////
				sdpscore=0;
				for (b = 1; b <= ssnumperms2; b++){
					sdpscore  = sdpscore  + sqa[permpscores[b + os2]];
					
				
				}
				
				sdpscore = sdpscore/(double)(permno);
				sdpscore = sdpscore - sqmean;
				sqhold = sqrt (sdpscore);
				sdpscore = sqhold;
				
				//if (meanpscore > 0)
				//	return (sdpscore);

				/////////////////////////////////////////
				

				//Calculate Z-Scores
				pps = permpscores[os2];

				if (sdpscore > 0)
					zpscoreholder[shpos + os4] = (pps - meanpscore) / sdpscore;
				else
					zpscoreholder[shpos + os4] = 0;
			}

			else
				zpscoreholder[shpos + os4] = 0;

			
		}
	}

	return 1;
}

int FAR pascal QuickCheckB (int HP, int LP1, int LP2,int SSStep, int LS, int x, int sswinlen, int *tally, short int *seqscore3)
{

	int y,z, hn, tot;	
	tot=0;
	for (z = x; z <= LS - sswinlen; z+=SSStep){
	
		tally[0] = 0;
		tally[1] = 0;
		tally[2] = 0;
		tally[3] = 0;
		tally[4] = 0;
		tally[5] = 0;
		for(y = z; y <= z + sswinlen; y++){
			hn = *(seqscore3 + y);
			tally[hn] = tally[hn] + 1;
		}
		if (tally[HP] < tally[LP1] || tally[HP] < tally[LP2])
			tot = tally[HP] + tally[LP1] + tally[LP2];
			if (tally[LP1]*2 > tot)
				return (z);
			else if (tally[LP2]*2 > tot)
				return (z);
	}
               
	return (LS+1);
}

int FAR pascal QuickCheck (int x, int sswinlen, int *tally, short int *seqscore3)
{

	int y, hn;	
	
	
		tally[0] = 0;
		tally[1] = 0;
		tally[2] = 0;
		tally[3] = 0;
		tally[4] = 0;
		tally[5] = 0;
		for(y = x; y <= x + sswinlen; y++){
			hn = *(seqscore3 + y);
			tally[hn] = tally[hn] + 1;
		}
		

               
	return (1);
}


double FAR pascal ShrinkRegionBS(int CircularFlag, int seventnumber, int Hi1, int Hi2, int LO, int LS, int *XPosdiff, int *RS, int *RE, short int *SeqNum, unsigned char *MissingData){

	int cycle, ncyc, ENX, BEx, be, EN, X, os1, h1,h2, lo, h1o,h2o,loo;
	
	be = *RS;
	EN = *RE;

    X = XPosdiff[be];
	ncyc=0;
	cycle =0;
	os1 = LS+1;
	h1o =  os1*Hi1;
	h2o = os1*Hi2;
	loo = os1*LO;
    BEx=be;
	ENX=EN;
	
	
	X = be-1;
	if (X > LS)
		X=LS;
	
	while (X==X){
		h1 = SeqNum[X+h1o];
		h2 = SeqNum[X+h2o];
		lo = SeqNum[X+loo];
        if (h1 != 46){
            if (h2 != 46){
                if (lo != 46){
                    if (h1 != h2 && h1 == lo){
                        BEx = X;
                        break;
                    }
                }
			}
        }
        X--;
        if (X < 1){
            if (CircularFlag == 1)
                X = LS;
            else{
                BEx = 1;
                break;
            }
		}
        else{
			if (seventnumber > 0){
				if (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
					BEx = BEx + 1;
					break;
				}
            }
        }
        if (X == be || X == EN) {
			*RS=BEx;
			*RE=ENX;
			return(1000);
		}
	}


	//*RS=BEx;
	//*RE=ENX;
	//return(1);

    X = BEx;
    if (X > LS) 
		X = LS;
	ncyc = 0;
    while (X==X){
		h1 = SeqNum[X+h1o];
		h2 = SeqNum[X+h2o];
		lo = SeqNum[X+loo];
        if (h1 != 46){
            if (h2 != 46){
                if (lo != 46){
                    if (h1 == h2 && h1 != lo){
                        BEx = X;
                        break;
                    }
                }
			}
        }
        X++;
        if (X > LS){
            if (CircularFlag == 1){
                X = 1;
				if (seventnumber > 0){
					if (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
						BEx = 1;
						break;
					}
				}
                ncyc++;
                if (ncyc == 2){
					*RS=BEx;
					*RE=ENX;
					return(1000);
				}
			}
            else{
                BEx = 1;
                break;
			}
            
		}
        else{
			if (seventnumber >0){
				if (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
					cycle = 0;
					while (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
						X++;
						if (X > LS){
							X = 1;
							cycle++;
							if (cycle == 2){
								X = EN;
								break;
							}
						}
					}
					BEx = X;
					break;
				}
			}
        }
        if (X == EN){
			*RS=BEx;
			*RE=ENX;
			return(1000);
		}
    }
    if (X == EN){
			*RS=BEx;
			*RE=ENX;
			return(1000);
	}
    X = EN;
	ncyc = 0;
    while (X==X){
        
        h1 = SeqNum[X+h1o];
		h2 = SeqNum[X+h2o];
		lo = SeqNum[X+loo];
        if (h1 != 46){
            if (h2 != 46){
                if (lo != 46){
                    if (h1 != h2 && h1 == lo){
                        ENX = X;
                        break;
                    }
                }
			}
        }
        X++;
        if (X > LS){
            if (CircularFlag == 1){
                X = 1;
				if (seventnumber > 0){
					if (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
						ENX = LS;
						break;
					}
				}
				ncyc++;
                if (ncyc == 2){
					*RS=BEx;
					*RE=ENX;
					return(1000);
				}
			}
			else{
                ENX = LS;
                break;
            }
		}
        else{
            if (seventnumber >0){
				if (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
					cycle = 0;
					while (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
						X--;
                    
						if (X == EN){
							*RS=BEx;
							*RE=ENX;
							return(1000);
						}

						if (X < 1)
							X = LS;
						if (X == EN){
							*RS=BEx;
							*RE=ENX;
							return(1000);
							
						}
					}
                
                ENX = X;
                break;
				}
			}
		}
        
        if (X == be || X == EN){
			*RS=BEx;
			*RE=ENX;
			return(1000);
		}
    }
    X = ENX;
	ncyc= 0;
    while (X==X){
		h1 = SeqNum[X+h1o];
		h2 = SeqNum[X+h2o];
		lo = SeqNum[X+loo];
    
        if (h1 != 46){
            if (h2 != 46){
                if (lo != 46){
                    if (h1 == h2 && h1 != lo){
                        ENX = X;
                        break;
                    }
                }
			}
        }
        X--;
        if (X < 1){
            if (CircularFlag == 1){
                X = LS;
                if (seventnumber > 0){
					if (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
						ENX = LS;
						break;
					}
					ncyc = ncyc + 1;
					if (ncyc == 2){
						*RS=BEx;
						*RE=ENX;
						return(1000);
					}
				}
			}
		
            else{
                ENX = LS;
                break;
            }
		}
		else{
            if (seventnumber >0){
				if (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
					cycle = 0;
					while (MissingData[X + h1o] == 1 || MissingData[X + h2o] == 1 || MissingData[X + loo] == 1){
						X--;
						if (X < 1){
							X = LS;
							cycle++;
							if (cycle == 2){
								*RS=BEx;
								*RE=ENX;
								return(1000);
							}
						}
					}
					ENX = X;
					break;
				}
			}
        }
        if (X == be || X == BEx){
			*RS=BEx;
			*RE=ENX;
			return(1000);
		}
    }
	*RS=BEx;
	*RE=ENX;
	return(1);
}

int FAR pascal MakeScoresBS(int LenXOverSeq, int ScoreP, int LS, int be, int EN,  int *a, int *c, int *XPosdiff, char *Scores){
	int A, C, XOverLen, X, os1, os2;
	
	os1 = LS+1;
	os2 = ScoreP*os1;
	A=0;
	C=0;
	// scores ls,2
	if (be < EN){
        XOverLen = XPosdiff[EN] - XPosdiff[be] + 1;
        for (X = XPosdiff[be]; X <=  XPosdiff[EN]; X++)
            A = A + Scores[X + os2];
        
        for (X = 1; X <= XPosdiff[be] - 1; X++)
            C = C + Scores[X + os2];
        
        for (X = XPosdiff[EN] + 1; X <= LenXOverSeq; X++)
            C = C + Scores[X + os2];
        
	}
    else{
        
        XOverLen = XPosdiff[EN] + (LenXOverSeq - XPosdiff[be]) + 1;
        
        for (X = XPosdiff[EN] + 1; X<= XPosdiff[be] - 1; X++)
            C = C + Scores[X + os2];
       
        for (X = 1; X<= XPosdiff[EN]; X++)
            A = A + Scores[X + os2];
        
        for (X = XPosdiff[be]; X<=LenXOverSeq; X++)
            A = A + Scores[X + os2];
        
    }

	*a = A;
	*c = C;
	return(XOverLen);
}

int FAR pascal GetSSOL(int LS, int SEventNumber, int nn1, int nn2, int PermNextNo, int NextNo,int SSOutlyerFlag, int LFlag, int *Seq1, int *Seq2, int *Seq3, int *oSeq, float *TreeDistance, float *Distance, unsigned char *MissingData, int *TraceSub){
	int minmiss, curmiss, WinX, GoOn, X, Z, OLS,INS, s1, s2, s3, so, off1, off2, off3;
	double CTD, MDist, TDist;
	
	off1 = nn1+1;
	off3 = nn2+1;
	off2 = LS+1;
	//treedistance  -nextno,nextno
	s1= *Seq1;
	s2= *Seq2;
	s3= *Seq3;
	so = *oSeq;
	INS=0;
	OLS=0;
	if (SSOutlyerFlag == 2){
		//Check to see if outlyer is one of the sequences
		if (LFlag == 0){
			if (s1 == so){
				s1 = s1 + 1;
				s2 = s1 + 1;
				s3 = s2 + 1;
				
			}
			else if (s2 == so){
			
				s2 = s2 + 1;
				s3 = s2 + 1;
			}
			else if (s3 == so) {
				s3 = s3 + 1;
			
			}
			
		}
		else{
			if (s1 == so || s2 == so || s3 == so ){
				s3 = -1;
				*Seq3 = s3;
				return(1);
			}
		}
		if (s3 > NextNo) {
			
			*Seq1 = s1;
			*Seq2 = s2;
			*Seq3 = s3;
			*oSeq = so;
			return(1);

		}

	}
	else if (SSOutlyerFlag == 1){// ' Find outlyer seq if necessary 0 = use rndseq, 2 = use most distant seq
		
		while (s1==s1){
			if (TreeDistance[s1 + s2*off1] > TreeDistance[s1 + s3*off1]){
				INS = s1;
				OLS = s3;
			}
			else if (TreeDistance[s1 + s3*off1] > TreeDistance[s1 + s2*off1]){
				INS = s1;
				OLS = s2;
			}
			else {
				INS = s2;
				OLS = s1;
			}
                        
			CTD = 0.0;
			//////////////////////////
			
			for (X = 0; X <= PermNextNo; X++){
				if (TreeDistance[OLS + X*off1] < TreeDistance[OLS + INS*off1]){
					if (TreeDistance[OLS + X*off1] >= CTD){ 
						if (X != OLS){
							////////////////////
							if (TreeDistance[OLS + X*off1] == CTD){
								if (Distance[OLS + X*off3] > Distance[OLS + so*off3]){
									GoOn = 1;
									if (SEventNumber > 0){
										for (Z = 0; Z <=LS; Z++){
											if (MissingData[Z + X*off2] == 1){
												if (MissingData[Z + s1*off2] == 0){
													if (MissingData[Z + s2*off2] == 0){
														if (MissingData[Z + s3*off2] == 0){
															GoOn = 0;
															break;
														}
													}
												}
												
											}
										}
                            
									}
									if (GoOn == 1){
										so = X;
										CTD = TreeDistance[OLS + X*off1];
                            
									}
								}
							}
							
							////////////////////
							else{
								GoOn = 1;
								if (SEventNumber > 0){
									for (Z = 0; Z <=LS; Z++){
										if (MissingData[Z + X*off2] == 1){
											if (MissingData[Z + s1*off2] == 0){
												if (MissingData[Z + s2*off2] == 0){
													if (MissingData[Z + s3*off2] == 0){
														GoOn = 0;
														break;
													}
												}
											}
											
										}
									
									}
								}
								if (GoOn == 1){
									so = X;
									CTD = TreeDistance[OLS + X*off1];
                        
								}
							}

							//////////////////
						}
					}
                
				}
			}









			////////////////////////
			if (CTD > 0)
				break;
			
			
			MDist = 1;
			WinX = -1;
			for (X = 0; X <= NextNo; X++){
				if (TraceSub[X] != TraceSub[s1]){
					if (TraceSub[X] != TraceSub[s2]){
						if (TraceSub[X] != TraceSub[s3]){
                
							TDist = (Distance[X + s1*off3] + Distance[X + s2*off3] + Distance[X + s3*off3]) / 3;
							if (TDist < MDist){
								GoOn = 1;
								if (SEventNumber > 0){
									for (Z = 0; Z <=LS; Z++){
											if (MissingData[Z + X*off2] == 1){
												if (MissingData[Z + s1*off2] == 0){
													if (MissingData[Z + s2*off2] == 0){
														if (MissingData[Z + s3*off2] == 0){
															GoOn = 0;
															break;
														}
													}
												}
												
											}
									
									}
								}
								if (GoOn == 1){
									MDist = TDist;
									WinX = X;
                        
								}
							}
						}
					}
				}
				
            
			}
			

			/////////////////////////
			if (WinX == -1){
            
				MDist = 1;
				WinX = -1;
				for (X = 0; X <= NextNo; X++){
					if (TraceSub[X] != TraceSub[s1]){
						if (TraceSub[X] != TraceSub[s2]){
							if (TraceSub[X] != TraceSub[s3]){
								TDist = (Distance[X + s1*off3] + Distance[X + s2*off3] + Distance[X + s3*off3]) / 3;
								if (TDist < MDist){
									GoOn = 1;
									if (SEventNumber > 0){
										for (Z = 0; Z <=LS; Z++){
											if (MissingData[Z + X*off2] == 1){
												if (MissingData[Z + s1*off2] == 0){
													if (MissingData[Z + s2*off2] == 0){
														if (MissingData[Z + s3*off2] == 0){
															GoOn = 0;
															break;
														}
													}
												}
												
											}
											
										}
									}
									if (GoOn == 1){
										MDist = TDist;
										WinX = X;
                    
									}
								}
							}
						}
					}
                
				}
			}
			if (WinX == -1){
				minmiss = LS;
            
				MDist = 1;
				WinX = -1;
				for (X = 0; X <= NextNo; X++){
					curmiss = 0;
					if (TraceSub[X] != TraceSub[s1]){
						if (TraceSub[X] != TraceSub[s2]){
							if (TraceSub[X] != TraceSub[s3]){
								TDist = (Distance[X + s1*off3] + Distance[X + s2*off3] + Distance[X + s3*off3]) / 3;
								if (TDist < MDist){
									GoOn = 1;
									if (SEventNumber > 0){
										for (Z = 0; Z <=LS; Z++){
											if (MissingData[Z + X*off2] == 1){
												if (MissingData[Z + s1*off2] == 0){
													if (MissingData[Z + s2*off2] == 0){
														if (MissingData[Z + s3*off2] == 0)
															curmiss = curmiss + 1;
                                        
													}
												}
											}
										}
										
										if (curmiss < minmiss){
											minmiss = curmiss;
											WinX = X;
										}
									}
								}
							}
						}
					}
				}
                        
			}
			
			so = WinX;
        
			break;
		}
		
                                            
	}

	*Seq1 = s1;
	*Seq2 = s2;
	*Seq3 = s3;
	*oSeq = so;

	return(1);
}



int FAR pascal BSSubSeq (int lenseq, int seq1, int seq2, int seq3,short int *seqnum, int *xposdiff, int *xdiffpos, char *scores)
{
	int x, y, os1, os2;
	short int s1, s2, s3;
	y=0;
	os1 = lenseq+1;
	os2 = 2*os1;
	for(x = 1; x <=lenseq; x++){
		s1 = *(seqnum + x + seq1*os1);
		s2 = *(seqnum + x + seq2*os1);
		s3 = *(seqnum + x + seq3*os1);
		xposdiff[x] = y;
		if (s1 != 46){
			if (s2 != 46){
				if (s3 != 46){
					if (s1 != s2 || s1 != s3 || s2 != s3){
						y++;
						if (s1 ==  s2){
							*(scores + y) = 1;
							*(scores + y + os1) = 0;
							*(scores + y + os2) = 0;
						}
						else if (s1 == s3){
							*(scores + y) = 0;
							*(scores + y + os1) = 1;
							*(scores + y + os2) = 0;
						}
						else if (s2 == s3){
							*(scores + y) = 0;
							*(scores + y + os1) = 0;
							*(scores + y + os2) = 1;
						}
						else{
							*(scores + y) = 0;
							*(scores + y + os1) = 0;
							*(scores + y + os2) = 0;
						}
						
						xdiffpos[y] = x;
						xposdiff[x] = y;
					}
				}
			}
		}
	}
	return y;
}




double FAR pascal SEQBOOT (int nseed,short int bsbootreps, int bsstepwin,short int *scratch, int *weightmod)
{

	int y,x,rndnum,rndnum2;
	double rn, rm;
	double  rf, bs, bs2;
	srand(nseed);
	rn = rand();
	rm = RAND_MAX;
	for (y  = 0; y <= bsbootreps; y++){
        for (x = 1; x<= bsstepwin; x++)
            *(weightmod + (x-1)*(bsbootreps+1) + y) = 1;
    }
	bs2 = (double)(bsstepwin-1);
	bs = (double)(bsstepwin / 4);
    for(y = 1; y <= bsbootreps; y++){
        for (x = 0; x <= bsstepwin; x++)
			scratch[x] = 0;
			
		rn = rand();
		rf = bs + (rn/rm)*bs;
		rndnum2 = (int)(rf);

		
		for (x = 1; x <= rndnum2; x++){ 

			do{
                rn = rand();
				
				rf = (rn / rm)*bs2 + 1;
				rndnum = (int)(rf);
				//RndNum = CLng(((BSStepWin - 1) * Rnd) + 1)
            //Loop While Scratch(RndNum - 1) = 1
			}while (scratch[rndnum-1] == 1);
			
			scratch[rndnum - 1] = 1;
			*(weightmod + (rndnum - 1)*(bsbootreps+1) + y) = 0;

			do{
				rn = rand();
				rf = (rn / rm)*bs2 + 1;
				rndnum = (int)(rf);
			} while (*(weightmod +(rndnum - 1)*(bsbootreps+1) + y) == 0);

			*(weightmod + (rndnum - 1)*(bsbootreps+1) + y) = *(weightmod + (rndnum - 1)*bsbootreps + y) + 1;
			scratch[rndnum - 1] = 1;
		}
	}

	return(1);
}

double FAR pascal SEQBOOT2 (int nseed,short int bsbootreps, int bsstepwin,short int *scratch, int *weightmod)
{

	int rfx, y,x;
	double rn, rm;
	double  bs, bs2;
	srand(nseed);
	rn = rand();
	rm = RAND_MAX;
	
	for (x = 1; x<= bsstepwin; x++)
            *(weightmod + (x-1)*(bsbootreps+1)) = 1;
	for (y  = 1; y <= bsbootreps; y++){
        for (x = 1; x<= bsstepwin; x++)
            *(weightmod + (x-1)*(bsbootreps+1) + y) = 0;
    }

	bs = bsstepwin;
    bs2 = bsstepwin-1;
			
		rn = rand();
		
		

		
		for (x = 1; x <= bs; x++){ 

			for (y=1; y <= bsbootreps; y++){
				rn = rand();
				rfx = (int)((rn / rm)*bs2);
				*(weightmod + y + rfx*(bsbootreps+1)) = *(weightmod + y + rfx*(bsbootreps+1)) + 1;
			}
		}

				
		
	
	return(1);
}

int FAR pascal MakeV (double freqa,double freqc,double freqg,double freqt,double freqar,double freqgr,double freqcy,double freqty, double cvi,double fracchange, double xv,short int tmodel, int numsp, int sites,int endsite,int *weight,short int *xx1, short int *xx2, short int *px, double *prod, double *prod2, double *prod3, double *dmat)
{
  /* compute one distance */
  int num1, num2,m,n,i, it, idx,denominator;
  denominator=0;
  double numerator;
  numerator=0.0;
  double  ratxv, sum, sum1, sum2, sumyr, lz, aa, bb, cc, vv, p1, p2, p3, q1, q2, q3,
	 tt, delta, slope, xx1freqa, xx1freqc, xx1freqg, xx1freqt,
	 y1, z1, rat,  z1xv, z1yy ,z1zz , th1 , th2, th3, th4;

  th1 =0.0;
  //double *prod, *prod2, *prod3;
  short int h1, h2, b, quick, jukesquick, kimquick, jinneiquick, iterations;
  
  iterations = 1000;
  ratxv = xv;
  rat = 1.0;
  for (m=1; m <= numsp - 1;m++){
	  for(n=m+1; n <= numsp; n++){
		  quick = 1;
		  vv=0;
		  if (tmodel == 0) {
			numerator = 0;
			denominator = 0;
			for (i = 0; i < endsite; i++) {
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) = 0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) = 1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  sum = 0.0;
			  sum1 = 0.0;
			  sum2 = 0.0;
			 for (b = 0; b <= 3; b++) {
				sum1 += *(xx1 + b);
				sum2 += *(xx2 + b);
				sum += *(xx1 + b) * *(xx2 + b);
			  }
			  if (quick == 1 && (sum1 == 1.0 || sum1 == 4.0) && (sum2 == 1.0 || sum2 == 4.0))
				  quick == 1;
			  else
				  quick == 0;
			  if (sum1 == 1.0 && sum2 == 1.0) {
				numerator += (*(weight + i) * sum);
				denominator += *(weight + i);
			  }
			}
		  }
  
		  if (tmodel == 0 && quick == 1)
			  jukesquick = 1;
		  else
			  jukesquick = 0;

		  if (tmodel == 1 && quick == 1)
			  kimquick = 1;
		  else
			  kimquick = 0;

		  if (tmodel == 2 && quick == 1)
			  jinneiquick = 1;
		  else
			  jinneiquick = 0;
  
		  //vv = numerator / denominator;
		  //vv = -0.75 * log((4.0 * (numerator / denominator) - 1.0) / 3.0);
		  //return vv;
		  if (jukesquick == 1)
			  th1 = (numerator / denominator);
			  th2 = (4.0 * th1 - 1.0) / 3.0;
			  th3 = log(th2);
			  vv = -0.75 * th3;
		  if (kimquick == 1 || jinneiquick == 1) {
			num1 = 0;
			num2 = 0;
			denominator = 0;
			for (i = 0; i < endsite; i++) {
			  //memcpy(xx1, p->x[i], sizeof(sitelike));
			  //memcpy(xx2, q->x[i], sizeof(sitelike));
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) =0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) = 1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  sum = 0.0;
			  sum1 = 0.0;
			  sum2 = 0.0;
			  for (b = 0; b <= 3; b++) {
				sum1 += *(xx1 + b);
				sum2 += *(xx2 + b);
				sum += *(xx1 + b) * *(xx2 + b);
			  }
			  //sumyr = (*(xx1) + *(xx1 + 2))
			  //      * (*(xx2) + *(xx2 + 2)) +
			  //        (*(xx1 + 1) + *(xx1 + 3)) *
			  //        (*(xx2 + 1) + *(xx2 + 3));
			  sumyr = (xx1[0] + xx1[2])
					* (xx2[0] + xx2[2]) +
					  (xx1[1] + xx1[3]) *
					  (xx2[1] + xx2[3]);


			  if (sum1 == 1.0 && sum2 == 1.0) {
				num1 += (int)(*(weight + i) * sum);
				num2 += (int)(*(weight + i) * (sumyr - sum));
				denominator += *(weight + i);
			  }
			}
			
			tt = 1.0 - num1 / denominator;
			//return tt;
			if (tt > 0.0) {
			  delta = 0.1;
			  tt = delta;
			  it = 0;
			  while (fabs(delta) > 0.00002 && it < iterations) {
			it++;
			if (tmodel == 1) {
			  p1 = exp(-tt);
				  p2 = exp(-xv * tt) - exp(-tt);
				  p3 = 1.0 - exp(-xv * tt);
			} else {
			  p1 = exp(-cvi * log(1 + tt / cvi));
			  p2 = exp(-cvi * log(1 + xv * tt / cvi))
					  - exp(-cvi * log(1 + tt / cvi));
			  p3 = 1.0 - exp(-cvi * log(1 + xv * tt / cvi));
			}
			q1 = p1 + p2 / 2.0 + p3 / 4.0;
			q2 = p2 / 2.0 + p3 / 4.0;
			q3 = p3 / 2.0;

			if (tmodel == 1){
				th1 = 0.5 * exp(-tt) * (num2 / q2 - num1 / q1);
				th2 = 0.25 * xv * exp(-xv * tt);
				th3 = ((denominator - num1 - num2) * 2.0 / q3 - num2 / q2 - num1 / q1);
				th4 = th2*th3;
			}
			else{
				th1 = 0.5 * (1 / (1 + tt / cvi)) * exp(-cvi * log(1 + tt / cvi)) * (num2 / q2 - num1 / q1);
				th2 = 0.25 * (xv / (1 + xv * tt / cvi)) * exp(-cvi * log(1 + xv * tt / cvi));
				th3 = ((denominator - num1 - num2) * 2 / q3 - num2 / q2 - num1 / q1);
				th4 = th2*th3;
			}
			slope  =  th1 + th4;
				//return slope;
			if (slope < 0.0)
			  delta = fabs(delta) / -2.0;
			else
			  delta = fabs(delta);
			tt += delta;
			  }
			}
			vv = fracchange * tt;

		  }
		  if (jukesquick == 0 && kimquick == 0 && jinneiquick == 0) {
			//prod = (double *)malloc(sites*sizeof(double));
			//prod2 = (double *)malloc(sites*sizeof(double));
			//prod3 = (double *)malloc(sites*sizeof(double));
			for (i = 0; i < endsite; i++) {
			  h1 = *(px + i*numsp + (m-1));
			  h2 = *(px + i*numsp + (n-1));
				  if (h1 < 4){
					*(xx1) = 0;
					*(xx1 + 1) = 0;
					*(xx1 + 2) = 0;
					*(xx1 + 3) = 0;
					*(xx1 + h1) =1;
				  }
				  else {
					*(xx1) = 1;
					*(xx1 + 1) = 1;
					*(xx1 + 2) = 1;
					*(xx1 + 3) = 1;
				  }

				if (h2 < 4){
					*(xx2) = 0;
					*(xx2 + 1) = 0;
					*(xx2 + 2) = 0;
					*(xx2 + 3) = 0;
					*(xx2 + h2) =1;
				  }
				  else {
					*(xx2) = 1;
					*(xx2 + 1) = 1;
					*(xx2 + 2) = 1;
					*(xx2 + 3) = 1;
				  }
			  xx1freqa = xx1[0] * freqa;
			  xx1freqc = xx1[1] * freqc;
			  xx1freqg = xx1[2] * freqg;
			  xx1freqt = xx1[3] * freqt;
			  sum1 = xx1freqa + xx1freqc + xx1freqg + xx1freqt;
			  sum2 = freqa * xx2[0] + freqc * xx2[1] +
					 freqg * xx2[2] + freqt * xx2[3];
			  prod[i] = sum1 * sum2;
			  prod2[i] = (xx1freqa + xx1freqg) *
						 (xx2[0] * freqar + xx2[2] * freqgr) +
				  (xx1freqc + xx1freqt) *
				  (xx2[1] * freqcy + xx2[3] * freqty);
			  prod3[i] = xx1freqa * xx2[0] + xx1freqc * xx2[1] +
				 xx1freqg * xx2[2] + xx1freqt * xx2[3];
			}
			tt = 0.1;
			delta = 0.1;
			it = 1;
			while (it < iterations && fabs(delta) > 0.00002) {
			  slope = 0.0;
			  if (tt > 0.0) {
			  lz = -tt;
			  z1 = exp(ratxv * lz);
			  y1 = 1.0 - z1;
			  z1zz = exp(rat * lz);
			  z1yy = z1 - z1zz;
			  z1xv = z1 * xv;
        
				for (i = 0; i < endsite; i++) {
				  idx = 1;
				  cc = prod[i];
				  bb = prod2[i];
				  aa = prod3[i];
			  slope += weight[i] * (z1zz * (bb - aa) +
				z1xv * (cc - bb)) /
				  (aa * z1zz + bb * z1yy + cc * y1);
				}
			  }
			  if (slope < 0.0)
			delta = fabs(delta) / -2.0;
			  else
			delta = fabs(delta);
			  tt += delta;
			  it++;
			}
			vv = tt * fracchange;
			for (i = 0; i <endsite; i++){ 
			   prod[i] = 0;
			   prod2[i] = 0;
			   prod3[i] = 0;
			}
		  }
		*(dmat + m-1 + (n-1)*numsp) = vv;
		*(dmat + n-1 + (m-1)*numsp ) = vv;
	}
  }
    
    
  return 1;
  //return 0.022;
}  /* makev */


int FAR pascal ScanPositive (int winnum, double bscutoff, int cocount, int x , int y, int numberofseqs, short int bootreps,int *goona, int *goonb, char *orderarray, float *dstmat)
{
	long cnt;
	int his, los1, los2, a, z, fcount,l1, l2;
	his=0;
	los1=0;
	los2=0;
	double hislos1, hislos2, los1los2;
	int co;
	co = (int)(bscutoff * bootreps);
	if (winnum > 255)
		winnum = 255;
	cnt = 0;
	for (z = y + 1; z <= numberofseqs;z++){
		
		//if (*(goona + cnt) == 0) {
			if(*(orderarray + cnt) == 0){ 
				his = x;
                los1 = y;
                los2 = z;
			}
			else if(*(orderarray + cnt) == 1){
                his = x;
                los1 = z;
                los2 = y;
			}
            else if(*(orderarray + cnt) == 2){
                his = y;
                los1 = z;
                los2 = x;
			}
			hislos1 = *(dstmat+(bootreps + 1)*(numberofseqs+1)*(his) + (bootreps +1)*(los1) + 0);
			hislos2 = *(dstmat+(bootreps + 1)*(numberofseqs+1)*(his) + (bootreps +1)*(los2) + 0);
			los1los2 = *(dstmat+(bootreps + 1)*(numberofseqs+1)*(los1) + (bootreps +1)*(los2) + 0);
			
			if (hislos1 > los1los2 || hislos1 > hislos2){
				
				fcount = 0;
                l1 = 1;
                l2 = 1;
                for (a = 1; a < bootreps;a++){
					hislos1 = *(dstmat+(bootreps + 1)*(numberofseqs+1)*(his ) + (bootreps +1)*(los1) + a);
					hislos2 = *(dstmat+(bootreps + 1)*(numberofseqs+1)*(his ) + (bootreps +1)*(los2 ) + a);
					los1los2 = *(dstmat+(bootreps + 1)*(numberofseqs+1)*(los1) + (bootreps +1)*(los2) + a);
					if (hislos1 < los1los2 && hislos1 < hislos2){
						fcount++;
						if(fcount > cocount)
							break;
					}
                    else if (los1los2 < hislos2)
						l1++;
                    else if (los1los2 > hislos2)
                        l2++;
				}
				if (fcount <= cocount && (l1 >= co || l2 >= co)){
					if (*(goona + cnt) ==0)
						*(goona + cnt) = winnum;
					*(goonb + cnt) = winnum;
				}
					
			}
		//}
        cnt++;

	}

	return cnt;
}


 int FAR pascal SeqMatrixCopy(short int nextno, short int groupnumber,double *seqmatrix,double *seqmatrixbak)
  {
	//int x = x;
	int arraysize = (groupnumber+1)*(groupnumber+1)*25;
	for (int pos = 0;pos < arraysize; pos++){
		*(seqmatrixbak + pos) = *(seqmatrix + pos);//.44;//*(seqmatrix + pos);

}
	return(1);//(*(seqmatrix+6))*1000);
}


  
 int FAR pascal SpacerFindB(short int Nextno, short int SpacerFlag, double MiDistance, double MaDistance, short int Seq1,short int Seq2,short int Seq3, short int *OL,short int *SN, float *TreeDistance, float *Distance, short int *MaskSeq, short int *SpacerSeqs, short int *ValidSpacer)
 {
	short int SpacerNo, InlyerA, InlyerB, Outlyer, InRangeFlag;
    int X;
	double tdao,tdab, tdx, tdy, tdz, d1, d2;
	
	tdx = *(TreeDistance + Seq1 + Seq2*(Nextno+1));
	tdy = *(TreeDistance + Seq1 + Seq3*(Nextno+1));
	tdz = *(TreeDistance + Seq2 + Seq3*(Nextno+1));

    if (tdx < tdz && tdy < tdz){ 
        InlyerA = Seq2;
        InlyerB = Seq3;
        Outlyer = Seq1;
		tdao = tdx;
		tdab = tdz;
	}
    else if(tdx < tdy && tdz < tdy){
        InlyerA = Seq1;
        InlyerB = Seq3;
        Outlyer = Seq2;
		tdao = tdx;
		tdab = tdy;
	}
    else {
        InlyerA = Seq1;
        InlyerB = Seq2;
        Outlyer = Seq3;
		tdao = tdy;
		tdab = tdx;
    }
    
    InRangeFlag = 1;
    
    if (MiDistance > 0 || MaDistance < 1){
        d1 = *(Distance + Outlyer + InlyerA*(Nextno + 1));
		d2 = *(Distance + Outlyer + InlyerB*(Nextno + 1));

		if ((d1 > MiDistance || d2 > MiDistance) && (d1 < MaDistance || d2 < MaDistance)) 
            InRangeFlag = 1;
        else
            return (0);
    }
    
    SpacerNo = 0;
    
    if (SpacerFlag == 1){ 

        for (X = 0; X <= Nextno; X++){ 

            if (MaskSeq[X] < 2){
				tdx = *(TreeDistance + X + InlyerA*(Nextno + 1));
				tdy = *(TreeDistance + X + Outlyer*(Nextno + 1));
                if (X != InlyerA && X != InlyerB && X != Outlyer){ 
                    if (tdx < tdab) {
    
                        if (tdx > tdao){
    
                                SpacerNo++;
                                SpacerSeqs[SpacerNo] = X;
                                ValidSpacer[SpacerNo] = 1;
						}
                        else if (tdx == tdao && tdy < tdab){
    
                                SpacerNo++;
                                SpacerSeqs[SpacerNo] = X;
                        
                        }
                    }
                }
            }
        }
	}
    else if (SpacerFlag == 2){

        for (X = 0; X <= Nextno; X++){

            if (MaskSeq[X] < 2){
				tdx = *(TreeDistance + X + InlyerA*(Nextno + 1));
                if (tdx < tdab){

                    if (X != InlyerA && X != InlyerB && X != Outlyer){
                        SpacerNo++;
                        SpacerSeqs[SpacerNo] = X;
                    }
                }
            }
        }
	}
    else if (SpacerFlag == 3){

        for (X = 0; X <= Nextno; X++){

            if (MaskSeq[X] < 2){
				tdx = *(TreeDistance + X + Outlyer*(Nextno + 1));
                if(tdx < tdao){

                    if (X != InlyerA && X != InlyerB && X != Outlyer){
                        SpacerNo++;
                        SpacerSeqs[SpacerNo] = X;
                    }
                }
            }
		}
    }
	*SN = SpacerNo; 
	*OL = Outlyer;
	return 1;
 }

  int FAR pascal SeqMatrixMan1(short int nextno, short int seqnumber, short int groupnumber,short int level,double discrepancy,int *numingroup, short int *seqcode,double *seqmatrix)
  {
	  
	  //int x = x;

	  //if (level=0){
		for (int pos1 = 0;pos1 < groupnumber+1; pos1++){
			//*(seqmatrixbak + pos) = *(seqmatrix + pos);//.44;//*(seqmatrix + pos);
			
			for (int pos2 = pos1;pos2 < groupnumber+1; pos2++){
				//*(seqmatrixbak + pos) = *(seqmatrix + pos);//.44;//*(seqmatrix + pos);
				//if ( *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) != 1){
					//*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1)  =  *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) * discrepancy;
					*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) *= pow(discrepancy,(*(numingroup + pos1)));
					*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) *= pow(discrepancy,(*(numingroup + pos2)));
				
				//}
				
								    
				
			}
			
	
		}

	  //}
	  //if (level=1){
		//for (int pos1 = 0;pos1 < groupnumber+1; pos1++){
		//	//*(seqmatrixbak + pos) = *(seqmatrix + pos);//.44;//*(seqmatrix + pos);
		//	
		//	for (int pos2 = 0;pos2 < groupnumber+1; pos2++){
		//		//*(seqmatrixbak + pos) = *(seqmatrix + pos);//.44;//*(seqmatrix + pos);
		//  
		//		if ( *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) != 1){
		//			*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1)  *= discrepancy;//=  *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1)* discrepancy;
		//			//return (*(seqcode + pos1 * (nextno+1) + seqnumber));
		//		}
		//			//*(seqmatrix + pos1*(groupnumber+1)*4*(groupnumber+1)*4 + *(seqcode + seqnumber*(groupnumber+1) + pos1) * (groupnumber+1) * 4 + pos2*4 + *(seqcode + seqnumber*(groupnumber+1) + pos2)) =* discrepancy^numingroup(pos2);
		//		
		//
		//	}
			
	
		//}

	  //}

	  return(1);
  }


  int FAR pascal SeqMatrixMan3(short int nextno, short int seqnumber, short int groupnumber,short int level,double discrepancy,int *numingroup, short int *seqcode,double *seqmatrix)
  {
	  
	  //int x = x;

	  //if (level=0){
		for (int pos1 = 0;pos1 < groupnumber+1; pos1++){
			//*(seqmatrixbak + pos) = *(seqmatrix + pos);//.44;//*(seqmatrix + pos);
			
			for (int pos2 = 0;pos2 < groupnumber+1; pos2++){
					*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) = pow(discrepancy,(*(numingroup + pos1)));
					*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) *= pow(discrepancy,(*(numingroup + pos1)));
								    
				
			}
			
	
		}

	  return(1);
  }

  int FAR pascal DoSetsA( int SZ1, int lseq, int *RI,char *OLSeq, char *Sets, char *doit){
	 //sets -2,nextno
	  int Z,A,OL, SZ2;
	  unsigned int ri0,ri1,ri2;
	  ri0=RI[0]*3;
	  ri1=RI[1]*3;
	  ri2=RI[2]*3;
	  float sz1h, sz2h, olh;
	  OL = 0;
	  if (RI[4] < RI[5]){
		SZ2 = RI[5] - RI[4] + 1;
        for (A = RI[4]; A <= RI[5]; A++)
			OL = OL + OLSeq[A];
                        
	  }
	  else{
		SZ2 = RI[5] + lseq - RI[4] + 1;
        for (A = RI[4]; A <= lseq; A++)
			OL = OL + OLSeq[A];
        for (A = 1; A <= RI[5]; A++)
			OL = OL + OLSeq[A];

	  }
	  sz1h = (float)(SZ1);
	  sz2h = (float)(SZ2);
	  olh = (float)(OL);
      if (olh / ((sz1h + sz2h) / 2) > 0.3){
		  for (Z = 0; Z <3; Z++){
			  if (doit[Z] == 1){
					Sets[Z + ri0] = 1;
					Sets[Z + ri1] = 1;
					Sets[Z + ri2] = 1;
			  }
		  }
	  }
	return(1);
  }

  int FAR pascal DoSetsB(int SZ1, int lseq, int *RI,char *OLSeq){
	 //sets -2,nextno
	  int A,OL, SZ2;
	  float sz1h, sz2h, olh;
	  OL = 0;
	  if (RI[4] < RI[5]){
		SZ2 = RI[5] - RI[4] + 1;
        for (A = RI[4]; A <= RI[5]; A++)
			OL = OL + OLSeq[A];
                        
	  }
	  else{
		SZ2 = RI[5] + lseq - RI[4] + 1;
        for (A = RI[4]; A <= lseq; A++)
			OL = OL + OLSeq[A];
        for (A = 1; A <= RI[5]; A++)
			OL = OL + OLSeq[A];

	  }
		//return(OL);
	  sz1h = (float)(SZ1);
	  sz2h = (float)(SZ2);
	  olh = (float)(OL);
      if (olh / ((sz1h + sz2h) / 2) > 0.3)
		return(1);
	  else
		return(0);
  }

 int FAR pascal MakeOLSeqB(int BE, int en, int lseq, char *OLSeq){
	int X;
	X = BE;
	while (X != en){
		OLSeq[X] = 1;
		X++;
		if (X > lseq)
			X = 1;
		
	}
	return(0);
 }

int FAR pascal SeqMatrixMan2(short int nextno, short int seqnumber, short int groupnumber,short int level,double discrepancy,int *numingroup, short int *seqcode,double *seqmatrix)
  {
	  
	  
	  //if (level=1){
		for (int pos1 = 0;pos1 < groupnumber+1; pos1++){
			//*(seqmatrixbak + pos) = *(seqmatrix + pos);//.44;//*(seqmatrix + pos);
			
			for (int pos2 = pos1;pos2 < groupnumber+1; pos2++){
				//*(seqmatrixbak + pos) = *(seqmatrix + pos);//.44;//*(seqmatrix + pos);
		  
				//if ( *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) != 1){
					*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1)  *= discrepancy;//=  *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1)* discrepancy;
					//return (*(seqcode + pos1 * (nextno+1) + seqnumber));
				//}
					//*(seqmatrix + pos1*(groupnumber+1)*4*(groupnumber+1)*4 + *(seqcode + seqnumber*(groupnumber+1) + pos1) * (groupnumber+1) * 4 + pos2*4 + *(seqcode + seqnumber*(groupnumber+1) + pos2)) =* discrepancy^numingroup(pos2);
			
					
					
					
					
					if ( *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) >= 1){
						*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1)=1;
					}



		
			}
			
	
		}

	  //}

	  return(1);
  }


/*int FAR pascal AdjThresholdDown4(HDC pict,short int xval,short int yval,short int ocutoff,short int cutoff,short int *picinfo)
  {

  	
	int offset = 50 + 1;
	int vertpos= -(xval+offset);
	short int pixcol ;
	
	for (int ypos = 0;ypos < yval; ypos ++){
		vertpos += xval + offset;
		for (int xpos = 0;xpos < xval; xpos+=5){
			pixcol=*(picinfo + xpos + vertpos);
			if (pixcol >= cutoff){
				if (pixcol < ocutoff){
				 		SetPixel(pict, xpos, ypos, 255);
				}
				
			}	
				//	do{
				//		if (*(picinfo + xpos + ypos) >= cutoff){//(picinfo[xpos][ypos] >= cutoff){
				//			
				//			xpos = xpos + 1;
				//		}
				//	} while (*(picinfo + xpos + ypos) >= cutoff2);
		
		}
	}
	return(1);

   } */



 int FAR pascal SeqTally(short int nextno, short int seqnumber, short int groupnumber,short int level,double *tally,int *numingroup, short int *seqcode,double *seqmatrix)
  {
	  
	int component = 0;	  
	  //if (level=1){
		for (int pos1 = 0;pos1 < groupnumber+1; pos1++){
			for (int pos2 = pos1;pos2 < groupnumber+1; pos2++){
				//if ( *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1) != 1){
				//component = pow(*(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1),(*(numingroup + pos1)));
				//component = pow (component,(*(numingroup + pos1)));
				*tally *= *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1);
				component=component+1;
				if (pos2 > pos1){
					*tally *= *(seqmatrix + *(seqcode + pos2 * (nextno+1) + seqnumber) * (groupnumber+1)*5*(groupnumber+1) + pos2 * 5 * (groupnumber+1) + *(seqcode + pos1 * (nextno+1) + seqnumber)*(groupnumber+1) + pos1);
					component=component+1;
				}
		
			}
			
	
		}

	  //}

	  return(component);
  }


  int FAR pascal CopyArray(short int xval,short int yval, short int *picinfo,short int *picinfobak)
  {
	
	int offset = xval+50 - xval + 1;
	int initoffset = 0 - offset;
	int vertpos = -(xval+offset);//vertpos;
	for (int ypos = 0;ypos < yval; ypos++){
		vertpos += xval+offset;//(xval*ypos)+initoffset;
		for (int xpos = 0;xpos < xval; xpos++){
			
			
			*(picinfobak + xpos + vertpos) = *(picinfo + xpos +vertpos);

		}
	} 
	return(1);
  }



int FAR pascal CopyArray2(short int xval,short int yval, short int *picinfo,short int *picinfobak)
  {
	
	int offset = xval+50 - xval + 1;
	int initoffset = 0 - offset;
	int vertpos = -(xval+offset);//vertpos;
	for (int ypos = yval;ypos > 0; ypos--){
		vertpos += xval+offset;//(xval*ypos)+initoffset;
		for (int xpos = 0;xpos < xval; xpos++){
			
			
			*(picinfobak + xpos + vertpos) = *(picinfo + xpos +vertpos);

		}
	} 
	return(1);
  }

int FAR pascal ShiftDown(short int diffspace,int lseq,short int lastdim,short int lastend, short int *parray)
  {

	
	for (int y = lastend + 1;y < lastdim; y++){

	
        
        for (int z = 0;z < lseq; z++){
            *(parray + (lastdim - y + diffspace+lastend)*lseq + z) = *(parray + (lastdim-y+lastend)*lseq + z);
        }
        
    
	}
	return(1);
  }


int FAR pascal ShiftUp(short int diffspace,int lseq,short int lastdim,short int lastend, short int *parray)
  {

	
	for (int y = lastend + 1;y < lastdim; y++){

	
        
        for (int z = 0;z < lseq; z++){
            *(parray + (y + diffspace)*lseq + z) = *(parray + y*lseq + z);
        }
        
    
	}
	return(1);
  }

int FAR pascal CopyArray3(short int lseq,short int lastdim,short int lastend, short int offsetp,short int offsett,short int *parray, short int *tarray)
  {

	
	for (int y = lastend + 1;y < lastdim; y++){

	
        
        for (int z = 0;z < lseq; z++){
            *(parray + (y+offsetp)*lseq + z) = *(tarray + (y+offsett)*lseq + z);
        }
        
    
	}
	return(1);
  }

int FAR pascal FillArray(short int fillval,int rbegin,int utarget,int lseq,short int spos, short int *parray,short int *maxspos)
  {


	for (int z = rbegin;z < utarget; z++){
		*(parray + z) = fillval;
		if (spos >= *(maxspos+z)){
			*(maxspos + z) = spos+1;
		}
    }

	return(1);
  }

int FAR pascal FillArray2( double a, int fillval,int rbegin,int utarget,int lseq,int spos, short int *parray,short int *maxspos)
  {

	int z;
	
	for (z = rbegin;z < utarget; z++){
		*(parray + (int)(z*a)) = fillval;
		if (spos >= *(maxspos+z))
			*(maxspos + z) = spos+1;
		
    }

	return(1);
  }

int far pascal FillArray3(int LCA, float fv, float *CurveArray){
	int x; 
	for (x = 0; x <= LCA; x++)
        CurveArray[x] = fv;

	return(1);
}
   


int FAR pascal CurveRight(int LCA, int ZoomR, int PosX, float SWin, float IncX2, float XFactor, float PZ2, float XF2, float *CurveArray){
	int X;
	float dos, RealDist, x;
	for (X = PosX + 1; X <= ZoomR - 1; X++){
    
		dos = (float)((X - PosX) * XFactor);
		RealDist = (float)((dos - (dos * ((1 + (IncX2 * (X - PosX))) / XF2))) / XFactor / PZ2);
		CurveArray[X] = (float)((X + RealDist) / X) ;
		x = (float)X;
		if (CurveArray[X] * x > LCA)
			CurveArray[X] = (float)(LCA) / x;
		
    
	}
 return(1);
}

int FAR pascal MakeTestStrip(int UBX, float XFactor, int *XDiffPos, float *Teststrip) {
	int X;
	float Xpos, LB, RB;
	for (X = 0; X<= UBX; X++){
        if (XDiffPos[X] > 0){
            Xpos = 30 + (float)(XDiffPos[X])* XFactor;
            LB = (float)(Xpos - 0.5);
            RB = (float)(Xpos + 0.5);
            Teststrip[(int)(LB-0.49)] = Teststrip[(int)(LB-0.49)] + (1 - (LB - int(LB-0.49)));
            Teststrip[(int)(RB-0.49)] = Teststrip[(int)(RB-0.49)]  + (RB - int(RB-0.49));
            
        }
    }

	return(1);

}


int FAR pascal CurveMid(int LCA, int ZoomR, float AddjV, float HSWin2, float *CurveArray){
	
	int X;
	
	for (X = ZoomR; X <= LCA; X++)
        CurveArray[X] = (float)(((HSWin2 + (X - ZoomR) * AddjV)) / X);
    


	return(1);
}
int FAR pascal CurveLeft(int ZoomL, int PosX, float SWin, float IncX, float XFactor, float PZ2, float XF2, float *CurveArray){
	int x;
	float dos, DV, CV, AV, BV, RealDist;
	for (x = ZoomL + 1; x <= PosX - 1; x++){

		dos = (float)((PosX - x) * XFactor / PZ2);
		DV = (float)(1 + (IncX * (PosX - x))) ;
		CV = DV / XF2;
		
		CV = (float)(1 / XF2 + ((XF2 - 1) * (PosX - x)) / (SWin * XF2));
		BV = (float)(dos * CV);
    
		AV = (float)(dos - BV);
		RealDist = (float)( AV / XFactor);
    
		CurveArray[x] = (float)((x - RealDist) / x); 
		if (CurveArray[x] * x < (float)(1.0) )
			CurveArray[x] = (float)(1 / x);
		
    
	}

	return(1);
}

int FAR pascal DrawDiffsC(int SP, int EP, int UBTS, float MaxTS, int UBID1, int UBID2,  float *Teststrip, unsigned char *ImageData){
	int X, Y, off1, off2, off3, RB1, RB2, RB3; 
	float PV1, PV2, PV3;
	//float PixVal;
	unsigned char pv, pv4, pv5, pv6;
	off1 = UBID1+1;
	off2 = (UBID2+1)*off1;
	RB1 = ImageData[0]-10;
	RB2 = ImageData[1]-10;
	RB3 = ImageData[2]-10;
	if (RB1 < 0)
		RB1=0;
	if (RB2 < 0)
		RB2=0;
	if (RB3 < 0)
		RB3=0;
	for (X = 0; X <= UBTS; X++){
        
        if (Teststrip[X] > 0){
            
			/*PixVal = 255 - ((Teststrip[X] * MaxTS) * 255);
            if (PixVal > 180)
                PixVal = 180;
            else if (PixVal < 0)
                PixVal = 0;
			pv = unsigned char(PixVal);*/

			
			PV1 = RB1 - ((Teststrip[X] * MaxTS) * RB1);
            if (PV1 > RB1)
                PV1 = RB1;
            else if (PV1 < 0)
                PV1 = 0;
			pv4 = unsigned char(PV1);

			
			PV2 = RB2 - ((Teststrip[X] * MaxTS) * RB2);
            if (PV2 > RB2)
                PV2 = RB2;
            else if (PV2 < 0)
                PV2 = 0;
			pv5 = unsigned char(PV2);

			PV3 = RB3 - ((Teststrip[X] * MaxTS) * RB3);
            if (PV3 > RB3)
                PV3 = RB3;
            else if (PV3 < 0)
                PV3 = 0;
			pv6 = unsigned char(PV3);

            off3 = X*off1;
            
			for (Y = SP; Y <=EP; Y++){
                ImageData[X*off1 + Y*off2] = pv4;//pv;
				ImageData[1 + off3 + Y*off2] = pv5;//pv;
                ImageData[2 + off3 + Y*off2] = pv6;//pv;
            }
            
        }
    }

	return(1);
}

int FAR pascal DrawDiffsD(int Z, int BkR, int BkG, int BkB, int SP, int EP, int UBTS, float MaxTS, int UBID1, int UBID2,  int *ColAdj, float *Teststrip, unsigned char *ImageData){
	int X, Y, off1, off2, off3, off4, tPVR, tPVG, tPVB;
	
	unsigned char r,g,b;
	off1 = UBID1+1;
	off2 = (UBID2+1)*off1;

	//coladj has bounds 2,2
	off4 = 3;
	for (X = 0; X <= UBTS; X++){
            
            if (Teststrip[X] > 0){
                off3 = X*off1;
                tPVR = (int)(BkR - (BkR / ColAdj[Z] * (Teststrip[X] * MaxTS)));
                tPVG = (int)(BkG - (BkG / ColAdj[Z + off4] * (Teststrip[X] * MaxTS)));
                tPVB = (int)(BkB - (BkB / ColAdj[Z + off4*2] * (Teststrip[X] * MaxTS)));
                
                
                
                if (tPVR > 255)
					tPVR = 255;
                if (tPVG > 255)
					tPVG = 255;
                if (tPVB > 255)
					tPVB = 255;
                if (tPVR < 0) 
					tPVR = 0;
                if (tPVG < 0 )
					tPVG = 0;
                if (tPVB < 0)
					tPVB = 0;
                r = (unsigned char)(tPVR);
				g = (unsigned char)(tPVG);
				b = (unsigned char)(tPVB);

                for (Y = SP; Y <=EP; Y++){
                    ImageData[X*off1 + Y*off2] = r;
					ImageData[1 + off3 + Y*off2] = g;
					ImageData[2 + off3 + Y*off2] = b;
                
                
				}
			}
	


	}
	return(1);
}
int FAR pascal FindSlot(int rbegin,int utarget,short int spos, short int *maxspos)
  {


	for (int z = rbegin;z < utarget; z++){
        //*(parray + lseq*z + spos) = fillval;
		
		if (*(maxspos + z) > spos){
			 spos = *(maxspos + z);
		}
    }

	return(spos);
  }

int FAR pascal ReFindSlot(double a,int fs, int lseq,int rbegin,int utarget,short int spos, short int *parray,short int *maxspos)
  {

	int hold;
	hold = (fs+1)*spos;
	for (int z = rbegin;z < utarget; z++){
        if(*(parray + (int)(z*a) + hold) != 0){
			spos++;
			z=rbegin;
			hold = (fs+1)*spos;
		}
		

    }

	return(spos);
  }

 int FAR pascal InvertBkg(short int xval,short int yval, short int *picinfo)
  {
	
	int offset = xval+50 - xval + 1;
	int initoffset = 0 - offset;
	int vertpos = -(xval+offset);//vertpos;

	for (int ypos = 0;ypos < yval; ypos++){
		vertpos += xval+offset;//(xval*ypos)+initoffset;
		for (int xpos = 0;xpos < xval; xpos++){
			
			
			if (*(picinfo + xpos +vertpos)>=254){

				*(picinfo + xpos +vertpos)= (xpos/(xval/5)) + (ypos/(yval/5));  
			}

		}
	} 
	return(1);
  }

int FAR pascal Histogram(short int xval,short int yval, short int *picinfo,int *pixels)
  {
	
	int offset = xval+50 - xval + 1;
	int initoffset = 0 - offset;
	int vertpos = -(xval+offset);//vertpos;
	for (int ypos = 0;ypos < yval; ypos++){
		vertpos += xval+offset;//(xval*ypos)+initoffset;
		for (int xpos = 0;xpos < xval; xpos++){
			
			
			*(pixels + abs(*(picinfo + xpos + vertpos))) = *(pixels + abs(*(picinfo + xpos + vertpos))) + 1;

		}
	} 
	return(1);
  }
 
 int FAR pascal SearchArray(short int xval,short int yval, short int *picinfo)
  {
	
	int offset = 50 + 1 + xval;
	int count = offset*5;
	int ypos = 4;
	int xpos = 9;
	int vertpos = -offset;
	do {
		vertpos += count;
		do {
			if(*(picinfo + xpos + vertpos) >= 250){
				//count=count+1;
				//if (count=20){
					 return(ypos);
				//}
			}
		}while (xpos+=10,xpos < (xval-10));
		xpos = 9;
	} while (ypos+=5,ypos < (yval - 5));
	return(5);
  }

/*int FAR pascal FindWedge(short int xval,short int yval, short int *picinfo,short int *wedgex)
  {
	
	int offset = xval+50 - xval + 1;
	int initoffset = 0 - offset;
	short int wedgeno = 0;
	short int templengthfind = 0;
	short int templengthfind2 = 0 ;
	short int xbegin ;
	short int ybegin;
	short int xstart2; 
	short int buffer;
	short int addon;
	int ypos=0;
	int xpos;
	do {
		ypos++;
		xpos=0;
		initoffset = initoffset + offset;
		do {
			xpos++;
			if (*(picinfo + xpos +initoffset+ (xval*ypos)) > 253){
				wedgeno = wedgeno + 1	;
			  	templengthfind = 0 ;
			  	templengthfind2 = 0 ;
			  	*(wedgex + wedgeno*6 + 1) = 0;		   //wedgex(wedgeno,1) = 0
			  	*(wedgex + wedgeno*6 + 2) = xpos;
			  	*(wedgex + wedgeno*6 + 3) = ypos;
			  	*(wedgex + wedgeno*6 + 4) = 0;
			  	*(wedgex + wedgeno*6 + 5) = 0;	   //wedgex(wedgeno,5) = 0
			  	xbegin = xpos;
			  	ybegin = ypos;
			  	xstart2=xpos;
			  	buffer = 0;
  			  	do {			  		
        		 	if ( abs(*(picinfo + xpos +initoffset+ (xval*ypos))) >= 250){ 
			           	 templengthfind2 = 0;
			           	if (xpos > *(wedgex + wedgeno*6  + 4)){
							    *(wedgex + wedgeno*6  + 4) = xpos;
						}
						if (xpos < *(wedgex + wedgeno*6  + 2)) {
							*(wedgex + wedgeno*6  + 2) = xpos ;
						}
			            *(wedgex + wedgeno*6 +1) = *(wedgex + wedgeno*6 +1) + 1;
			            *(picinfo + xpos +initoffset+ (xval*ypos)) =  abs(*(picinfo + xpos +initoffset+ (xval*ypos))) + addon; 
			            //SetPixel(pict, xpos, ypos, 255)
         
			      	}
        
			        if (abs(*(picinfo + xpos +initoffset+ (xval*ypos))) < 254){
			         	templengthfind = templengthfind + 1;
			        }
			        
					if (ypos > 0) {
								if (*(picinfo + xpos +initoffset-offset+ (xval*(ypos-1)))>=250){ 
				
					   				templengthfind=0;
								}
					
					}
					if (ypos < yval){
								if (*(picinfo + xpos +initoffset + offset +(xval*(ypos+1)))>=250){ 
				
					   				templengthfind=0;
								}
					}
					if (abs(*(picinfo + xpos +initoffset+ (xval*ypos)-1)) >= 250){
						templengthfind = 0 ;
        			}
					if (abs(*(picinfo + xpos +initoffset+ (xval*ypos)+1)) >= 250){
						templengthfind = 0 ;
        			}

			        if (templengthfind = 10){ 
			            xpos =  xstart2; //abs(xbegin - 3);
			            ypos = ypos + 1	;
			            templengthfind = 0;
			            buffer = 0;
			            templengthfind2 = templengthfind2 + 1;
			            do {
							if ( abs(*(picinfo + xpos +initoffset+ (xval*ypos))) < 250){
							 	break;
							}
							xpos = xpos - 1;
							
						} while (xpos > 0);
			        }
        
			        xpos = xpos + 1;

				} while (templengthfind2 < 5);
				
				if (ypos > *(wedgex + wedgeno*6  + 5)){
					*(wedgex + wedgeno*6  + 5) = ypos;
   				}
   
			   	addon = 0;
      
			   	if (*(wedgex + wedgeno*6 +1) < 350) {
			        wedgeno = wedgeno - 1 ;
			        xpos = xbegin;
			        ypos = ybegin;
			        addon = -6;
			    } 
			    else {
			    	ypos = yval - 1	;
			    }
			   
   
			
		    }
		}while (xpos < xval);
	} while (ypos < yval); 
	return(1);
  }


*/


int FAR pascal LeafHistoSort(short int leafno,long leaftot,long *leafhisto,long double *leafhistop)
  {
	
	
	for (int x = 0;x < 255; x++){
	
		*(leafhistop + 501*x+leafno) = (*(leafhisto + 501*x+leafno)*1000)/leaftot; 
	}
	
	  
	return (1);
	
	
	
	
  }



int FAR pascal LeafThresh(HDC pict,short int xval,short int yval,short int xpos,short int ypos, short int leafno, short int cutoff2,short int cutoff, short int *picinfobak,long *leaf,long *leafhisto)
  {
	
	short int pixcol;
	int offset = (51 )*ypos;
	
	
	SetPixel(pict, xpos-1, ypos, 16711680);
    do {
    	
       	

       	*(leaf+leafno+501) += 1	;
       	
       	
       	if (*(picinfobak + xpos +offset + (xval*ypos)) >=cutoff){
					   	
					   	*(leaf+leafno+501) -=1 	;
					   	MoveToEx(pict,xpos,ypos,0);
					   	do{
							pixcol =*(picinfobak + xpos +offset+ (xval*ypos));
							*(leaf+leafno+501) += 1;
							*(leaf+leafno+1002) += 1;
							*(leafhisto + 501*abs(pixcol)+leafno) = *(leafhisto  + 501*abs(pixcol)+leafno)+1;
							*(picinfobak + xpos +offset+ (xval*ypos)) = -leafno;
					   		
					   		//SetPixel(pict, xpos, ypos, 255);								*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
				   		//xpos++;
				   			
				   		} while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff);
				   		LineTo(pict,xpos,ypos);
			}
       	
		 
		pixcol =*(picinfobak + xpos +offset+ (xval*ypos));
		*(leafhisto  + 501*abs(pixcol)+leafno) = *(leafhisto  + 501*abs(pixcol)+leafno)+1;
       	*(picinfobak + xpos +offset+ (xval*ypos)) = -leafno;
       	
       		
       		
       	
       	
       } while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos))>=cutoff2);
       SetPixel(pict, xpos, ypos, 16711680);
     
	 // *(leafhisto) = 50;  
	return (xpos);
	
	
	
	
  }



int FAR pascal DrawMatrix(HDC pict, short int pwid,short int ypos,short int dwid, short int sqr, unsigned char *picarray)
  {
	short int wid;
	short int marray;
	/*double xyfactor;*/

	unsigned short int pixcol;
	/*short int y;*/
	/*y=0;*/
	/*xyfactor = pwid/sqr;*/
	/*xyfactor=0.2;*/
	wid = sqr-dwid;
	for (short int y=0;y <= wid; y = y + dwid){
		for (short int x=y+1;x <= wid-1; x = x + dwid){

			marray=0;
			for (short int a=0; a <= dwid; a++){

				for (short int b=0; b <= dwid; b++){

					pixcol = *(picarray + x + a + (b+y)*(sqr));

					if(pixcol == 105)

						marray = marray + 255;
					/*else if (pixcol != 109)
                        marray = marray + 196;*/
					

				}
			}
			marray = marray / ((dwid+1)*(dwid+1));

			SetPixelV (pict, x * pwid / sqr, y * pwid / sqr, marray * 65793);
			SetPixelV (pict, y * pwid / sqr, x * pwid / sqr, marray * 65793);
		}	

	}
	return(1);
  }


int FAR pascal DrawMatrixB(HDC pict, short int pwid,short int ypos,short int dwid, short int sqr, unsigned char *picarray)
  {
	/*double xyfactor;*/

	unsigned short int pixcol;
	/*short int y;*/
	/*y=0;*/
	/*xyfactor = pwid/sqr;*/
	/*xyfactor=0.2;*/

	for (short int y=0;y <= sqr; y++){
		for (short int x=y+1;x <= sqr; x = x ++){

		
			

					pixcol = *(picarray + x + y*sqr);

					if(pixcol == 105){

						SetPixelV (pict, x , y , 255 * 65793);
						SetPixelV (pict, y , x , 255 * 65793);
					/*else if (pixcol != 109)
                        marray = marray + 196;*/
					}
					else {

						SetPixelV (pict, x , y , 0);
						SetPixelV (pict, y , x , 0);
					/*else if (pixcol != 109)
                        marray = marray + 196;*/
					}


		}	

	}
	return(1);
  }


  int FAR pascal LeafThreshBAK(HDC pict,short int xval,short int yval,short int xpos,short int ypos, short int leafno, short int cutoff2,short int cutoff, short int *picinfobak,long *leaf)
  {
	int offset = (51 )*ypos;
	
	
	SetPixel(pict, xpos-1, ypos, 16711680);
    do {
    	
       	
       	*(leaf+leafno+501) = *(leaf+leafno+501) + 1	;
       	
       	
       	if (*(picinfobak + xpos +offset + (xval*ypos)) >=cutoff){
					   	
					   	*(leaf+leafno+501) = *(leaf+leafno+501) - 1	;
					   	MoveToEx(pict,xpos,ypos,0);
					   	do{
							*(leaf+leafno+501) = *(leaf+leafno+501) + 1	;
							*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
							*(picinfobak + xpos +offset+ (xval*ypos)) = -leafno;
					   		//SetPixel(pict, xpos, ypos, 255);								*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
				   		//xpos++;
				   			
				   		} while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff);
				   		LineTo(pict,xpos,ypos);
			}
       	
       	*(picinfobak + xpos +offset+ (xval*ypos)) = -leafno;
       //	if (*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff){
       		//*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
       //		SetPixel(pict, xpos, ypos, 255);
       //	}
       		
       		
       	
       	
       } while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos))>=cutoff2);
       SetPixel(pict, xpos, ypos, 16711680);
     
	   //*(leaf+leafno+501) = *(leaf+leafno+501) - 1;
	return (xpos);
	
	
	
	
  }

  int FAR pascal LeafThresh2(HDC pict,short int xval,short int yval,short int xpos,short int ypos, short int leafno, short int cutoff2,short int cutoff, short int *picinfobak,long *leaf)
  {
	int offset = (xval+51 - xval)*ypos;
	
	
	SetPixel(pict, xpos-1, ypos, 16711680);
    do {
    	
       	*(leaf+leafno+501) = *(leaf+leafno+501) + 1	;
       	
       	if (*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff){
       			*(leaf+leafno+501) = *(leaf+leafno+501) - 1	;
       			MoveToEx(pict,xpos,ypos,0);
					   	do{
							*(leaf+leafno+501) = *(leaf+leafno+501) + 1	;
							*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
							//*(picinfobak + xpos +offset+ (xval*ypos)) = -leafno;
					   		//SetPixel(pict, xpos, ypos, 255);								*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
				   		//xpos++;
				   			
				   		} while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff);
				 LineTo(pict,xpos,ypos);
       	
       		//*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
       	//	SetPixel(pict, xpos, ypos, 255);
       	}
       	
       		
    } while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos))>=cutoff2);
       SetPixel(pict, xpos, ypos, 16711680);
     

	return (xpos);

	}
	

int FAR pascal LeafThresh3(HDC pict,short int xval,short int yval,short int xpos,short int ypos,short int cutoff2,long col, short int *picinfobak)
  {
	int offset = (xval+51 - xval)*ypos;
	
	
	SetPixel(pict, xpos-1, ypos, col);//16711680);
    do {
    	
       	
       					if (*(picinfobak + xpos + offset + (xval*ypos)+(xval+51))<cutoff2){ 
				
						   	SetPixel(pict, xpos, abs(ypos+1), col);
						}
					
					
						
						if (*(picinfobak + xpos + offset + (xval*ypos)-(xval+51))<cutoff2){ 
				
						   	SetPixel(pict, xpos, ypos-1, col);
						}

       	//if (*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff){
       			
       			//MoveToEx(pict,xpos,ypos,0);
				//	   	do{
							
				   			
				//   		} while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff);
				 //LineTo(pict,xpos,ypos);
       	
       		//*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
       	//	SetPixel(pict, xpos, ypos, 255);
       //	}
       	
       		
    } while (xpos++,*(picinfobak + xpos + offset+ (xval*ypos))>=cutoff2);
       SetPixel(pict, xpos, ypos,col);// 16711680);
     

	return (xpos);

	}
	

int FAR pascal LeafThresh4(HDC pict,short int xval,short int yval,short int xpos,short int ypos, short int leafno, short int cutoff2,short int cutoff, short int *picinfobak,long *leaf)
  {
	int offset = (xval+51 - xval)*ypos;
	
	
	//SetPixel(pict, xpos-1, ypos, 16711680);
    do {
    	
       	*(leaf+leafno+501) = *(leaf+leafno+501) + 1	;
       	
       	if (*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff){
       			*(leaf+leafno+501) = *(leaf+leafno+501) - 1	;
       			//MoveToEx(pict,xpos,ypos,0);
					   	do{
							*(leaf+leafno+501) = *(leaf+leafno+501) + 1	;
							*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
							//*(picinfobak + xpos +offset+ (xval*ypos)) = -leafno;
					   		//SetPixel(pict, xpos, ypos, 255);								*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
				   		//xpos++;
				   			
				   		} while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff);
				 //LineTo(pict,xpos,ypos);
       	
       		//*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
       	//	SetPixel(pict, xpos, ypos, 255);
       	}
       	
       		
    } while (xpos++,*(picinfobak + xpos +offset+ (xval*ypos))>=cutoff2);
       //SetPixel(pict, xpos, ypos, 16711680);
     

	return (xpos);

	}
/*	int FAR pascal LeafThresh2backup(HDC pict,short int xval,short int yval,short int xpos,short int ypos, short int leafno, short int cutoff2,short int cutoff, short int *picinfobak,long *leaf)
  {
	int offset = (xval+51 - xval)*ypos;
	
	
	SetPixel(pict, xpos-1, ypos, 16711680);
    do {
    	
       	*(leaf+leafno+501) = *(leaf+leafno+501) + 1	;
       	if (*(picinfobak + xpos +offset+ (xval*ypos)) >= cutoff){
       		*(leaf+leafno+1002) = *(leaf+leafno+1002) + 1;
       		SetPixel(pict, xpos, ypos, 255);
       	}
       	//	*(picinfobak + xpos +offset+ (xval*ypos)) = -leafno;
       		xpos = xpos + 1;
    } while (*(picinfobak + xpos +offset+ (xval*ypos))>=cutoff2);
       SetPixel(pict, xpos, ypos, 16711680);
     

	return (xpos);

	} */


int FAR pascal SeqWrite(HDC pict,short int nextno,short int fraglen,short int seqlen, short int winleft,const char *seqnum)
  {
	
	
			
    for (int x = 1; x <= nextno; x++){
    	
       	/*TextOut (pict,0, x * 13, *(seqnum + x * seqlen + winleft), fraglen);  */     		
    } 

	return (1);
	
	
  }


 int FAR pascal WedgeThresh(HDC pict,short int xval,short int yval,short int xpos,short int ypos, short int correction, short int wedgecutoff, short int *picinfobak,long *wedgeseg)
  {
	
	int offset = (xval+51 - xval)*ypos;
			
    do {
    	
       	
       		*(wedgeseg + abs(*(picinfobak + xpos +offset+ (xval*ypos)))) = *(wedgeseg + abs(*(picinfobak + xpos +offset+ (xval*ypos))))+1;
       		SetPixel(pict, xpos, ypos, abs(*(picinfobak + xpos +offset+ (xval*ypos))));
       		*(picinfobak + xpos +offset+ (xval*ypos)) = abs(*(picinfobak + xpos +offset+ (xval*ypos)))*(-1);
       	
       		xpos = xpos + 1;
    } while (abs(*(picinfobak + xpos + offset+ (xval*ypos)))>=wedgecutoff && xpos < correction);
      
     

	return (xpos);
	
	
  }

/*int FAR pascal CopyArray(short int xval,short int yval, short int *picinfo,short int *picinfobak)
  {
	
	int offset = xval+50 - xval + 1;
	int initoffset = 0 - offset;
	int vertpos = -(xval+offset);//vertpos;
	for (int ypos = 0;ypos < yval; ypos++){
		vertpos += xval+offset;//(xval*ypos)+initoffset;
		for (int xpos = 0;xpos < xval; xpos++){
			
			
			*(picinfobak + xpos + vertpos) = *(picinfo + xpos +vertpos);

		}
	} 
	return(1);
  }
*/

 int FAR pascal FindSubSeqC(int lenseq, short int nextno, short int seq1,short int seq2,short int seq3,short int *seqnum,int *xdiffpos,int *xposdiff)
{
	short int s1,s2,s3;
	int x, y, o1,o2,o3;
	y=0;
	o1 = seq1*lenseq;
	o2 = seq2*lenseq;
	o3 = seq3*lenseq;
	for (x = 1; x < lenseq; x++){
		*(xposdiff + x - 1) = y;
		s1 = *(seqnum + x + o1);
		if (s1 != 46){
			s2 = *(seqnum + x + o2);
			if (s2 != 46 ){
				if (s1 != s2) {
					if ( *(seqnum + x + o3) != 46){
						y ++;
						*(xdiffpos + y) = x;
					}
				}
				else{
					s3 = *(seqnum + x + o3);
					if (s3 != 46 ){
						if (s1 != s3) {
							y ++;
							*(xdiffpos + y) = x;
						}
					}
				}
			}
		}
	}
	return(y);
}

int FAR pascal FindSubSeqD(int lenseq, short int nextno, short int seq1,short int seq2,short int seq3,short int *seqnum,int *xdiffpos,int *xposdiff)
{
	int s1,s2,s3,y = 0; 
	int os1,os2,os3;
	int x;
	os1 = seq1*lenseq;
	os2 = seq2*lenseq;
	os3 = seq3*lenseq;
	for (x = 1; x < lenseq; x++){
		xposdiff [x - 1] = y;
		s1 = *(seqnum + x + os1);
		
		
		if (s1 !=46){
			s2 = *(seqnum + x + os2);
		
			if (s2 != 46){
				s3 = *(seqnum + x + os3);
				if (s3 != 46){

					if (s1 != s2 || s1 != s3) {
						if (s1 == s2 || s1 == s3){
							y ++;
							xdiffpos [y] = x;
						}	
					}
				}
			}
		}
	}
	return(y);
}



 int FAR pascal FindSubSeqB(int lenseq, short int nextno, short int seq1,short int seq2,short int seq3,short int *seqnum,int *xdiffpos,int *xposdiff)
{
	short int y = 0;
	for (int x = 1; x < lenseq; x++){
		*(xposdiff + x - 1) = y;
		if (*(seqnum + x + seq1*lenseq) != *(seqnum + x + seq2*lenseq) || *(seqnum + x + seq1*lenseq) != *(seqnum + x + seq3*lenseq) || *(seqnum + x + seq2*lenseq) != *(seqnum + x + seq3*lenseq)) {
			if (*(seqnum + x + seq1*lenseq) > 63 && *(seqnum + x + seq1*lenseq) < 91 && *(seqnum + x + seq2*lenseq) > 63 && *(seqnum + x + seq2*lenseq) < 91 && *(seqnum + x + seq3*lenseq) > 63 && *(seqnum + x + seq3*lenseq) < 91){
				y ++;
				*(xdiffpos + y) = x;
					
			}
			else{
				if (*(seqnum + x + seq1*lenseq) != *(seqnum + x + seq2*lenseq) && *(seqnum + x + seq1*lenseq) != *(seqnum + x + seq3*lenseq) && *(seqnum + x + seq2*lenseq) != *(seqnum + x + seq3*lenseq)) {
				
					y ++;
					*(xdiffpos + y) = x;
					
				}

			}

		}

	}
	return(y);
}
/*For X = 1 To Len(StrainSeq(0))
             XPosDiff(X) = Y
            If SeqNum(X, Seq1) <> SeqNum(X, Seq2) Or SeqNum(X, Seq1) <> SeqNum(X, Seq3) Or SeqNum(X, Seq3) <> SeqNum(X, Seq2) Then
                  


                                Y = Y + 1
                                
                                
                                XDiffPos(Y) = X
                               
                              
            End If
        Next X*/
int FAR pascal WinScoreCalc(int criticaldiff,int HWindowWidth, int LenXoverSeq,int LenSeq, int Seq1, int Seq2,int Seq3,char *Scores, int *XDiffPos, short int *SeqNum, int *WinScores)
{
	
	int goon, X, LO, RO, FO, SO, TO, TO2;
	TO = LenSeq;
	TO2 = LenSeq*2;
	FO = LenSeq + HWindowWidth*2;
	SO = (LenSeq + HWindowWidth*2)*2;
	goon = 0;
	
	
	//Calculate scores per position
	for (X = 0; X <= LenXoverSeq; X++){
		
		*(WinScores + X) = 0;
		*(WinScores + X + FO) = 0;
		*(WinScores + X + SO) = 0;
	}
	
	for (X = 1; X <= LenXoverSeq; X++){
		*(Scores + X) = (*(SeqNum + XDiffPos[X] + LenSeq*Seq1) == *(SeqNum + XDiffPos[X] + LenSeq*Seq2));
		*(Scores + X + TO) = (*(SeqNum + XDiffPos[X] + LenSeq*Seq1) == *(SeqNum + XDiffPos[X] + LenSeq*Seq3));
		*(Scores + X + TO*2) = (*(SeqNum + XDiffPos[X] + LenSeq*Seq2) == *(SeqNum + XDiffPos[X] + LenSeq*Seq3));
	}

	//calculate score for 0 window (actually the last window)
	for (X = (LenXoverSeq - HWindowWidth + 1); X <= LenXoverSeq; X++){
		*(WinScores) = *(WinScores) + *(Scores + X);
		*(WinScores + FO) = *(WinScores + FO) + *(Scores + X  + TO);
		*(WinScores + SO) = *(WinScores + SO) + *(Scores + X  + TO*2);
	}

	//Calculate scores for windows traversing the left end
	for (X = 1; X <= HWindowWidth; X++){
		LO = ((LenXoverSeq - HWindowWidth) + X) ;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + X);
		*(WinScores + X + FO) = *(WinScores + X + FO - 1) - *(Scores + LO + TO) + *(Scores + X + TO);
		*(WinScores + X + SO) = *(WinScores + X + SO - 1) - *(Scores + LO + TO*2) + *(Scores + X  + TO*2);

	}

	//Calculate scores for internal windows
	for (X = HWindowWidth+1; X <= LenXoverSeq; X++){
		LO = X - HWindowWidth ;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + X);
		*(WinScores + X + FO) = *(WinScores + X + FO - 1) - *(Scores + LO + TO) + *(Scores + X + TO);
		*(WinScores + X + SO) = *(WinScores + X + SO - 1) - *(Scores + LO  + TO*2) + *(Scores + X  + TO*2);
	}
	
	//Calculate scores for windows traversing the right end
	for (X = LenXoverSeq+1; X < LenXoverSeq + HWindowWidth;X++){
		LO = (X - HWindowWidth);
		RO = X - LenXoverSeq ;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + RO);
		*(WinScores + X + FO) = *(WinScores + X + FO - 1) - *(Scores + LO + TO) + *(Scores + RO + TO);
		*(WinScores + X + SO) = *(WinScores + X + SO - 1) - *(Scores + LO  + TO*2) + *(Scores + RO + TO*2);
	}
	
	/*for (X = 1; X < LenXoverSeq + HWindowWidth;X++){
		if (*(WinScores + X) - *(WinScores + X + HWindowWidth -1) > criticaldiff || *(WinScores + X) - *(WinScores + X + HWindowWidth -1) < -criticaldiff) {
			goon = 1;
			break;
		}
		else if (*(WinScores + X + FO) - *(WinScores + X + HWindowWidth -1 + FO) > criticaldiff || *(WinScores + X + FO) - *(WinScores + X + HWindowWidth -1 + FO) < -criticaldiff){
			goon = 1;
			break;
		}
		else if (*(WinScores + X + SO) - *(WinScores + X + HWindowWidth -1 + SO) > criticaldiff || *(WinScores + X + SO) - *(WinScores + X + HWindowWidth -1 + SO) < -criticaldiff) {

			goon = 1;
			break;
		}
	}*/

	return (1);
} 

int FAR pascal WinScoreCalc4(int criticaldiff,int HWindowWidth, int LenXoverSeq,int LenSeq, int Seq1, int Seq2,int Seq3,char *Scores, int *XDiffPos, short int *SeqNum, int *WinScores)
{
	int goon, X, LO, RO,   TO;
	TO = LenSeq;
	goon = 0;
	

	//Calculate scores per position
	for (X = 1; X <= LenXoverSeq; X++){
		
		if (*(SeqNum + XDiffPos[X] + LenSeq*Seq1) == *(SeqNum + XDiffPos[X] + LenSeq*Seq2)){
			*(Scores + X) = 1;
		}
		else{
			*(Scores + X) = 0;
		}

		*(WinScores + X) = 0;
	}
	
	

	//Calculate scores for first window
	
	*(WinScores) = 0;

	for (X = (LenXoverSeq - HWindowWidth + 1); X <= LenXoverSeq; X++){
		*(WinScores) = *(WinScores) + *(Scores + X);
	}

	//Calculate scores for windows traversing the left end
	for (X = 1; X <= HWindowWidth; X++){
		LO = ((LenXoverSeq - HWindowWidth) + X);
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + X);
	}

	//Calculate scores for internal windows
	for (X = HWindowWidth+1; X <= LenXoverSeq; X++){
		LO = X - HWindowWidth;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + X);
	}
	
	//Calculate scores for windows traversing the right end
	for (X = LenXoverSeq+1; X < LenXoverSeq + HWindowWidth;X++){
		LO = (X - HWindowWidth );
		RO = X - LenXoverSeq ;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + RO);
	}
	
	for (X = 1; X < LenXoverSeq + HWindowWidth;X++){
		if (*(WinScores + X) - *(WinScores + X + HWindowWidth -1) > criticaldiff || *(WinScores + X) - *(WinScores + X + HWindowWidth -1) < -criticaldiff) {
			goon = 1;
			break;
		}
	}

	return (goon);
} 

int FAR pascal WinScoreCalc2(int criticaldiff,int HWindowWidth, int LenXoverSeq,int LenSeq, int Seq1, int Seq2,char *Scores, int *XDiffPos, short int *SeqNum, int *WinScores)
{
	int goon, X, LO, RO, TO;
	TO = LenSeq;
	goon = 0;
	

	//Calculate scores per position
	for (X = 1; X <= LenXoverSeq; X++){
		if (*(SeqNum + XDiffPos[X] + LenSeq*Seq1) != 46 || *(SeqNum + XDiffPos[X] + LenSeq*Seq2) != 46){ 
			if (*(SeqNum + XDiffPos[X] + LenSeq*Seq1) == *(SeqNum + XDiffPos[X] + LenSeq*Seq2))
				*(Scores + X) = 1;
			else
				*(Scores + X) = 0;
		}
		else
			*(Scores + X) = 0;

		*(WinScores + X) = 0;
		
	}
	
	//Calculate scores for first window
	
	*(WinScores) = 0;
	for (X = (LenXoverSeq - HWindowWidth + 1); X <= LenXoverSeq; X++)
		*(WinScores) = *(WinScores) + *(Scores + X);
	

	//Calculate scores for windows traversing the left end
	for (X = 1; X <= HWindowWidth; X++){
		LO = ((LenXoverSeq - HWindowWidth) + X);
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + X);

	}

	//Calculate scores for internal windows
	for (X = HWindowWidth+1; X <= LenXoverSeq; X++){
		LO = X - HWindowWidth ;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + X);
	}
	
	//Calculate scores for windows traversing the right end
	for (X = LenXoverSeq+1; X < LenXoverSeq + HWindowWidth;X++){
		LO = (X - HWindowWidth );
		RO = X - LenXoverSeq;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + RO);
	}
	
	for (X = 1; X < LenXoverSeq + HWindowWidth;X++){
		if (*(WinScores + X) - *(WinScores + X + HWindowWidth -1) > criticaldiff || *(WinScores + X) - *(WinScores + X + HWindowWidth -1) < -criticaldiff) {
			goon = 1;
			break;
		}
	}

	return (goon);
}

int FAR pascal WinScoreCalc3(int criticaldiff,int HWindowWidth, int LenXoverSeq,int LenSeq, int Seq1, int Seq2,char *Scores, int *XDiffPos, short int *SeqNum, int *WinScores, int *xdiffpos2)
{
	int goon, X, LO, RO, TO, y, lx2;
	TO = LenSeq;
	goon = 0;
	
	y=0;
	
	//Calculate scores per position
	for (X = 1; X <= LenXoverSeq; X++){
		if (*(SeqNum + XDiffPos[X] + LenSeq*Seq1) != 46 && *(SeqNum + XDiffPos[X] + LenSeq*Seq2) != 46){ 
			y++;
			xdiffpos2[y] = XDiffPos[X];
			if (*(SeqNum + XDiffPos[X] + LenSeq*Seq1) == *(SeqNum + XDiffPos[X] + LenSeq*Seq2))
				*(Scores + y) = 1;
			else
				*(Scores + y) = 0;
		}
		

		*(WinScores + X) = 0;
		
	}
	
	lx2=y;
	//Calculate scores for first window
	
	*(WinScores) = 0;
	for (X = (lx2 - HWindowWidth + 1); X <= lx2; X++)
		*(WinScores) = *(WinScores) + *(Scores + X);
	

	//Calculate scores for windows traversing the left end
	for (X = 1; X <= HWindowWidth; X++){
		LO = ((lx2 - HWindowWidth) + X) ;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + X);

	}

	//Calculate scores for internal windows
	for (X = HWindowWidth+1; X <= lx2; X++){
		LO = X - HWindowWidth ;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + X);
	}
	
	//Calculate scores for windows traversing the right end
	for (X = lx2+1; X < lx2 + HWindowWidth;X++){
		LO = (X - HWindowWidth );
		RO = X - lx2 ;
		*(WinScores + X) = *(WinScores + X - 1) - *(Scores + LO) + *(Scores + RO);
	}
	
	for (X = 1; X < lx2 + HWindowWidth;X++){
		if (*(WinScores + X) - *(WinScores + X + HWindowWidth -1) > criticaldiff || *(WinScores + X) - *(WinScores + X + HWindowWidth -1) < -criticaldiff) {
			goon = 1;
			break;
		}
	}

	return (lx2);
}


int FAR pascal GetAC(int LenXoverSeq, int LS,int MaxY, int MaxX, int TWin, int *A, int *C, char *Scores){
	int X, os;
	os = MaxY*(LS+1);
	//scores ls,2
        //Calculate first A and first C for window size Twin
	for (X = ((MaxX + 1) - TWin); X <= MaxX; X++){
		if (X > 0){
			if (X <= LenXoverSeq)
                *A = *A + Scores[X + os];
            else 
				*A = *A + Scores[X - LenXoverSeq + os];
		}
		else
			*A = *A + Scores[LenXoverSeq + X + os];
            
	}
	for (X = (MaxX + 1); X <= MaxX + TWin; X++){
		if (X > 0){
			if (X <= LenXoverSeq)
                *C = *C + Scores[X + os];
            else 
				*C = *C + Scores[X - LenXoverSeq + os];
		}
		else
			*C = *C + Scores[LenXoverSeq + X + os];
	}
	return(1);
}

int FAR pascal FindMChi(int LenSeq,int LenXoverSeq, int *MaxX,short int *MaxY, double *MChi, double *ChiVals)
{
	int X, SO, tMaxX;
	short int Y, tMaxY;
	double ChiV, tMChi;
	tMaxX = -1;
    tMaxY = -1;
    tMChi = 0;
	ChiV = 0;
	SO = LenSeq + 1; 
    for (X = 0; X < LenXoverSeq; X++){ 
        for (Y = 0; Y <= 2; Y++){
			ChiV = *(ChiVals + X + Y*SO);
            if (ChiV > tMChi){ 
                tMChi = ChiV;
                tMaxX = X;
                tMaxY = Y;
            }
		}
    }
	*MChi=tMChi;
	*MaxX=tMaxX;
	*MaxY=tMaxY;
	return 1;
}

int FAR pascal FindMChi3(int LenSeq,int LenXoverSeq, int *MaxX,short int *MaxY, double *MChi, double *ChiVals)
{
	int X, SO, tMaxX;
	short int Y, tMaxY;
	double ChiV, tMChi;
	tMaxX = -1;
    tMaxY = -1;
    tMChi = 0;
	ChiV = 0;
	SO = LenSeq + 1; 
    Y=0;
	for (X = 0; X < LenXoverSeq; X++){ 
        
			ChiV = *(ChiVals + X );
            if (ChiV > tMChi){ 
                tMChi = ChiV;
                tMaxX = X;
                tMaxY = Y;
            }
		
    }
	*MChi=tMChi;
	*MaxX=tMaxX;
	*MaxY=tMaxY;
	return 1;
}

int FAR pascal FindMChi2(int LenSeq,int LenXoverSeq, int *MaxX,short int *MaxY, double *MChi, double *ChiVals)
{
	int X, SO, tMaxX;
	short int  tMaxY;
	double ChiV, tMChi;
	tMaxX = -1;
    tMaxY = -1;
    tMChi = 0;
	ChiV = 0;
	SO = LenSeq + 1; 
    for (X = 0; X < LenXoverSeq; X++){ 
        //for (Y = 0; Y <= 2; Y++){
			ChiV = *(ChiVals + X );
            if (ChiV > tMChi){ 
                tMChi = ChiV;
                tMaxX = X;
                tMaxY = 0;
            }
		//}
    }
	*MChi=tMChi;
	*MaxX=tMaxX;
	*MaxY=tMaxY;
	return 1;
}


int FAR pascal DestroyPeak(int MaxY, int LS, int RO, int LO, int LenXoverSeq, double *LOT, double *SmoothChi, double *ChiVals){
	//smootchchi - ls,2
	int Circuit1, EraseAll, X;
	EraseAll=0;
	if (RO < 1){
		RO = LenXoverSeq - RO;
        if (RO < 2)
			return(0);
	}
    Circuit1 = 0;
	if (RO > LenXoverSeq){
		RO = RO - LenXoverSeq;
        if (RO >= LenXoverSeq)
			return(0);
        Circuit1 = 1;
	}

	else
		Circuit1 = 0;

	if (RO > LenXoverSeq - 2){
		if (RO == LenXoverSeq){
			LOT[0] = SmoothChi[1 + MaxY*(LS+1)];
			LOT[1] = SmoothChi[2 + MaxY*(LS+1)];
		}
		else if (RO == LenXoverSeq - 1){
			LOT[0] = SmoothChi[LenXoverSeq + MaxY*(LS+1)];
			LOT[1] = SmoothChi[1 + MaxY*(LS+1)];
		}
	}
	else{
		LOT[0] = SmoothChi[RO + 1 + MaxY*(LS+1)];
		LOT[1] = SmoothChi[RO + 2 + MaxY*(LS+1)];
	}
	while (SmoothChi[RO + MaxY*(LS+1)] > 0 && (SmoothChi[RO + MaxY*(LS+1)] >= LOT[0] || SmoothChi[RO + MaxY*(LS+1)] >= LOT[1])){
		RO++;
		if (RO > LenXoverSeq){
			RO = 1;
			if (Circuit1 == 1){
				EraseAll = 1;
                break;
			}
            else
				Circuit1 = 1;
		}
            
		if (RO > LenXoverSeq - 2){
			if (RO == LenXoverSeq){
				LOT[0] = SmoothChi[1 + MaxY*(LS+1)];
				LOT[1] = SmoothChi[2 + MaxY*(LS+1)];
			}
			else if (RO == LenXoverSeq - 1){
				LOT[0] = SmoothChi[LenXoverSeq + MaxY*(LS+1)];
				LOT[1] = SmoothChi[1 + MaxY*(LS+1)];
			}
		}
		else{
			LOT[0] = SmoothChi[RO + 1 + MaxY*(LS+1)];
			LOT[1] = SmoothChi[RO + 2 + MaxY*(LS+1)];
		}
	}
	if (EraseAll == 0){
		if (LO < 1){
			LO = LenXoverSeq - RO;
            if (LO < 2)
				return(0);

		}
        Circuit1 = 0;
		if (LO > LenXoverSeq){
			LO = LO - LenXoverSeq;
			if (LO >= LenXoverSeq)
				return(0);
			Circuit1 = 1;
		}
		else
			Circuit1 = 0;

		if (LO < 3){
			if (LO == 1){
				LOT[0] = SmoothChi[LenXoverSeq + MaxY*(LS+1)];
				LOT[1] = SmoothChi[LenXoverSeq - 1 + MaxY*(LS+1)];
			}
			else if (LO == 2){
				LOT[0] = SmoothChi[1 + MaxY*(LS+1)];
				LOT[1] = SmoothChi[LenXoverSeq + MaxY*(LS+1)];
			}
		}
		else{
			LOT[0] = SmoothChi[LO - 1 + MaxY*(LS+1)];
			LOT[1] = SmoothChi[LO - 2 + MaxY*(LS+1)];
		}
        while (SmoothChi[LO + MaxY*(LS+1)] > 0 && (SmoothChi[LO + MaxY*(LS+1)] >= LOT[0] || SmoothChi[LO + MaxY*(LS+1)] >= LOT[1])){
			LO--;
			if (LO < 1){
				LO = LenXoverSeq;
				if (Circuit1 == 1){
					EraseAll = 1;
					break;
				}
                else
					Circuit1 = 1;
                           
			}
			if (LO < 3){
				if (LO == 1){
					LOT[0] = SmoothChi[LenXoverSeq + MaxY*(LS+1)];
					LOT[1] = SmoothChi[LenXoverSeq - 1 + MaxY*(LS+1)];
				}
				else if (LO == 2){
					LOT[0] = SmoothChi[1 + MaxY*(LS+1)];
					LOT[1] = SmoothChi[LenXoverSeq + MaxY*(LS+1)];
				}
			}
			else{
				LOT[0] = SmoothChi[LO - 1 + MaxY*(LS+1)];
				LOT[1] = SmoothChi[LO - 2 + MaxY*(LS+1)];
			}
		}
	}
	//chivals ls,2
	if (EraseAll == 1){
		for (X = 0; X <= LenXoverSeq; X++)
			ChiVals[X + MaxY*(LS+1)] = 0;
	}
	else{
		if (LO < RO){
			for (X = LO; X <=RO; X++)
				ChiVals[X + MaxY*(LS+1)] = 0;
		}
                    
		else{
			for (X = 0; X <= RO; X++)
				ChiVals[X + MaxY*(LS+1)] = 0;
                    
            for (X = LO; X <= LenXoverSeq; X++)
				ChiVals[X + MaxY*(LS+1)] = 0;
                    
		}
	}
	return(1);
}


int FAR pascal FillColDist(int Col, int X, int tnt, int Nextno, int UBSN, int UBCD,int UBSCR, short int *SeqNum, short int *ColDist, unsigned char *SeqColRef)
{
	int Z, Y, Tot, osSN, osSCR,  osCD;
	Tot = 0;
	osSN = UBSN + 1;
	osSCR = UBSCR + 1;
	osCD = UBCD+1;
    for (Y = 0; Y <= Nextno; Y++){
		
        if (SeqNum[X+Y*osSN] == tnt){
            
			SeqColRef[X+Y*osSCR] = Col;
            Tot = 1;

            if (Y < Nextno){
                Z = Y + 1;

                while (Z <= Nextno){

                   if (SeqNum[X + Z*osSN] == tnt) {
                        Tot = Tot + 1;
                        Z = Z + 1;

                        if (Z > Nextno){
                            ColDist[X  + Y*osCD] = Tot;
                            Y = Z;
                            break;
                        }
					}

                    else{
                        ColDist[X  + Y*osCD] = Tot;
                        Y = Z;
                        break;
                    }
                    
                }
			}
            else
                ColDist[X  + Y*osCD] = 1;
            

        }
    }


	return(1);
}

int FAR pascal FillColDist2(int PCounter, int X, int tnt, int Nextno, int UBSN, short int *SeqNum, short int *ColDist2)
{
	int Z, Y,  osSN, PosCounter;
	
	osSN = UBSN + 1;
	
	PosCounter=PCounter;
    for (Y = 0; Y <= Nextno; Y++){
		
        if (SeqNum[X+Y*osSN] == tnt){
            
			ColDist2[PosCounter] = Y;
            
            if (Y < Nextno){
                Z = Y + 1;

                while (Z <= Nextno){

                   if (SeqNum[X + Z*osSN] == tnt) {
                        
                        Z = Z + 1;

                        if (Z > Nextno){
                            PosCounter = PosCounter + 1;
                            ColDist2[PosCounter] = Z - 1;
							Y = Z;
                            break;
                        }
					}

                    else{
                        PosCounter = PosCounter + 1;
                        ColDist2[PosCounter] = Z - 1;
                        Y = Z;
                        PosCounter = PosCounter + 1;
                        break;
                    }
                    
                }
			}
            else{
                PosCounter = PosCounter + 1;
                ColDist2[PosCounter] = Y;
			}
        }
    }


	return(PosCounter);
}


int FAR pascal ReMakeDistance(int LSeq, int Nextno, int UBD,  float *SM,  float *Distance, float *PermValid, float *PermDiffs)
{
	int X, Y, GoOn, os1, os2, os3, xy, yx;

	GoOn = 1;
    os1 = UBD+1;
	
	for (X = 0; X <= Nextno; X++){
		os2 = os1*X;
		os3 = X + os2;
		if (SM[os3] != 0){
			GoOn = 0;
			break;
		}
                    
        Distance[os3] = 1;
		for (Y = X + 1; Y <= Nextno; Y++){
			xy = X+Y*os1;
			yx = Y+os2;
            PermValid[xy] = SM[xy];
            PermValid[yx] = SM[xy];
            PermDiffs[xy] = SM[yx];
            PermDiffs[yx] = SM[yx];
            
			if (PermValid[xy] > 0){
                if (PermValid[xy] > LSeq){
                    GoOn = 0;
                    break;
                }
                Distance[xy] = (float)(1.0 - (PermDiffs[xy] / PermValid[xy]));
			}
            else
                Distance[xy] = 0;
            
            Distance[yx] = Distance[xy];
		}
        if (GoOn == 0)
			break;
	}

	return(GoOn);
}


int FAR pascal MakeBanWin(int Seq1, int Seq2, int Seq3, int HWindowWidth, int LS, int LenXoverSeq, int *BanWin, char *MDMap, unsigned char *MissingData, int *XPosDiff, int *XDiffPos){

	int X, Y, s1o,s2o,s3o, lx, xpd;
	//empty banwin and mdmap
	s1o = Seq1*(LS+1);
	s2o = Seq2*(LS+1);
	s3o = Seq3*(LS+1);

	for (X=0; X < LenXoverSeq + HWindowWidth * 2; X++)
		BanWin[X] = 0;

	for (X=0; X < LenXoverSeq + 2; X++)
		MDMap[X] = 0;
	lx = 0;
    for (X = 1; X <= LS; X++){
		if (lx > X) 
			break;
		lx = X;
		if (MissingData[X + s1o] == 1 || MissingData[X + s2o] == 1 || MissingData[X + s3o] == 1){
            xpd = XPosDiff[X];
			//half windows are allowed to end on this position but not start on it or traverse it
			MDMap[xpd] = 1;
			if (xpd + HWindowWidth - 1 <= LenXoverSeq ){
				for (Y = xpd; Y < xpd + HWindowWidth; Y++)
					BanWin[Y] = 1;
			}
			else{
				for (Y = xpd; Y <= LenXoverSeq; Y++)
					BanWin[Y] = 1;

                for (Y = 0; Y < xpd + HWindowWidth - 1 - LenXoverSeq; Y++)
                    BanWin[Y] = 1;
			}
			if (xpd < LenXoverSeq){
				//half windows are allowed to start on this position but not end on it or traverse it
                MDMap[xpd + 1] = 1;
                    
				if (xpd + 2 - HWindowWidth > 0){
					for (Y = xpd + 2 - HWindowWidth; Y < xpd + 2; Y++)
						BanWin[Y] = 1;
				}
				else{
					for (Y = 0; Y < xpd + 2; Y++)
						BanWin[Y] = 1;
					for (Y = xpd + 2 - HWindowWidth + LenXoverSeq; Y <= LenXoverSeq; Y++)
						BanWin[Y] = 1;
                        
				}
                if (XDiffPos[xpd + 1] > XDiffPos[xpd] ) {
					if (XDiffPos[xpd + 1] > X){
						X = XDiffPos[xpd + 1];
						if (X >= LS)
							break;
					}
				}
				else{
					
					MDMap[1] = 1;
					break;
				}
			}
                    
			else{
				MDMap[1] = 1;
                break;
                
            }
		}
	}
	if (MDMap[LenXoverSeq] == 1 || MDMap[1] == 1){
		for (X = LenXoverSeq-HWindowWidth+2; X <= LenXoverSeq; X++)
			BanWin[X] = 1;
		
	}
	return(1);
}

int FAR pascal SmoothChiVals(int LenXoverSeq, int LenSeq, double *ChiVals, double *SmoothChi)
{
	short int Y;
	int OS, RO, X;
	double RunCount;
	int qWindowSize = 5;
	OS = LenSeq+1;
	RO = qWindowSize * 2 + 1;
	for (Y = 0; Y <=2; Y++){
		RunCount = 0;
		for (X = 0 - qWindowSize; X <= 1 + qWindowSize;X++){
			if (X < 1)
				RunCount += *(ChiVals + LenXoverSeq + X + Y*OS);
			else
				RunCount += *(ChiVals + X + Y*OS);
		}
		*(SmoothChi + Y*OS) = RunCount / RO;
		for (X = 1 - qWindowSize; X < LenXoverSeq - qWindowSize; X++){
			if (X > 0){
				if (X + RO <= LenXoverSeq)
					RunCount = RunCount - *(ChiVals + X + Y*OS) + *(ChiVals + X + RO + Y*OS);
				else 
					RunCount = RunCount - *(ChiVals + X + Y*OS) + *(ChiVals + X + RO - LenXoverSeq + Y*OS);
			}
			else 
				RunCount = RunCount - *(ChiVals + LenXoverSeq + X + Y*OS) + *(ChiVals + X + RO + Y*OS);
			
			*(SmoothChi + X + qWindowSize + Y*OS) = RunCount / RO;
		}
    
	}

	return 1;
}

int FAR pascal SmoothChiVals3(int LenXoverSeq, int LenSeq, double *ChiVals, double *SmoothChi)
{
	short int Y;
	int  RO, X;
	double RunCount;
	int qWindowSize = 5;
	RO = qWindowSize * 2 + 1;
	Y=0;
		RunCount = 0;
		for (X = 0 - qWindowSize; X <= 1 + qWindowSize;X++){
			if (X < 1)
				RunCount += *(ChiVals + LenXoverSeq + X);
			else
				RunCount += *(ChiVals + X);
		}
		*(SmoothChi) = RunCount / RO;
		for (X = 1 - qWindowSize; X < LenXoverSeq - qWindowSize; X++){
			if (X > 0 && X + RO <= LenXoverSeq)
				RunCount = RunCount - *(ChiVals + X) + *(ChiVals + X + RO );
			else if (X + RO > LenXoverSeq) 
				RunCount = RunCount - *(ChiVals + X ) + *(ChiVals + X + RO - LenXoverSeq );
			else if (X < 1) 
				RunCount = RunCount - *(ChiVals + LenXoverSeq + X ) + *(ChiVals + X + RO );
			
			*(SmoothChi + X + qWindowSize ) = RunCount / RO;
		}
    
	

	return 1;
}

int FAR pascal SmoothChiVals2(int LenXoverSeq, int LenSeq, double *ChiVals, double *SmoothChi)
{
	
	int  RO, X;
	double RunCount;
	int qWindowSize = 5;
	
	RO = qWindowSize * 2 + 1;
	//for (Y = 0; Y <=2; Y++){
		RunCount = 0;
		for (X = 0 - qWindowSize; X <= 1 + qWindowSize;X++){
			if (X < 1)
				RunCount += *(ChiVals + LenXoverSeq + X );
			else
				RunCount += *(ChiVals + X );
		}
		*(SmoothChi ) = RunCount / RO;
		for (X = 1 - qWindowSize; X < LenXoverSeq - qWindowSize; X++){
			if (X > 0 && X + RO <= LenXoverSeq)
				RunCount = RunCount - *(ChiVals + X ) + *(ChiVals + X + RO );
			else if (X + RO > LenXoverSeq) 
				RunCount = RunCount - *(ChiVals + X ) + *(ChiVals + X + RO - LenXoverSeq );
			else if (X < 1) 
				RunCount = RunCount - *(ChiVals + LenXoverSeq + X ) + *(ChiVals + X + RO );
			
			*(SmoothChi + X + qWindowSize ) = RunCount / RO;
		}
    
	//}

	return 1;
}


int FAR pascal ModPermArray(int Frm1Pic5ScaleWidth, int ub, int LastDim, int SPos, int B, short int *PermArray, short int *TempArray)
{
	int Y, Z, off1, off2, off3, off4;
	
	off1 = Frm1Pic5ScaleWidth+1;
	off2 = (LastDim+1)*off1;
	PermArray[LastDim*off1] = B;
    
	for (Z = 0; Z <= Frm1Pic5ScaleWidth; Z++)
		PermArray[Z + off2] = -B;
    
    for (Y = 0; Y < SPos; Y++){
		off3 = (LastDim+2+Y)*off1;
		off4 = Y*off1;
		for (Z = 1; Z <= Frm1Pic5ScaleWidth; Z++)
			PermArray[Z + off3] = TempArray[Z+ off4];
		

    }





	return(1);
}


double FAR pascal CalcChiVals(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals)
{

	double A,B,C,D,E, ChiH, MChi;
	int X, Y, LO, FO, SO;
	FO = LenSeq + (HWindowWidth)*2 + 1;
	SO = LenSeq + 1;
	LO = HWindowWidth;
	ChiH=0;
	MChi = 0;
	for (X = 0; X < LenXoverSeq; X++) {
		for (Y = 0; Y <= 2;Y++){
			A = *(WinScores + X + FO*Y);
			C = *(WinScores + X + LO + FO*Y);
			if (A - C > criticaldiff || A-C < -criticaldiff){
				B = HWindowWidth - A;
				D = HWindowWidth - C;
				
				if (A + C > 0 && B + D > 0){
					E = A*D - B*C;
					ChiH = E*E*2/(HWindowWidth*(A + C)*(B + D));
					*(ChiVals + X + SO*Y) = ChiH;
					if (ChiH > MChi)
						MChi = ChiH;
				}
				else
					*(ChiVals + X + SO*Y) = 0;
			}
			else
				*(ChiVals + X + SO*Y) = 0;//abs(A-C)/HWindowWidth;
		}
	}
	return (MChi);
}

double FAR pascal CalcChiVals4(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals, int *BanWins)
{

	double A,B,C,D,E, ChiH, MChi;
	int X, Y, LO, FO, SO, bp1;
	FO = LenSeq + (HWindowWidth)*2 + 1;
	SO = LenSeq + 1;
	LO = HWindowWidth;
	ChiH=0;
	MChi = 0;
	for (X = 0; X < LenXoverSeq; X++) {
		bp1=X-HWindowWidth;
		if (bp1 < 1) 
			bp1= bp1+LenXoverSeq ;
		if (BanWins[X] == 0 && BanWins[bp1] == 0){
			for (Y = 0; Y < 3;Y++){

				A = *(WinScores + X + FO*Y);
				C = *(WinScores + X + LO + FO*Y);
				if (A - C > criticaldiff || A-C < -criticaldiff){
					B = HWindowWidth - A;
					D = HWindowWidth - C;
					
					if (A + C > 0 && B + D > 0){
						E = A*D - B*C;
						ChiH = E*E*2/(HWindowWidth*(A + C)*(B + D));
						*(ChiVals + X + SO*Y) = ChiH;
						if (ChiH > MChi)
							MChi = ChiH;
					}
					else
						*(ChiVals + X + SO*Y) = 0;
				}
				else
					*(ChiVals + X + SO*Y) = 0;//abs(A-C)/HWindowWidth;
			}
		}
		else{
			
				*(ChiVals + X) = 0;
				*(ChiVals + X + SO) = 0;
				*(ChiVals + X + SO*2) = 0;
		}
	}
	return (MChi);
}


double FAR pascal CalcChiValsOld(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals)
{

	double ChiH, MChi;
	//double ChiH;
	int X, LO, FO, SO,A,B,C,D,E;
	FO = LenSeq + (HWindowWidth)*2 + 1;
	SO = LenSeq + 1;
	LO = HWindowWidth;
	ChiH=0;
	MChi = 0;
	for (X = 0; X < LenXoverSeq; X++) {
		/*for (Y = 0; Y <= 2;Y++){
			A = *(WinScores + X + FO*Y);
			C = *(WinScores + X + LO + FO*Y);
			if (A - C > criticaldiff || A-C < -criticaldiff){
				B = HWindowWidth - A;
				D = HWindowWidth - C;
				
				if (A + C > 0 && B + D > 0){
					E = A*D - B*C;
					ChiH = E*E*2/(HWindowWidth*(A + C)*(B + D));
					*(ChiVals + X + SO*Y) = ChiH;
					if (ChiH > MChi)
						MChi = ChiH;
				}
				else
					*(ChiVals + X + SO*Y) = 0;
			}
			else
				*(ChiVals + X + SO*Y) = 0;//abs(A-C)/HWindowWidth;
		}*/
		
		//0

		A = *(WinScores + X );
		C = *(WinScores + X + LO);
		if (A - C > criticaldiff || A-C < -criticaldiff){
			B = HWindowWidth - A;
			D = HWindowWidth - C;
			
			if (A + C > 0 && B + D > 0){
				E = A*D - B*C;
				ChiH = (double)(E*E*2)/(double)(HWindowWidth*(A + C)*(B + D));
				*(ChiVals + X) = ChiH;
				if (ChiH > MChi)
					MChi = ChiH;
			}
			else
				*(ChiVals + X) = 0;
		}
		else
			*(ChiVals + X) = 0;//abs(A-C)/HWindowWidth;

		//1
		A = *(WinScores + X + FO);
		C = *(WinScores + X + LO + FO);
		if (A - C > criticaldiff || A-C < -criticaldiff){
			B = HWindowWidth - A;
			D = HWindowWidth - C;
			
			if (A + C > 0 && B + D > 0){
				E = A*D - B*C;
				
				ChiH = (double)(E*E*2)/(double)(HWindowWidth*(A + C)*(B + D));
				*(ChiVals + X + SO) = ChiH;
				if (ChiH > MChi)
					MChi = ChiH;
			}
			else
				*(ChiVals + X + SO) = 0;
		}
		else
			*(ChiVals + X + SO) = 0;//abs(A-C)/HWindowWidth;

		//2
		A = *(WinScores + X + FO*2);
		C = *(WinScores + X + LO + FO*2);
		if (A - C > criticaldiff || A-C < -criticaldiff){
			B = HWindowWidth - A;
			D = HWindowWidth - C;
			
			if (A + C > 0 && B + D > 0){
				E = A*D - B*C;
				ChiH = (double)(E*E*2)/(double)(HWindowWidth*(A + C)*(B + D));
				*(ChiVals + X + SO*2) = ChiH;
				if (ChiH > MChi)
					MChi = ChiH;
			}
			else
				*(ChiVals + X + SO*2) = 0;
		}
		else
			*(ChiVals + X + SO*2) = 0;//abs(A-C)/HWindowWidth;


	}
	return (MChi);
}

double FAR pascal CalcChiVals4OLD(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals, int *BanWins)
{

	double ChiH, MChi;
	int A,B,C,D,E, X,  LO, FO, SO, bp1;
	FO = LenSeq + (HWindowWidth)*2 + 1;
	SO = LenSeq + 1;
	LO = HWindowWidth;
	ChiH=0;
	MChi = 0;
	for (X = 0; X < LenXoverSeq; X++) {
		bp1=X-HWindowWidth;
		if (bp1 < 1) 
			bp1= bp1+LenXoverSeq ;
		if (BanWins[X] == 0 && BanWins[bp1] == 0){
			/*for (Y = 0; Y <= 2;Y++){
				A = *(WinScores + X + FO*Y);
				C = *(WinScores + X + LO + FO*Y);
				if (A - C > criticaldiff || A-C < -criticaldiff){
					B = HWindowWidth - A;
					D = HWindowWidth - C;
					
					if (A + C > 0 && B + D > 0){
						E = A*D - B*C;
						ChiH = E*E*2/(HWindowWidth*(A + C)*(B + D));
						*(ChiVals + X + SO*Y) = ChiH;
						if (ChiH > MChi)
							MChi = ChiH;
					}
					else
						*(ChiVals + X + SO*Y) = 0;
				}
				else
					*(ChiVals + X + SO*Y) = 0;//abs(A-C)/HWindowWidth;
			}*/
			
			//0

			A = *(WinScores + X );
			C = *(WinScores + X + LO);
			if (A - C > criticaldiff || A-C < -criticaldiff){
				B = HWindowWidth - A;
				D = HWindowWidth - C;
				
				if (A + C > 0 && B + D > 0){
					E = A*D - B*C;
					ChiH = (double)(E*E*2)/(double)(HWindowWidth*(A + C)*(B + D));
					*(ChiVals + X) = ChiH;
					if (ChiH > MChi)
						MChi = ChiH;
				}
				else
					*(ChiVals + X) = 0;
			}
			else
				*(ChiVals + X) = 0;//abs(A-C)/HWindowWidth;

			//1
			A = *(WinScores + X + FO);
			C = *(WinScores + X + LO + FO);
			if (A - C > criticaldiff || A-C < -criticaldiff){
				B = HWindowWidth - A;
				D = HWindowWidth - C;
				
				if (A + C > 0 && B + D > 0){
					E = A*D - B*C;
					
					ChiH = (double)(E*E*2)/(double)(HWindowWidth*(A + C)*(B + D));
					*(ChiVals + X + SO) = ChiH;
					if (ChiH > MChi)
						MChi = ChiH;
				}
				else
					*(ChiVals + X + SO) = 0;
			}
			else
				*(ChiVals + X + SO) = 0;//abs(A-C)/HWindowWidth;

			//2
			A = *(WinScores + X + FO*2);
			C = *(WinScores + X + LO + FO*2);
			if (A - C > criticaldiff || A-C < -criticaldiff){
				B = HWindowWidth - A;
				D = HWindowWidth - C;
				
				if (A + C > 0 && B + D > 0){
					E = A*D - B*C;
					ChiH = (double)(E*E*2)/(double)(HWindowWidth*(A + C)*(B + D));
					*(ChiVals + X + SO*2) = ChiH;
					if (ChiH > MChi)
						MChi = ChiH;
				}
				else
					*(ChiVals + X + SO*2) = 0;
			}
			else
				*(ChiVals + X + SO*2) = 0;//abs(A-C)/HWindowWidth;
		}
		else{
			
				*(ChiVals + X) = 0;
				*(ChiVals + X + SO) = 0;
				*(ChiVals + X + SO*2) = 0;
		}
	}
	return (MChi);
}

double FAR pascal CalcChiVals5(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals, int *BanWins)
{

	double A,B,C,D,E, ChiH, MChi;
	int X, LO, FO, SO, bp1;
	FO = LenSeq + HWindowWidth*2 + 1;
	SO = LenSeq + 1;
	LO = HWindowWidth;
	ChiH=0;
	MChi = 0;
	for (X = 0; X < LenXoverSeq; X++) {
		bp1=X-HWindowWidth;
		if (bp1 < 1) 
			bp1= bp1+LenXoverSeq ;
		if (BanWins[X] == 0 && BanWins[bp1] == 0){	
			A = *(WinScores + X);
			C = *(WinScores + X + LO);
			if (A - C > criticaldiff || A-C < -criticaldiff){
				B = HWindowWidth - A;
				D = HWindowWidth - C;
				if (A + C > 0 && B + D > 0){
						E = A*D - B*C;
						ChiH = E*E*2/(HWindowWidth*(A + C)*(B + D));
						*(ChiVals + X) = ChiH;
						if (ChiH > MChi)
							MChi = ChiH;
				}
				else
					*(ChiVals + X) = 0;
			}
			else
				*(ChiVals + X) = 0;
		}
		else
			*(ChiVals + X) = 0;
	}
	return (MChi);
	//return (ma);
}


int FAR pascal MakePDstMat(int NumberOfSeqs,int LS, int LenXOverSeq, int WinLen, int *XDiffpos, short int *RevSeq, short int *SeqNum, float *PDstMat){
	int X,y,Z, off1, off2, off3, off4, off5, off6, off7, o1, o2;

	//pdstmat numseqs,numseqs,1
	off1 = NumberOfSeqs+1;
	off2 = off1*off1;
	off3 = LS+1;
	for (X = 0; X <= NumberOfSeqs; X++){
		off4 = RevSeq[X]*off3;
		
		for (y = X + 1; y<= NumberOfSeqs; y++){
			off5 = RevSeq[y]*off3;
			off6 = X + y*off1;
			off7 = off6 + off2;
			//Do matrix for the first half of first window	
			for (Z = LenXOverSeq - WinLen + 1; Z <= LenXOverSeq; Z++){
				o1 = SeqNum[XDiffpos[Z] + off4];
				o2 = SeqNum[XDiffpos[Z] + off5];
				if (o1 != o2){
					if (o1 != 46){
						if (o2 != 46)
							PDstMat[off6] = PDstMat[off6] + 1;
					}

				}
                
			}
			PDstMat[y + X*off1] = PDstMat[off6];
			
			
			//Do matrix for the second half of first window
			for (Z = 1; Z<= WinLen; Z++){
				o1 = SeqNum[XDiffpos[Z] + off4];
				o2 = SeqNum[XDiffpos[Z] + off5];
				if (o1 != o2){
					if (o1 != 46){
						if (o2 != 46)
							PDstMat[off7] = PDstMat[off7] + 1;
					}

				}
                
			}
			PDstMat[y + X*off1 + off2] = PDstMat[off7];
		}
	}

	
	
	return(1);
}

int FAR pascal UpdatePDstMat(int X, int Begin1, int End2, int NumberOfSeqs, int LS, short int *SeqNum, int *XDiffpos, short int *RevSeq, float *PDstMat){
	int Z,y, of1, of2, of3, off1, off2;
	of1 = LS+1;
	//pdstmat numseqs,numseqs,1
	off1 = NumberOfSeqs+1;
	off2 = off1*off1;
	for (Z = 0; Z <= NumberOfSeqs; Z++){
        
        for (y = Z + 1; y <= NumberOfSeqs; y++){
			of2 = SeqNum[XDiffpos[Begin1] +RevSeq[y]*of1];
			of3 = SeqNum[XDiffpos[Begin1] +RevSeq[Z]*of1];
            if (of2 != 46){
				if (of3 != 46){
					if (of2 != of3)
						PDstMat[Z + y*off1] = PDstMat[Z + y*off1] - 1;
				}
			}
            of2 = SeqNum[XDiffpos[X-1] +RevSeq[y]*of1];
			of3 = SeqNum[XDiffpos[X-1] +RevSeq[Z]*of1];
            if (of2 != 46){
				if (of3 != 46){
					if (of2 != of3){
						PDstMat[Z + y*off1] = PDstMat[Z + y*off1] + 1;
						PDstMat[Z + y*off1+off2] = PDstMat[Z + y*off1+off2] - 1;
					}
				}
			}
            
            of2 = SeqNum[XDiffpos[End2] +RevSeq[y]*of1];
			of3 = SeqNum[XDiffpos[End2] +RevSeq[Z]*of1];
            if (of2 != 46){
				if (of3 != 46){
					if (of2 != of3){
						
						PDstMat[Z + y*off1+off2] = PDstMat[Z + y*off1+off2] + 1;
					}
				}
			}
            
            PDstMat[y + Z*off1] = PDstMat[Z + y*off1];
            PDstMat[y + Z*off1+off2] = PDstMat[Z + y*off1+off2];
        }
	}

	return(1);
}

int FAR pascal PPRegression(char IncSelf, int X, int ls, int NumberOfSeqs, int NSX, float *PDstMat, float *PPWinScoreT){
	int A, y, off1, off2, off3;
	double SumX,SumY,SumXY,SumX2,SumY2, NS, AA, BB, bb1,bb2, o4,o5;
	
	//pdstmat numseqs,numseqs,1
	//ppwinscoret lenxoverseq,numseqs
	NS = (double)(NSX);
	off1 = ls+1;
	off2 = NumberOfSeqs+1;
	off3 = off2*off2;
	for (A = 0; A <= NumberOfSeqs; A++){
       
            SumX = 0;
            SumY = 0;
            SumXY = 0;
            SumX2 = 0;
            SumY2 = 0;
            for (y = 0; y <= NumberOfSeqs; y++){
                if (A != y || IncSelf == 1){
                    o4 = PDstMat[A + y*off2];
					o5 = PDstMat[A + y*off2 + off3];
					SumX = SumX + o4;
                    SumY = SumY + o5;
                    SumXY = SumXY + o4 * o5;
                    SumX2 = SumX2 + o4 * o4;
                    SumY2 = SumY2 + o5 * o5;
                    
                }
            }
            
            
            if (SumX2 > 0 && SumY2 > 0){
                AA = (NS * SumXY) - (SumX * SumY);
				bb1 = NS * SumX2 - SumX * SumX;
				bb1 = sqrt(bb1);
				bb2 = NS * SumY2 - SumY * SumY;
                bb2 = sqrt(bb2);
				BB =  bb1*bb2;
                
                if (BB > 0)
                    PPWinScoreT[X + A*off1] = (float)(AA / BB);
                else
                    PPWinScoreT[X + A*off1] = (float)(1);
               
			}
            else
                PPWinScoreT[X + A*off1] = (float)(1);
            
            
    }


	return(1);
}

double FAR pascal CalcChiVals3(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals)
{

	double A,B,C,D,E, ChiH, MChi;
	int X, Y, LO, FO, SO;
	FO = LenSeq + HWindowWidth*2 + 1;
	SO = LenSeq + 1;
	LO = HWindowWidth;
	ChiH=0;
	MChi = 0;
	Y=0;
	for (X = 0; X < LenXoverSeq; X++) {
		
			A = *(WinScores + X);
			C = *(WinScores + X + LO);
			B = HWindowWidth - A;
			D = HWindowWidth - C;
				
			if (A + C > 0 && B + D >0){
					E = A*D - B*C;
					ChiH = E*E*2/(HWindowWidth*(A + C)*(B + D));
					*(ChiVals + X) = ChiH;
					if (ChiH > MChi){
						MChi = ChiH;
						//ma=A;
					}
			}
			else
				*(ChiVals + X) = 0;
	
	}
	return (MChi);
	//return (ma);
}



double FAR pascal CalcChiVals2(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals)
{

	double A,B,C,D,E, ChiH, MChi;
	int X,  LO, FO, SO;
	FO = LenSeq + HWindowWidth*2 + 1;
	SO = LenSeq + 1;
	LO = HWindowWidth - 1;
	ChiH=0;
	MChi = 0;
	for (X = 0; X < LenXoverSeq; X++) {
		//for (Y = 0; Y <= 2;Y++){
			A = *(WinScores + X );
			C = *(WinScores + X + LO);
				B = HWindowWidth - A;
				D = HWindowWidth - C;
				
				if (A + C > 0 && B + D >0){
					E = A*D - B*C;
					ChiH = E*E*2/(HWindowWidth*(A + C)*(B + D));
					*(ChiVals + X ) = ChiH;
					if (ChiH > MChi)
						MChi = ChiH;
				}
				else
					*(ChiVals + X ) = 0;
		//}
	}
	return (MChi);
}

int FAR pascal GetPScores(int X, int SSWinLen, short int Seq1, short int Seq2,short int Seq3,short int oSeq, int slen,char *PScores, char *Seq34Conv, short int *SeqScore3, short int *SeqNum)
{
	int Y,HN,HI;
	for (Y = 0; Y < SSWinLen; Y++){ 
		HN = SeqScore3[X + Y];
		HI = *(SeqNum + X + Y + oSeq*(slen+1));
		if(*(SeqNum + X + Y + Seq1*(slen+1)) == HI)
			PScores[Y + 1] = *(Seq34Conv + HN + 1*6);
		else {
			if (HN == 1){
			
				if (*(SeqNum + X + Y + Seq2*(slen+1)) == HI)
					PScores[Y + 1] = *(Seq34Conv + HN + 2*6);
				else if (*(SeqNum + X + Y + Seq3*(slen+1)) == HI)
					PScores[Y + 1] = *(Seq34Conv + HN + 3*6);
				else
					PScores[Y + 1] = *(Seq34Conv + HN + 4*6);
			}
                                                
			else if (HN == 2){
				if (*(SeqNum + X + Y + Seq3*(slen+1)) == HI)
					PScores[Y + 1] = *(Seq34Conv + HN + 3*6);
				else
					 PScores[Y + 1] = *(Seq34Conv + HN + 4*6);
			}                     
			else if (HN == 3 || HN == 4){
				if (*(SeqNum + X + Y + Seq2*(slen+1)) == HI)
					PScores[Y + 1] = *(Seq34Conv + HN + 2*6);
				else
					PScores[Y + 1] = *(Seq34Conv + HN + 4*6);
			}
			
				                                                    
			else
					PScores[Y + 1] = *(Seq34Conv + HN + 4*6);
                                                    
			
		}
	}
	return 1;
}


int FAR pascal GetPScores2(int X, int SSWinLen, short int Seq1, short int Seq2,short int Seq3,short int oSeq, int slen,int *PScores, char *Seq34Conv, short int *SeqScore3, short int *SeqNum)
{
	int Y,HN,HI, Z, os0, os1, os2, os3;
	

	os0 = oSeq*(slen+1);
	os1 = Seq1*(slen+1);
	os2 = Seq2*(slen+1);
	os3 = Seq3*(slen+1);

	for (Z=0; Z <=15; Z++)
		PScores[Z] =0;
	
	for (Z = 0; Z < SSWinLen; Z++){ 
		if (Z + X <= slen)
			Y = Z + X;
		else
			Y = Z + X - slen;
		
		HN = SeqScore3[Y];

		HI = SeqNum [Y + os0];
		
		if(SeqNum[Y + os1] == HI)
			PScores[Seq34Conv [HN + 6]] += 1;
		else {
			if (HN == 1){
			
				if (SeqNum[Y + os2] == HI)
					PScores[Seq34Conv [HN + 12]] += 1;
				else if (SeqNum[Y + os3] == HI)
					PScores[Seq34Conv [HN + 18]] += 1;
				else
					PScores[Seq34Conv [HN + 24]] += 1;
			}
                                                
			else if (HN == 2){
				if (SeqNum[Y + os3] == HI)
					PScores[Seq34Conv [HN + 18]] += 1;
				else
					PScores[Seq34Conv [HN + 24]] += 1;
			}                     
			else if (HN == 3 || HN == 4){
				if (SeqNum[Y + os2] == HI)
					PScores[Seq34Conv [HN + 12]] += 1;
				else
					PScores[Seq34Conv [HN + 24]] += 1;
			}
			
				                                                    
			else
					PScores[Seq34Conv [HN + 24]] += 1;
                                                    
		}
	}
	return 1;
}


int FAR pascal GetPScores4(int X, int SSWinLen, short int Seq1, short int Seq2,short int Seq3,short int oSeq, int slen,char *PScores, char *Seq34Conv, short int *SeqScore3, short int *SeqNum,  short int *SimSeqNum)
{
	int Y,HN,HI;
	for (Y = 0; Y < SSWinLen; Y++){ 
		HN = SeqScore3[X + Y];
		HI = *(SimSeqNum + X + Y + oSeq*(slen+1));
		if(*(SeqNum + X + Y + Seq1*(slen+1)) == HI)
			PScores[Seq34Conv [HN + 1*6]] += 1;
		else {
			if (HN == 1){
			
				if (*(SeqNum + X + Y + Seq2*(slen+1)) == HI)
					PScores[Seq34Conv [HN + 2*6]] += 1;
				else if (*(SeqNum + X + Y + Seq3*(slen+1)) == HI)
					PScores[Seq34Conv [HN + 3*6]] += 1;
				else
					PScores[Seq34Conv [HN + 4*6]] += 1;
			}
                                                
			else if (HN == 2){
				if (*(SeqNum + X + Y + Seq3*(slen+1)) == HI)
					PScores[Seq34Conv [HN + 3*6]] += 1;
				else
					 PScores[Seq34Conv [HN + 4*6]] += 1;
			}                     
			else if (HN == 3 || HN == 4){
				if (*(SeqNum + X + Y + Seq2*(slen+1)) == HI)
					PScores[Seq34Conv [HN + 2*6]] += 1;
				else
					PScores[Seq34Conv [HN + 4*6]] += 1;
			}
			
				                                                    
			else
					PScores[Seq34Conv [HN + 4*6]] += 1;
                                                    
		}
	}
	return 1;
}

int FAR pascal ReSortArray(int Y, int NumWins, int PosAIn, int ReadNo, int BSBootReps, short int *BSFileBuffer, short int *SortArray)
{
	int Z, A, PosAOut;
	for (Z = 0; Z < ReadNo; Z++){
		for(A = 0; A < BSBootReps; A++){
           BSFileBuffer[A + Y * BSBootReps + Z * BSBootReps * NumWins] = SortArray[PosAIn];
           PosAIn ++;
		}
    }
	PosAOut = PosAIn;
	return PosAOut;
}

int FAR pascal GetPScoresRnd(int X, int SSWinLen, short int Seq1, short int Seq2,short int Seq3,short int oSeq, int slen,int *PScores, char *Seq34Conv, short int *SeqScore3, short int *SeqNum, int *HRndTemplate)
{
	int Y,HN,HI,hios;
	for (Y = 0; Y < SSWinLen; Y++){ 
		HN = SeqScore3[X + Y];
		hios = X + HRndTemplate[Y + 1];
		HI = *(SeqNum + X + hios + Seq1*(slen+1));
		if(*(SeqNum + X + Y + Seq1*(slen+1)) == HI)
			PScores[Seq34Conv [HN + 1*6]] += 1;
		else {
			if (HN == 1){
			
				if (*(SeqNum + X + Y + Seq2*(slen+1)) == HI)
					PScores[Seq34Conv [HN + 2*6]] += 1;
				else if (*(SeqNum + X + Y + Seq3*(slen+1)) == HI)
					PScores[Seq34Conv [HN + 3*6]] += 1;
				else
					PScores[Seq34Conv [HN + 4*6]] += 1;
			}
                                                
			else if (HN == 2){
				if (*(SeqNum + X + Y + Seq3*(slen+1)) == HI)
					PScores[Seq34Conv [HN + 3*6]] += 1;
				else
					 PScores[Seq34Conv [HN + 4*6]] += 1;
			}                     
			else if (HN == 3 || HN == 4){
				if (*(SeqNum + X + Y + Seq2*(slen+1)) == HI)
					PScores[Seq34Conv [HN + 2*6]] += 1;
				else
					PScores[Seq34Conv [HN + 4*6]] += 1;
			}
			
				                                                    
			else
					PScores[Seq34Conv [HN + 4*6]] += 1;
                                                    
		}
	}
	return 1;
}

int FAR pascal Get3Score (char SSGapFlag, int LSeq, short int seq1, short int seq2, short int seq3, short int *SeqNum, short int *SeqScore3){
	int X,os;
	int s1, s2, s3;
	os=LSeq+1;
	if (SSGapFlag == 0){
		for (X = 1; X <= LSeq;X++){
			s1 = *(SeqNum + X + seq1*os);
			s2 = *(SeqNum + X + seq2*os);
			s3 = *(SeqNum + X + seq3*os);
			if (s1 != 46 && s2 != 46  && s3 != 46){
				if (s1 == s2){
					if (s1 == s3)
						SeqScore3[X] = 5;
                    else
						SeqScore3[X] = 2;
				}
                else if (s1 == s3)
					SeqScore3[X] = 3;
                else if (s2 == s3)
					SeqScore3[X] = 4;
                else
					SeqScore3[X] = 1;
			}
			else
				SeqScore3[X] = 0;
				//return s1;
		}
	}
	else{                        
         
		for (X = 1; X <= LSeq;X++){
                                
            s1 = *(SeqNum + X + seq1*os);
			s2 = *(SeqNum + X + seq2*os);
			s3 = *(SeqNum + X + seq3*os);
			
			if (s1 == s2){
				if (s1 == s3)
					SeqScore3[X] = 5;
                else
					SeqScore3[X] = 2;
			}
            
			else if (s1 == s3)
				SeqScore3[X] = 3;
            else if (s2 == s3)
				SeqScore3[X] = 4;
            else
				SeqScore3[X] = 1;
		}
	}
	return 1;
}

int FAR pascal DoSums (int SSNumPerms,int SSNumPerms2,int *PermSScores, int *PermPScores){
	int Z,os,  ops2,  ops3, ops4, ops5, ops6, ops7, ops8, ops9, ops10, ops11, ops12, ops13,ops14;
	os = SSNumPerms+1;
	ops2 = os*2;
	ops3 = os*3;
	ops4 = os*4;
	ops5 = os*5;
	ops6 = os*6;
	ops7 = os*7;
	ops8 = os*8;
	ops9 = os*9;
	ops10 = os*10;
	ops11 = os*11;	
	ops12 = os*12;
	ops13 = os*13;
	ops14 = os*14;
	//osx = PermPScores[ops2] + PermPScores[ops7] +  PermPScores[ops8];
	if (PermPScores[ops2] + PermPScores[ops7] +  PermPScores[ops8] > 0){
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + os] =  PermPScores[Z + ops2] + PermPScores[Z + ops7] +  PermPScores[Z + ops8];
	}
	else{
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + os] =  0;
	}
	
	if (PermPScores[ops3] + PermPScores[ops6] + PermPScores[ops9] > 0){
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + ops2] = PermPScores[Z + ops3] + PermPScores[Z + ops6] + PermPScores[Z + ops9];
	}
	else{
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + ops2] =  0;
	}
	
	if (PermPScores[ops4] + PermPScores[ops5] + PermPScores[ops10]>0){
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores[Z + ops3] = PermPScores[Z + ops4] + PermPScores[Z + ops5] + PermPScores[Z + ops10];
	}
	else{
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + ops3] =  0;
	}
	if (PermPScores[ops2] + PermPScores[ops8] + PermPScores[ops12] + PermPScores[ops11]>0){
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + ops4] = PermPScores[Z + ops2] + PermPScores[Z + ops8] + PermPScores[Z + ops12] + PermPScores[Z + ops11];
	}
	else{
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + ops4] =  0;
	}

	if(PermPScores[ops3] + PermPScores[ops9] + PermPScores[ops13] + PermPScores[ops11]>0){
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores[Z + ops5] = PermPScores[Z + ops3] + PermPScores[Z + ops9] + PermPScores[Z + ops13] + PermPScores[Z + ops11];
	}
	else{
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + ops5] =  0;
	}
	if (PermPScores[ops5] + PermPScores[ops10] + PermPScores[ops14] + PermPScores[ops11]>0){
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores[Z + ops7] = PermPScores[Z + ops5] + PermPScores[Z + ops10] + PermPScores[Z + ops14] + PermPScores[Z + ops11];
	}
	else{
		for (Z = 0; Z <= SSNumPerms2; Z++)
			PermSScores [Z + ops7] =  0;
	}
	return 1;
}


int FAR pascal FillMatrix (int LSeq, int Beginning, int Ending, double Dst,  double *RecombMatrix){

	int A,Z, GoOn, OS;
	GoOn = 1;
	OS = LSeq+1;
	/*for (Z = Beginning; Z <=  Ending; Z++){
		if (DstString[Z] < Dst){ 
			DstString[Z] = Dst;
			GoOn = 1;
		}
	}*/
    if (Beginning < Ending){
		           
                
		for (Z = 1; Z < Beginning; Z++){
			for (A = Beginning; A<= Ending;A++){
				if (RecombMatrix[Z + A*OS] < Dst) 
					RecombMatrix[Z + A*OS] = Dst;
			}
		}
		for (Z = Beginning; Z <= Ending;Z++){
			for (A = 1; A < Beginning; A++){
				if (RecombMatrix[Z + A*OS] < Dst) 
					RecombMatrix[Z + A*OS] = Dst;
			}
            for (A = Ending + 1; A <= LSeq;A++){
				if (RecombMatrix[Z + A*OS] < Dst) 
					RecombMatrix[Z + A*OS] = Dst;
			}
		}
		for (Z = Ending+1; Z < LSeq; Z++){
			for (A = Beginning; A<= Ending;A++){
				if (RecombMatrix[Z + A*OS] < Dst) 
					RecombMatrix[Z + A*OS] = Dst;
			}
		}
	}
	else{
		for (Z = Ending + 1; Z < Beginning; Z++){
			for (A = 1; A<= Ending;A++){
				if (RecombMatrix[Z + A*OS] < Dst) 
					RecombMatrix[Z + A*OS] = Dst;
			}
			for (A = Beginning; A<= LSeq;A++){
				if (RecombMatrix[Z + A*OS] < Dst) 
					RecombMatrix[Z + A*OS] = Dst;
			}
		}
		for (Z = 1; Z <= Ending;Z++){
			for (A = Ending+1; A < Beginning; A++){
				if (RecombMatrix[Z + A*OS] < Dst) 
					RecombMatrix[Z + A*OS] = Dst;
			}
		}
		for (Z = Beginning; Z <= LSeq;Z++){
			for (A = Ending+1; A < Beginning; A++){
				if (RecombMatrix[Z + A*OS] < Dst) 
					RecombMatrix[Z + A*OS] = Dst;
			}
		}
	
	}
	return 1;

}

int FAR pascal FillMatrixB (int LSeq, int Beginning, int Ending, double *Dstma,double *Dstmi,  double *RecombMatrix){

	int A,Z, GoOn, OS;
	GoOn = 1;
	OS = LSeq+1;
	/*for (Z = Beginning; Z <=  Ending; Z++){
		if (DstString[Z] < Dst){ 
			DstString[Z] = Dst;
			GoOn = 1;
		}
	}*/
    if (Beginning < Ending){
		           
                
		for (Z = 1; Z < Beginning; Z++){
			for (A = Beginning; A<= Ending;A++){
				if (RecombMatrix[Z + A*OS] < Dstma[A]) 
					RecombMatrix[Z + A*OS] = Dstma[A];
			}
		}
		for (Z = Beginning; Z <= Ending;Z++){
			for (A = 1; A < Beginning; A++){
				if (RecombMatrix[Z + A*OS] < Dstmi[A]) 
					RecombMatrix[Z + A*OS] = Dstmi[A];
			}
            for (A = Ending + 1; A <= LSeq;A++){
				if (RecombMatrix[Z + A*OS] < Dstmi[A]) 
					RecombMatrix[Z + A*OS] = Dstmi[A];
			}
		}
		for (Z = Ending+1; Z < LSeq; Z++){
			for (A = Beginning; A<= Ending;A++){
				if (RecombMatrix[Z + A*OS] < Dstma[A]) 
					RecombMatrix[Z + A*OS] = Dstma[A];
			}
		}
	}
	else{
		for (Z = Ending + 1; Z < Beginning; Z++){
			for (A = 1; A<= Ending;A++){
				if (RecombMatrix[Z + A*OS] < Dstmi[A]) 
					RecombMatrix[Z + A*OS] = Dstmi[A];
			}
			for (A = Beginning; A<= LSeq;A++){
				if (RecombMatrix[Z + A*OS] < Dstmi[A]) 
					RecombMatrix[Z + A*OS] = Dstmi[A];
			}
		}
		for (Z = 1; Z <= Ending;Z++){
			for (A = Ending+1; A < Beginning; A++){
				if (RecombMatrix[Z + A*OS] < Dstmi[A]) 
					RecombMatrix[Z + A*OS] = Dstmi[A];
			}
		}
		for (Z = Beginning; Z <= LSeq;Z++){
			for (A = Ending+1; A < Beginning; A++){
				if (RecombMatrix[Z + A*OS] < Dstmi[A]) 
					RecombMatrix[Z + A*OS] = Dstmi[A];
			}
		}
	
	}
	return 1;

}


int FAR pascal FindNextRedo(int Start, char *Relevant2, int *RedoList, int *iseqs, int *relevant){
	
	int X , Y, score;
	for (X = Start; X >= 0; X--){
		if (relevant[RedoList[1 + X*4]] == 1 && relevant[RedoList[2 + X*4]] == 1 && relevant[RedoList[3 + X*4]] == 1){
			score=0;
			for (Y = 1; Y < 4; Y++){
				if (iseqs[0] == RedoList[Y + X*4])
					score++;
				if (iseqs[1] == RedoList[Y + X*4])
					score++;
				if (iseqs[2] == RedoList[Y + X*4])
					score++;
				if (score > 1)
					return(X);
					
			}
		}
	}
	return(X);
}

double FAR pascal MakeVRand (int numtodo, int nseed, int numperms, int lseq, char *vrandtemplate)
{
	int x,y,vo,rf;
	double rn,rm;
	vo = lseq+1;

	srand(nseed);
	rn=rand();
	rm = RAND_MAX;
	for (x = 0; x <= numperms; x++){
		for (y = 0;y <= numtodo; y++){
			rn=rand();
			rn/=rm;
			rn*=11.999;
			rn++;
			rf= (int)(rn);
			*(vrandtemplate + y + x*vo) = rf;
		}
	}
	return 1;
}

int FAR pascal DoPermsX(int LS,int SSWinLen, int SSNumPerms, char *PScores, char *VRandTemplate, char *VRandConv, int *PermPScores)
{
	int Z, B;
	int HN,HN1,HN2, HN3;
	int vo;
	int os2, os3;
	os2 = (SSNumPerms+1);
	vo = LS + 1;

    for (Z = 1; Z <= SSWinLen; Z++){
		HN = (int)(PScores[Z]);
		HN=HN*os2;
        PermPScores [HN] =  PermPScores [HN] + 1;
	}
	
	for (Z = 1; Z <= SSNumPerms; Z++){
		os3 = Z*vo;
		for (B = 1; B <= SSWinLen; B++){
			HN1 = (int)(PScores[B]);
			HN2 = (int)(VRandTemplate [B + os3]);
			HN2 = HN1+HN2*16;
            HN3 = VRandConv [HN2];
			HN3 = Z + HN3*os2;
            PermPScores [HN3] = PermPScores [HN3] + 1;
		}
    }
	return 1;
}


int FAR pascal DoPerms(int LS,int SSWinLen, int SSNumPerms, char *PScores, char *VRandTemplate, char *VRandConv, int *PermPScores)
{
	int Z, B;
	int HN,HN1,HN2, HN3;
	int vo;
	vo = LS + 1;

    for (Z = 1; Z <= SSWinLen; Z++){
		HN = PScores[Z];
        *(PermPScores + (SSNumPerms+1)*HN) =  *(PermPScores + (SSNumPerms+1)*HN) + 1;
	}
	for (B = 1; B <= SSWinLen; B++){
        HN1 = PScores[B];
        for (Z = 1; Z <= SSNumPerms; Z++){
			HN2 = *(VRandTemplate + B + Z*vo);
            HN3 = *(VRandConv + HN1 + 16*HN2);
            *(PermPScores + Z + (SSNumPerms+1)*HN3) =*(PermPScores + Z + (SSNumPerms+1)*HN3) + 1;
		}
    }
	return 1;
}


int FAR pascal DrawRDPPlot(int Y, int LenXoverSeq, int UBL, int RDPLD, int RDPUD, int PicHeight, HDC Pict, double XFactor, int *XDiffpos,  int *XOverHomologyNum){

	int X, off1, off2, OXP, XP, YP, MiY, MaY;
	MiY = 0;
	MaY = 0;
	double h1,PH, RD;
	//ReDim XOverHomologyNum(LenXoverSeq + XOverWindow * 2, 2)
	//UBL = LenXoverSeq + XOverWindow * 2
	PH  = (PicHeight - 35);
	RD = RDPUD - RDPLD;

	off1 = UBL+1;
    off2 = off1*Y;
	h1 = (double)(XOverHomologyNum[LenXoverSeq + off2] - RDPLD);
	MoveToEx (Pict, (int)(30 + XDiffpos[1] * XFactor), (int)(PicHeight - (15 + (((double)(h1 / RD))) * PH)),0);
	OXP=0;
    for (X = 1; X <= LenXoverSeq; X++){
		h1 = (double)(XOverHomologyNum[X + off2] - RDPLD);
		XP = (int)(30 + XDiffpos[X] * XFactor + XFactor);
		YP = (int)(PicHeight - (15 + (((double)(h1 / RD))) * PH));
		if (OXP != XP){
            MiY = 10000;
            MaY = 0;
		}
        OXP = XP;
        if (YP > MaY || YP < MiY ){
            LineTo (Pict, XP, YP);
            if (YP > MaY)
				MaY = YP;
            if (YP < MiY) 
				MiY = YP;
		}

		
	
	}
	
	return(1);
}


int FAR pascal MakeDistX (int Seq1, int Seq2,int Seq3,int LS, float *DistanceX, short int *SeqNum){
	int X, s1, s2, s3, ValidX, os, os1,os2, os3;

	os = LS+1;
	os1 = Seq1*os;
	os2 = Seq2*os;
	os3 = Seq3*os;
	DistanceX[0] = 0;
	DistanceX[1] = 0;
	DistanceX[2] = 0;
	ValidX=0;
    for (X = 0; X <= LS; X++){      
		s1 = SeqNum[X + os1];
        if (s1 != 46){
			s2 = SeqNum[X + os2];
			if (s2 != 46){
				s3 = SeqNum[X + os3];
				if( s3 != 46){
					ValidX ++;
					if (s1 != s2) 
						DistanceX[0] = DistanceX[0] + 1;
					if (s1 != s3) 
						DistanceX[1] = DistanceX[1] + 1;
					if (s2 != s3) 
						DistanceX[2] = DistanceX[2] + 1;
				
				}
			}
		}
    }
	return (ValidX);
}


int FAR pascal FindMaxZ(int HV, int LV1, int LV2, int LV3, int WinNum, int FHPos, int SHPos, char *SeqMap, char *DoGroupS, char *DoGroupP, double *maxz, double *winp, double *winscore, char *wps, double *ZSScoreHolder, double *ZPScoreHolder){


//ZSScoreHolder =winnum,14
//ZPScoreHolder =winnum,15
// dogroup 1,2
	
	int X, Z,  os, os2;
	double MaxZ, WinP,WinScore; 
	char WPS;
	os = WinNum+1;

	WinScore=0;
	MaxZ = 0;
    WinP = 0;
    WPS = 0;


	for (X = 0; X <= WinNum; X++)
		SeqMap[X] = HV;
                        

	for (X = FHPos; X<= SHPos; X++){
        
        MaxZ = 0;
        WinP = 0;
        WPS = 0;
        
        
           
        //find maxz at this position
        
        for (Z = 0; Z<= 15; Z++){
            os2 = Z*os;
            if (ZPScoreHolder[X + os2] > MaxZ){
                MaxZ = ZPScoreHolder[X + os2];
                WinP = Z;
                WinScore = Z;
                WPS = 1;
            }
        }
        for (Z = 0; Z<= 14; Z++){
			os2 = Z*os;
            if (ZSScoreHolder[X + os2] > MaxZ){
                MaxZ = ZSScoreHolder[X + os2];
                WinP = Z;
                WinScore = Z;
                WPS = 0;
            }
        }
        if (WPS == 0){ 
            if (DoGroupS[1 + LV1*2] == WinP || DoGroupS[LV1*2] == WinP)
                SeqMap[X] = LV1;
            else if (DoGroupS[1 + LV2*2] == WinP || DoGroupS[LV2*2] == WinP)
                SeqMap[X] = LV2;
            else if (DoGroupS[1 + LV3*2] == WinP || DoGroupS[LV3*2] == WinP)
                SeqMap[X] = LV3;
		}
        else{
            if (DoGroupP[1 + LV1*2] == WinP || DoGroupP[LV1*2] == WinP)
                SeqMap[X] = LV1;
            else if (DoGroupP[1 + LV2*2] == WinP || DoGroupP[LV2*2] == WinP)
                SeqMap[X] = LV2;
			else if (DoGroupP[1 + LV3*2] == WinP || DoGroupP[LV3*2] == WinP)
                SeqMap[X] = LV3;
        }
        
    }
	*maxz = MaxZ;
    *winp = WinP;
    *wps = WPS;
	*winscore = WinScore;
	return(1);




}



int FAR pascal ShrinkRegionC(int LS, int SSGapFlag, int SSStep, int SSWinLen, int HVX, int Seq1, int Seq2, int Seq3, int EP, int SP, int *TEnd,int *TBegin, short int *SeqNum ){

	int Hi1, Hi2, LO, Z, os, os1, os2, os3, s1, s2, s3, tbegin, tend;
	tbegin=0;
	tend=0;
	os = LS+1;

    if (HVX == 0){
        Hi1 = Seq1;
		Hi2 = Seq2;
		LO = Seq3;
	}
	else if (HVX == 1){
        Hi1 = Seq1;
		Hi2 = Seq3; 
		LO = Seq2;
	}
    else {
       Hi1 = Seq2;
	   Hi2 = Seq3;
	   LO = Seq1;
	}   

	os1 = Hi1*os;
	os2 = Hi2*os;
	os3 = LO*os;
    if (EP >= SP){
        for (Z = (SP * SSStep); Z <= (EP * SSStep + SSWinLen); Z++){
			s1 = SeqNum[Z + os1];
			s2 = SeqNum[Z + os2];
			s3 = SeqNum[Z + os3];
            if (SSGapFlag == 1 || (s1 != 46 && s2 !=46 && s3 != 46)) {
                if (s1 == s2 && s1 != s3) {
                    tbegin = Z;
                    break;
                }
            }
        }
                                                                
        for (Z = (EP * SSStep + SSWinLen); Z >=  SP * SSStep; Z--){
			s1 = SeqNum[Z + os1];
			s2 = SeqNum[Z + os2];
			s3 = SeqNum[Z + os3];
            if (SSGapFlag == 1 || (s1 != 46 && s2 !=46 && s3 != 46)) {
                
                if (s1 == s2 && s1 != s3) {
                    tend = Z;
                    break;
                }
            }
        }
	}                                      
    else{
        for (Z = SP; Z <= LS; Z++){
            s1 = SeqNum[Z + os1];
			s2 = SeqNum[Z + os2];
			s3 = SeqNum[Z + os3];
            if (SSGapFlag == 1 || (s1 != 46 && s2 !=46 && s3 != 46)) {
                if (s1 == s2 && s1 != s3) {
                    tbegin = Z;
                    break;
                }
            }
        }
        
        if (tbegin != Z ){
            for (Z = 1; Z<= EP * SSStep + SSWinLen; Z++){
                s1 = SeqNum[Z + os1];
				s2 = SeqNum[Z + os2];
				s3 = SeqNum[Z + os3];
				if (SSGapFlag == 1 || (s1 != 46 && s2 !=46 && s3 != 46)) {
					if (s1 == s2 && s1 != s3) {
						tbegin = Z;
						break;
					}
				}
            }
        }
        
        for (Z = EP * SSStep + SSWinLen; Z >= 1; Z--){
            s1 = SeqNum[Z + os1];
			s2 = SeqNum[Z + os2];
			s3 = SeqNum[Z + os3];
			if (SSGapFlag == 1 || (s1 != 46 && s2 !=46 && s3 != 46)) {
                
                if (s1 == s2 && s1 != s3) {
                    tend = Z;
                    break;
                }
            }
        }
                                                    
		if (tend != Z){
            for (Z = LS; Z >= SP * SSWinLen; Z--){
				s1 = SeqNum[Z + os1];
				s2 = SeqNum[Z + os2];
				s3 = SeqNum[Z + os3];    
				if (SSGapFlag == 1 || (s1 != 46 && s2 !=46 && s3 != 46)) {
                
					if (s1 == s2 && s1 != s3) {
						tend = Z;
						break;
					}
				}
			}
		}
        
    }


	*TBegin = tbegin;
	*TEnd = tend;
	return(0);
}

int FAR pascal DoPerms3(int LS,int SSWinLen, int SSNumPerms, int SSNumPerms2, int *PScores, char *VRandTemplate, char *VRandConv, int *PermPScores)
{
	int Z, B;
	int a,c,HN1,  os, os2, os3, os4;
	int vo;
	vo = LS + 1;
	
	//PermPScores[0] = PScores[0];
	//PermPScores[1] = PScores[1]; 
	//PermPScores[15] = PScores[15];
    //PermPScores -numprems,15
	os = (SSNumPerms+1);
	
	for (B = 2; B <= 14; B++){
        os2 = B*os;
		for (Z = 0; Z <= SSNumPerms2; Z++)
				PermPScores [Z + os2] = 0;
				
		
	
    }

	for (Z = 0; Z <= 15; Z++)
		PermPScores[Z*os] = PScores[Z];
	

	os3 = 15*os;
	
	c=0;
	for (B = 2; B <= 14; B++){
        if (PScores[B] > 0){
		
			HN1 = PScores[B];
			for(a=0; a < HN1; a++){
				os4 = c-1;
				for (Z = 1; Z <= SSNumPerms2; Z++)
					PermPScores[Z + os*VRandConv[B + 16*VRandTemplate[Z+os4]]] += 1;
					
				
				c=c+SSNumPerms2;
			}
		}
    }
	return c;
}

int FAR pascal DoPerms2(int LS,int SSWinLen, int SSNumPerms, char *PScores, char *VRandTemplate, char *VRandConv, int *PermPScores)
{
	int Z, B;
	
	int vo,vo2;
	vo = LS + 1;
	vo2 = SSNumPerms+1;
    for (Z = 1; Z <= SSWinLen; Z++)
		PermPScores [vo2*PScores[Z]] += 1;
	
	for (B = 1; B <= SSWinLen; B++){
        for (Z = 1; Z <= SSNumPerms; Z++)
            PermPScores [Z + vo2*VRandConv[PScores[B] + 16*VRandTemplate[B + Z*vo]]] += 1;
    }
	return 1;
}


int FAR pascal FindSubSeq(int *ah, short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, int nextno,int seq1,int seq2,int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,char *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff, short int *validspacer)

//int FAR pascal FindSubSeq(short int lenseq,short int seq1,short int seq2,short int seq3, short int *seqnum, short int *xoverseqnum)

{ 
	
	int hoc, oc, b,x,z, lenseq2,xoverwindow2,xoverwindow4,xow, wmx,wpx;
	int s1,s2,s3,sz,os1,os2, se1,se2,se3, ah0, ah1,ah2;//,so1,so2,so3;
	int holder = 0;
	int y = 0;
	int g=0;

	se1 = seq1*lenseq;
	se2 = seq2*lenseq;
	se3 = seq3*lenseq;
	oc = 0;
	hoc=0;
	xow = xoverwindow;
	lenseq2=lenseq*2;
	xoverwindow2=xoverwindow*2;
    xoverwindow4=xoverwindow*4;
	os1 = xoverwindow + lenseq + xoverwindow2;
	os2 = xoverwindow + lenseq2 + xoverwindow4;
	ah0=0;
	ah1=0;
	ah2=0;
	
	if (spacerflag==0){
		//so1 = seq1*lenseq;
		//so2 = seq2*lenseq;
		//so3 = seq3*lenseq;
		hoc = xoverwindow*10;
		
		for (x = 1; x < lenseq; x++){
			

			
			s1 = seqnum[x + se1];
			
			if (s1 != 46){
				s2 = seqnum[x + se2];
				if (s2 != 46){  
					s3 = seqnum[x + se3];
					if (s3 != 46){
						if (s1 != s2) {
						//if (s1 == s2 || s1 == s3 || s2 == s3){
					
									
								if (s1 == s3){ 
									y++;
									xoverseqnumw[y + xoverwindow] = 0;
									xoverseqnumw[y + os1] = 1;
									xoverseqnumw[y + os2] = 0;
                                    ah1++;    
									xdiffpos[y] = x;
									//xposdiff[x] = y;
								}
								else if (s2 == s3){ 
									y++;
									xoverseqnumw[y + xoverwindow] = 0;
									xoverseqnumw[y + os1] = 0;
									xoverseqnumw[y + os2] = 1;
                                    ah2++;    
									xdiffpos[y] = x;
									//xposdiff[x] = y;
								}

								
							//}
						}
						else if (s1 != s3) {
						//if (s1 == s2 || s1 == s3 || s2 == s3){
					
									
								if (s1 == s2){   
									y++;
									xoverseqnumw[y + xoverwindow] = 1;
									xoverseqnumw[y + os1] = 0;
									xoverseqnumw[y + os2] = 0;
                                    ah0++;    
									xdiffpos[y] = x;
									//xposdiff[x] = y;
								}
								else if (s2 == s3){ 
									y++;
									xoverseqnumw[y + xoverwindow] = 0;
									xoverseqnumw[y + os1] = 0;
									xoverseqnumw[y + os2] = 1;
                                    ah2++;    
									xdiffpos[y] = x;
									//xposdiff[x] = y;
								}
								
							//}
						}
					}    
				}
			}

			xposdiff[x] = y;
			
		}
	//return(ah1);	
	}
	
	else if (spacerflag==1){
		for (x = 1; x < lenseq; x++){
			
				*(xposdiff + x) = y;
				s1 = *(seqnum + x + se1);
				s2 = *(seqnum + x + se2);
				s3 = *(seqnum + x + se3);
				
				if (s1 != s2 || s1 != s3) {
					
					if (s1 == s2 || s1 == s3 || s2 == s3){
					 
						if (s1 != 46  ){
							if (s2 != 46){
								if (s3 != 46){
									if (s1  !=  s2 && s1 != s3) {
									//If seq1 is odd one
										
										
										if (outlyer == seq1){
											if (oc > 0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											
										}
										else {
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
												if (sz == s1) {
												//If difference is legitimate
													if( *(xdiffpos + y) != x){
														oc += 2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
														
													}
															
												}
												
											}
													
										}
									}
									else if (s2  != s1  && s2  != s3) {
										//If seq2 is odd one
										
										if (outlyer == seq2){
											if (oc >0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
													
										}
										else{
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
												if (s2 == sz){
												//If difference is legitimate
                                        
													if( *(xdiffpos + y) != x){
														oc+=2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
															
													}
												}
											}
										}
									}
									else if (s3  != s1  && s3  != s2) {
									//If seq3 is odd one
										if (outlyer == seq3){
											if (oc >0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											
																			
										}
										else{
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
												if (s3 == sz){
															
												//If difference is legitimate
													if( *(xdiffpos + y) != x){
														oc+=2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
													}
												}
											}
										}
								
									}
								}
							}
						}    
					}
				}
			
		}
		
	}
	else if (spacerflag>1){

	
		for (x = 1; x < lenseq; x++){
			s1 = seqnum[x + se1];
			s2 = seqnum[x + se2];
			s3 = seqnum[x + se3];
			xposdiff[x] = y;
		
			if (s1 != s2 || s1 != s3) {
				
				if (s1 != s2 && s1 != s3 && s2 != s3 )
					g++;    
			
				else {
					if (s1 != 46) { 
						if (s2 != 46){
							if (s3 != 46){
							
								if (s1  != s2  && s1  != s3) {
										//If seq1 is odd one
									for (z = 1; z <= spacerno; z++){ 
										sz = seqnum [x + spacerseqs[z] * lenseq];
										if (sz == s1){
												//If difference is legitimate
											if (seq1 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}

													
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}	
									}
								}
							
								else if (s2  != s1  && s2  != s3) {
										//If seq2 is odd one
									for (z = 1; z <= spacerno; z++){
										sz = seqnum [x + spacerseqs[z] * lenseq];
												
										if (s2 == sz){
										//If difference is legitimate
                                        
													
												
											if (seq2 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}
									}
								}
								else if (s3 != s1  && s3  != s2) {
										//If seq3 is odd one
									for (z = 1; z <= spacerno; z++){ 
										sz = seqnum [x + spacerseqs[z] * lenseq];
												
										if (s3 == sz){
                                   
										//If difference is legitimate

											if (seq3 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}

											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}
									}
								}								
							}
						}
								
					}    
				}
			}
		}
		
	}
	
		wmx = y-xow;
		wpx = y+xow;
		for (b = 1; b <= xow;b++){
			wmx ++;
			wpx ++;
			xoverseqnumw[b] = xoverseqnumw [wmx+xoverwindow];
			xoverseqnumw[b + lenseq + xoverwindow2] = xoverseqnumw [wmx + os1];//XOverSeqNum(LenXOverSeq - XOverWindow + X, 1)
			xoverseqnumw[b + lenseq2 + xoverwindow4] = xoverseqnumw [wmx + os2];//XOverSeqNum(LenXOverSeq - XOverWindow + X, 2)
                                        
			xoverseqnumw [wpx]  = xoverseqnumw [b+xoverwindow];//XOverSeqNum(X, 0)
			xoverseqnumw [wpx  + lenseq + xoverwindow2] = xoverseqnumw [b + os1];
			xoverseqnumw [wpx  + lenseq2 + xoverwindow4] = xoverseqnumw [b + os2];
		}
	//for (b = y+1; b < y + xoverwindow; b++)
	//	*(xdiffpos + b) = 0;

	
	//for (b = lenseq+1; b < lenseq + xoverwindow; b++)
	//	*(xposdiff + b) = 0;
	
	ah[0]=ah0;
	ah[1]=ah1;
	ah[2]=ah2;

	if (hoc < oc)
		hoc = oc;

	if (hoc < xoverwindow * 2)
		return (-y);
	else
		return(y);
}


int FAR pascal MakeBinArray(int Seq1, int LSeq, int Nextno, short int *Maskseq, short int *SeqNum, unsigned char *BinArray){
	int Seq2,X, os, se1, se2, target, S1, S2;
	os = LSeq+1;
	se1 = os*Seq1;
	target = LSeq+Nextno*os;
	for (Seq2 = 0; Seq2 <= target; Seq2++)
		BinArray[Seq2] = 0;
           
	for (Seq2 = Seq1 + 1; Seq2 <= Nextno; Seq2++){
        if (Maskseq[Seq2] == 0){
			se2 = os*Seq2;
            for (X = 1; X <= LSeq; X++){
				S1 = SeqNum[X + se1];
				S2 = SeqNum[X + se2];
                if (S1 != S2){

					if (S1 != 46){
						if (S2 != 46)
							BinArray[X + se2] = 1;

					}
				}
            }
        }
    }
	return(1);
}

int FAR pascal MakeBinArray2(int Seq1, int LSeq, int Nextno, short int *Maskseq, short int *SeqNum, unsigned char *BinArray,int *slookupnum, int *slookup, unsigned char *isin, int *tracesub, int *actualsize, int MinSeqSize){
	int Seq2,X, os, se1, se2, target, S1, S2,g;
	os = LSeq+1;
	se1 = os*Seq1;
	target = LSeq+Nextno*os;
	for (Seq2 = 0; Seq2 <= target; Seq2++)
		BinArray[Seq2] = 0;
    
	for (g = 1; g <= slookupnum[0];g++){
	//for (Seq2 = Seq1 + 1; Seq2 <= Nextno; Seq2++){
		Seq2 = slookup[g*2];
		if (actualsize[Seq2] > MinSeqSize){
			if (isin[Seq2] == 0){
				if (tracesub[Seq1] != tracesub[Seq2]){
        //if (Maskseq[Seq2] == 0){
					se2 = os*Seq2;
					for (X = 1; X <= LSeq; X++){
						S1 = SeqNum[X + se1];
						S2 = SeqNum[X + se2];
						if (S1 != S2){

							if (S1 != 46){
								if (S2 != 46)
									BinArray[X + se2] = 1;

							}
						}
					}
				}
			}
        }
    }
	return(1);
}


int FAR pascal FindSubSeqIV(int *ah, short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, int nextno,int seq1,int seq2,int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,char *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff, short int *validspacer, unsigned char *binarray)

//int FAR pascal FindSubSeq(short int lenseq,short int seq1,short int seq2,short int seq3, short int *seqnum, short int *xoverseqnum)

{ 
	
	int hoc, oc, b,x,z, lenseq2,xoverwindow2,xoverwindow4,xow, wmx,wpx;
	int s1,s2,s3,sz,os1,os2, se1,se2,se3, ah0, ah1,ah2;//,so1,so2,so3;
	int holder = 0;
	int y = 0;
	int g=0;

	se1 = seq1*lenseq;
	se2 = seq2*lenseq;
	se3 = seq3*lenseq;
	oc = 0;
	hoc=0;
	xow = xoverwindow;
	lenseq2=lenseq*2;
	xoverwindow2=xoverwindow*2;
    xoverwindow4=xoverwindow*4;
	os1 = xoverwindow + lenseq + xoverwindow2;
	os2 = xoverwindow + lenseq2 + xoverwindow4;
	ah0=0;
	ah1=0;
	ah2=0;
	
	if (spacerflag==0){
		//so1 = seq1*lenseq;
		//so2 = seq2*lenseq;
		//so3 = seq3*lenseq;
		hoc = xoverwindow*10;
		//for (x = 1; x < lenseq*3; x++){
		//	xoverseqnumw[x]=0;
		for (x = 1; x < lenseq; x++){
			if (binarray[x+se2]){//seq1 and seq2 are different
				if (binarray[x+se3]){//if seq1 is also different to seq3{
					//are seq2 and seq3 the same
					if (seqnum[x + se2] == seqnum[x + se3]){ 
						y++;
						xoverseqnumw[y + xoverwindow] = 0;
						xoverseqnumw[y + os1] = 0;
						xoverseqnumw[y + os2] = 1;
						ah2++;    
						xdiffpos[y] = x;
						//xposdiff[x] = y;
					}
				}

				else{//seq1 and seq3 are the same
					y++;
					xoverseqnumw[y + xoverwindow] = 0;
					xoverseqnumw[y + os1] = 1;
					xoverseqnumw[y + os2] = 0;
					ah1++;    
					xdiffpos[y] = x;
				}


				
						//}
					//}
				//}

			}
			else if (binarray[x+se3]){//seq1 and seq3 are different but seq1=seq2
			
					y++;
					xoverseqnumw[y + xoverwindow] = 1;
					xoverseqnumw[y + os1] = 0;
					xoverseqnumw[y + os2] = 0;
                    ah0++;    
					xdiffpos[y] = x;
					//xposdiff[x] = y;
			

			}
			xposdiff[x] = y;
			
		}
	//return(ah1);	
	}
	
	else if (spacerflag==1){
		for (x = 1; x < lenseq; x++){
			
				*(xposdiff + x) = y;
				s1 = *(seqnum + x + se1);
				s2 = *(seqnum + x + se2);
				s3 = *(seqnum + x + se3);
				
				if (s1 != s2 || s1 != s3) {
					
					if (s1 == s2 || s1 == s3 || s2 == s3){
					 
						if (s1 != 46  ){
							if (s2 != 46){
								if (s3 != 46){
									if (s1  !=  s2 && s1 != s3) {
									//If seq1 is odd one
										
										
										if (outlyer == seq1){
											if (oc > 0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											
										}
										else {
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
												if (sz == s1) {
												//If difference is legitimate
													if( *(xdiffpos + y) != x){
														oc += 2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
														
													}
															
												}
												
											}
													
										}
									}
									else if (s2  != s1  && s2  != s3) {
										//If seq2 is odd one
										
										if (outlyer == seq2){
											if (oc >0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
													
										}
										else{
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
												if (s2 == sz){
												//If difference is legitimate
                                        
													if( *(xdiffpos + y) != x){
														oc+=2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
															
													}
												}
											}
										}
									}
									else if (s3  != s1  && s3  != s2) {
									//If seq3 is odd one
										if (outlyer == seq3){
											if (oc >0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											
																			
										}
										else{
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
												if (s3 == sz){
															
												//If difference is legitimate
													if( *(xdiffpos + y) != x){
														oc+=2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
													}
												}
											}
										}
								
									}
								}
							}
						}    
					}
				}
			
		}
		
	}
	else if (spacerflag>1){

	
		for (x = 1; x < lenseq; x++){
			s1 = seqnum[x + se1];
			s2 = seqnum[x + se2];
			s3 = seqnum[x + se3];
			xposdiff[x] = y;
		
			if (s1 != s2 || s1 != s3) {
				
				if (s1 != s2 && s1 != s3 && s2 != s3 )
					g++;    
			
				else {
					if (s1 != 46) { 
						if (s2 != 46){
							if (s3 != 46){
							
								if (s1  != s2  && s1  != s3) {
										//If seq1 is odd one
									for (z = 1; z <= spacerno; z++){ 
										sz = seqnum [x + spacerseqs[z] * lenseq];
										if (sz == s1){
												//If difference is legitimate
											if (seq1 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}

													
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}	
									}
								}
							
								else if (s2  != s1  && s2  != s3) {
										//If seq2 is odd one
									for (z = 1; z <= spacerno; z++){
										sz = seqnum [x + spacerseqs[z] * lenseq];
												
										if (s2 == sz){
										//If difference is legitimate
                                        
													
												
											if (seq2 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}
									}
								}
								else if (s3 != s1  && s3  != s2) {
										//If seq3 is odd one
									for (z = 1; z <= spacerno; z++){ 
										sz = seqnum [x + spacerseqs[z] * lenseq];
												
										if (s3 == sz){
                                   
										//If difference is legitimate

											if (seq3 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}

											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}
									}
								}								
							}
						}
								
					}    
				}
			}
		}
		
	}
	
		wmx = y-xow;
		wpx = y+xow;
		for (b = 1; b <= xow;b++){
			wmx ++;
			wpx ++;
			xoverseqnumw[b] = xoverseqnumw [wmx+xoverwindow];
			xoverseqnumw[b + lenseq + xoverwindow2] = xoverseqnumw [wmx + os1];//XOverSeqNum(LenXOverSeq - XOverWindow + X, 1)
			xoverseqnumw[b + lenseq2 + xoverwindow4] = xoverseqnumw [wmx + os2];//XOverSeqNum(LenXOverSeq - XOverWindow + X, 2)
                                        
			xoverseqnumw [wpx]  = xoverseqnumw [b+xoverwindow];//XOverSeqNum(X, 0)
			xoverseqnumw [wpx  + lenseq + xoverwindow2] = xoverseqnumw [b + os1];
			xoverseqnumw [wpx  + lenseq2 + xoverwindow4] = xoverseqnumw [b + os2];
		}
	//for (b = y+1; b < y + xoverwindow; b++)
	//	*(xdiffpos + b) = 0;

	
	//for (b = lenseq+1; b < lenseq + xoverwindow; b++)
	//	*(xposdiff + b) = 0;
	
	ah[0]=ah0;
	ah[1]=ah1;
	ah[2]=ah2;

	if (hoc < oc)
		hoc = oc;

	if (hoc < xoverwindow * 2)
		return (-y);
	else
		return(y);
}

int FAR pascal FindSubSeqFaster(int UBIS4,int *ah, short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, int nextno,int seq1,int seq2,int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,char *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff, short int *validspacer, short int *ISEQ4)

//int FAR pascal FindSubSeq( short int lenseq,short int seq1,short int seq2,short int seq3, short int *seqnum, short int *xoverseqnum)

{ 
	
	int hoc, oc, b,x,z, lenseq2,xoverwindow2,xoverwindow4,xow, wmx,wpx;
	int s1,s2,s3,sz,os1,os2, se1,se2,se3, ah0, ah1,ah2;//,so1,so2,so3;
	int a,holder = 0;
	int y = 0;
	int g=0, os=UBIS4+1;

	se1 = seq1*lenseq;
	se2 = seq2*lenseq;
	se3 = seq3*lenseq;
	oc = 0;
	hoc=0;
	xow = xoverwindow;
	lenseq2=lenseq*2;
	xoverwindow2=xoverwindow*2;
    xoverwindow4=xoverwindow*4;
	os1 = xoverwindow + lenseq + xoverwindow2;
	os2 = xoverwindow + lenseq2 + xoverwindow4;
	ah0=0;
	ah1=0;
	ah2=0;
	
	if (spacerflag==0){
		//so1 = seq1*lenseq;
		//so2 = seq2*lenseq;
		//so3 = seq3*lenseq;
		hoc = xoverwindow*10;
		for (a = 1; a <= UBIS4; a++){
			if (ISEQ4[a+seq1*os] != ISEQ4[a+seq2*os] || ISEQ4[a+seq1*os] != ISEQ4[a+seq3*os]){
				for (x = (a-1)*4+1; x < (a-1)*4+6; x++){
					

					xposdiff[x] = y;
					s1 = seqnum[x + se1];
					
					if (s1 != 46){
						s2 = seqnum[x + se2];
						if (s2 != 46){  
							s3 = seqnum[x + se3];
							if (s3 != 46){
								if (s1 != s2) {
								//if (s1 == s2 || s1 == s3 || s2 == s3){
							
											
										if (s1 == s3){ 
											y++;
											xoverseqnumw[y + xoverwindow] = 0;
											xoverseqnumw[y + os1] = 1;
											xoverseqnumw[y + os2] = 0;
											ah1++;    
											xdiffpos[y] = x;
											xposdiff[x] = y;
										}
										else if (s2 == s3){ 
											y++;
											xoverseqnumw[y + xoverwindow] = 0;
											xoverseqnumw[y + os1] = 0;
											xoverseqnumw[y + os2] = 1;
											ah2++;    
											xdiffpos[y] = x;
											xposdiff[x] = y;
										}
										
									//}
								}
								else if (s1 != s3) {
								//if (s1 == s2 || s1 == s3 || s2 == s3){
							
											
										if (s1 == s2){   
											y++;
											xoverseqnumw[y + xoverwindow] = 1;
											xoverseqnumw[y + os1] = 0;
											xoverseqnumw[y + os2] = 0;
											ah0++;    
											xdiffpos[y] = x;
											xposdiff[x] = y;
										}
										else if (s2 == s3){ 
											y++;
											xoverseqnumw[y + xoverwindow] = 0;
											xoverseqnumw[y + os1] = 0;
											xoverseqnumw[y + os2] = 1;
											ah2++;    
											xdiffpos[y] = x;
											xposdiff[x] = y;
										}
										
									//}
								}
							}    
						}
					}
				}
				
			}
		}
	//return(ah1);	
	}
	
	else if (spacerflag==1){
		for (x = 1; x < lenseq; x++){
			
				*(xposdiff + x) = y;
				s1 = *(seqnum + x + se1);
				s2 = *(seqnum + x + se2);
				s3 = *(seqnum + x + se3);
				
				if (s1 != s2 || s1 != s3) {
					
					if (s1 == s2 || s1 == s3 || s2 == s3){
					 
						if (s1 != 46  ){
							if (s2 != 46){
								if (s3 != 46){
									if (s1  !=  s2 && s1 != s3) {
									//If seq1 is odd one
										
										
										if (outlyer == seq1){
											if (oc > 0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											
										}
										else {
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
												if (sz == s1) {
												//If difference is legitimate
													if( *(xdiffpos + y) != x){
														oc += 2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
														
													}
															
												}
												
											}
													
										}
									}
									else if (s2  != s1  && s2  != s3) {
										//If seq2 is odd one
										
										if (outlyer == seq2){
											if (oc >0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
													
										}
										else{
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
												if (s2 == sz){
												//If difference is legitimate
                                        
													if( *(xdiffpos + y) != x){
														oc+=2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
															
													}
												}
											}
										}
									}
									else if (s3  != s1  && s3  != s2) {
									//If seq3 is odd one
										if (outlyer == seq3){
											if (oc >0){
												if (oc > hoc)
													hoc = oc;
												oc--;
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											
																			
										}
										else{
											for (z = 1; z <= spacerno; z++){ 
												sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
												if (s3 == sz){
															
												//If difference is legitimate
													if( *(xdiffpos + y) != x){
														oc+=2;
														if (s1 == s2){   
															y++;
															xoverseqnumw[y + xoverwindow] = 1;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 0;
															ah0++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s1 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 1;
															xoverseqnumw[y + os2] = 0;
															ah1++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														else if (s2 == s3){ 
															y++;
															xoverseqnumw[y + xoverwindow] = 0;
															xoverseqnumw[y + os1] = 0;
															xoverseqnumw[y + os2] = 1;
															ah2++;
															xdiffpos[y] = x;
															xposdiff[x] = y;
														}
														z = spacerno;
													}
												}
											}
										}
								
									}
								}
							}
						}    
					}
				}
			
		}
		
	}
	else if (spacerflag>1){

	
		for (x = 1; x < lenseq; x++){
			s1 = seqnum[x + se1];
			s2 = seqnum[x + se2];
			s3 = seqnum[x + se3];
			xposdiff[x] = y;
		
			if (s1 != s2 || s1 != s3) {
				
				if (s1 != s2 && s1 != s3 && s2 != s3 )
					g++;    
			
				else {
					if (s1 != 46) { 
						if (s2 != 46){
							if (s3 != 46){
							
								if (s1  != s2  && s1  != s3) {
										//If seq1 is odd one
									for (z = 1; z <= spacerno; z++){ 
										sz = seqnum [x + spacerseqs[z] * lenseq];
										if (sz == s1){
												//If difference is legitimate
											if (seq1 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}

													
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}	
									}
								}
							
								else if (s2  != s1  && s2  != s3) {
										//If seq2 is odd one
									for (z = 1; z <= spacerno; z++){
										sz = seqnum [x + spacerseqs[z] * lenseq];
												
										if (s2 == sz){
										//If difference is legitimate
                                        
													
												
											if (seq2 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}
											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}
									}
								}
								else if (s3 != s1  && s3  != s2) {
										//If seq3 is odd one
									for (z = 1; z <= spacerno; z++){ 
										sz = seqnum [x + spacerseqs[z] * lenseq];
												
										if (s3 == sz){
                                   
										//If difference is legitimate

											if (seq3 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}

											if (s1 == s2){   
												y++;
												xoverseqnumw[y + xoverwindow] = 1;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 0;
												ah0++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s1 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 1;
												xoverseqnumw[y + os2] = 0;
												ah1++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											else if (s2 == s3){ 
												y++;
												xoverseqnumw[y + xoverwindow] = 0;
												xoverseqnumw[y + os1] = 0;
												xoverseqnumw[y + os2] = 1;
												ah2++;
												xdiffpos[y] = x;
												xposdiff[x] = y;
											}
											break;
										}
									}
								}								
							}
						}
								
					}    
				}
			}
		}
		
	}
	
		wmx = y-xow;
		wpx = y+xow;
		for (b = 1; b <= xow;b++){
			wmx ++;
			wpx ++;
			xoverseqnumw[b] = xoverseqnumw [wmx+xoverwindow];
			xoverseqnumw[b + lenseq + xoverwindow2] = xoverseqnumw [wmx + os1];//XOverSeqNum(LenXOverSeq - XOverWindow + X, 1)
			xoverseqnumw[b + lenseq2 + xoverwindow4] = xoverseqnumw [wmx + os2];//XOverSeqNum(LenXOverSeq - XOverWindow + X, 2)
                                        
			xoverseqnumw [wpx]  = xoverseqnumw [b+xoverwindow];//XOverSeqNum(X, 0)
			xoverseqnumw [wpx  + lenseq + xoverwindow2] = xoverseqnumw [b + os1];
			xoverseqnumw [wpx  + lenseq2 + xoverwindow4] = xoverseqnumw [b + os2];
		}
	//for (b = y+1; b < y + xoverwindow; b++)
	//	*(xdiffpos + b) = 0;

	
	//for (b = lenseq+1; b < lenseq + xoverwindow; b++)
	//	*(xposdiff + b) = 0;
	
	ah[0]=ah0;
	ah[1]=ah1;
	ah[2]=ah2;

	if (hoc < oc)
		hoc = oc;

	if (hoc < xoverwindow * 2)
		return (-y);
	else
		return(y);
}


int FAR pascal FindActualEvents(int LS, int WinPP, int NextNo, int UB, int *RSize, char *Don, int *BPMatch, float *BMatch,double *OKSeq, int *FoundOne, int *SP, int *EP, float *RCorr, int *OLSeq, int *OLSeqB, int *OLSeqE, int *CSeq, int *RNum, int *RList, char *InvS, int *TrS, double *TMatch, XOVERDEFINE *PXOList, short int *PCurrentXOver, int *SQ, char *tDon, int *ISeqs, char *TList, int *CompMat){
	//tlist - 2,nextno
	//compmat - 2,1
	//don - 2,nextno
	//invs - 2,nextno
	//rcorr - 2,2,nextno
	//bmatch 2,nextno
	//bpmatch 2,1,nextno
	//OKSeq - 2,17,nextno
	int Z,A,X,Y, OldY, zzx,ZZZX, GoOn, os1, OLSize, os2, BPos2, EPos2;
	zzx=0;
	double dOLSize, dR0, dR1, otMatch;
	for (X = 0; X <= NextNo; X++){
		if (TList[WinPP + 3*X] == 1 || ISeqs[CompMat[WinPP]] == X || ISeqs[CompMat[WinPP + 3]] == X){
			OldY = -1;
			for (Y = 1; Y <= PCurrentXOver[X]; Y++){
				
				if (OldY != Y){
					tDon[0] = 0;
					tDon[1] = 0;
					tDon[2] = 0;
					tDon[3] = 0;
					tDon[4] = 0;
					tDon[5] = 0;
                    OldY = Y;
                    zzx = 0;
				}
				else{
					zzx++;
                    if (zzx > 6){
						tDon[0] = 0;
						tDon[1] = 0;
						tDon[2] = 0;
						tDon[3] = 0;
						tDon[4] = 0;
						tDon[5] = 0;
                        OldY = Y;
                        Y++;
                        zzx = 0;
                        if (Y > PCurrentXOver[X])
							break;
					}
					if (Y == OldY){
						ZZZX = 0;
						for (A = 0; A < 6; A++)
							ZZZX = ZZZX + tDon[A];
                                
						if (ZZZX == 6) {
							Y++;
							tDon[0] = 0;
							tDon[1] = 0;
							tDon[2] = 0;
							tDon[3] = 0;
							tDon[4] = 0;
							tDon[5] = 0;
							OldY = Y;
							zzx = 0;
							ZZZX = 0;
							if (Y > PCurrentXOver[X])
								break;
						}
                                
					}
				}
				os1 = X + Y*(UB+1);
                SQ[1] = PXOList[os1].MajorP;
				if (TList[WinPP + 3*SQ[1]] == 1 || ISeqs[CompMat[WinPP]] == SQ[1] || ISeqs[CompMat[WinPP + 3]] == SQ[1]){
					GoOn = 0;
                    SQ[2] = PXOList[os1].MinorP;
                    if (TList[WinPP + 3*SQ[2]] == 1 || ISeqs[CompMat[WinPP]] == SQ[2] || ISeqs[CompMat[WinPP + 3]] == SQ[2]){
						SQ[0] = X;
                        TMatch[0] = 0;
                        if (tDon[0] == 0 && ((WinPP == 0 && Don[SQ[0]*3] == 0) || (WinPP == 1 && Don[1 + SQ[1]*3] == 0) || (WinPP == 2 && Don[2 + SQ[2]*3] == 0)) && TList[SQ[0]*3] == 1 && TList[1 + SQ[1]*3] == 1 && TList[2 + SQ[2]*3] == 1){
							tDon[0] = 1;
							TrS[0] = SQ[0];
							TrS[1] = SQ[1];
							TrS[2] = SQ[2];
							TMatch[0] = 3.0;
						}

						else if (tDon[1] == 0 && ((WinPP == 0 && Don[SQ[0]*3] == 0) || (WinPP == 1 && Don[1 + SQ[2]*3] == 0) || (WinPP == 2 && Don[2 + SQ[1]*3] == 0)) && TList[0 + SQ[0]*3] == 1 && TList[1 + SQ[2]*3] == 1 && TList[2 + SQ[1]*3] == 1){
                            tDon[1] = 1;
							TrS[0] = SQ[0];
							TrS[1] = SQ[2];
							TrS[2] = SQ[1];
							TMatch[0] = 3.0;
						}
						else if (tDon[2] == 0 && ((WinPP == 0 && Don[SQ[1]*3] == 0) || (WinPP == 1 && Don[1 + SQ[2]*3] == 0) || (WinPP == 2 && Don[2 + SQ[0]*3] == 0)) && TList[SQ[1]*3] == 1 && TList[1 + SQ[2]*3] == 1 && TList[2 + SQ[0]*3] == 1){
                            tDon[2] = 1;
							TrS[0] = SQ[1];
							TrS[1] = SQ[2];
							TrS[2] = SQ[0]; 
							TMatch[0] = 3.0;
						}
						else if (tDon[3] == 0 && ((WinPP == 0 && Don[SQ[1]*3] == 0) || (WinPP == 1 && Don[1 + SQ[0]*3] == 0) || (WinPP == 2 && Don[2 + SQ[2]*3] == 0)) && TList[SQ[1]*3] == 1 && TList[1 + SQ[0]*3] == 1 && TList[2 + SQ[2]*3] == 1){
							tDon[3] = 1;
							TrS[0] = SQ[1];
							TrS[1] = SQ[0];
							TrS[2] = SQ[2];
							TMatch[0] = 3.0;
						}
						else if (tDon[4] == 0 && ((WinPP == 0 && Don[SQ[2]*3] == 0) || (WinPP == 1 && Don[1 + SQ[1]*3] == 0) || (WinPP == 2 && Don[2 + SQ[0]*3] == 0)) && TList[0 + SQ[2]*3] == 1 && TList[1 + SQ[1]*3] == 1 && TList[2 + SQ[0]*3] == 1){
							tDon[4] = 1;
							TrS[0] = SQ[2];
							TrS[1] = SQ[1];
							TrS[2] = SQ[0];
							TMatch[0] = 3.0;
						}
						else if (tDon[5] == 0 && ((WinPP == 0 && Don[SQ[2]*3] == 0) || (WinPP == 1 && Don[1 + SQ[0]*3] == 0) || (WinPP == 2 && Don[2 + SQ[1]*3] == 0)) && TList[SQ[2]*3] == 1 && TList[1 + SQ[0]*3] == 1 && TList[2 + SQ[1]*3] == 1){
							tDon[5] = 1;
							TrS[0] = SQ[2];
							TrS[1] = SQ[0];
							TrS[2] = SQ[1];
							TMatch[0] = 3.0;
						}
                                
						
						
						
						if (TMatch[0] == 3){
                                
							for (A = 0; A < 3; A++){
								if (TrS[WinPP] == SQ[A]) 
									break;
                                        
							}
							if (InvS[CompMat[WinPP] + TrS[CompMat[WinPP]]*3] == 0 && InvS[CompMat[WinPP + 3] + TrS[CompMat[WinPP+3]]*3] == 0){
								for (A = 0; A<= RNum[WinPP]; A++){
									if (RList[WinPP + A*3] == TrS[WinPP])
										break;
								}
                                if (A > RNum[WinPP])
									TMatch[0] = 0;
								else{
									CSeq[1] = A;
                                    GoOn = 1;
                                            
								}
							}
							else
								TMatch[0] = 0;
                                    
						        
                           //ie an event involving a potentially recombinant sequence is found.
							if (TMatch[0] == 3 && GoOn == 1){
                                        //check for region overlap
                                        
								BPos2 = PXOList[os1].Beginning;
                                EPos2 = PXOList[os1].Ending;

                                //OLSize = FindOverlap(LS, BPos2, EPos2, *RSize, OLSeq(0));
								OLSize = 0;
								if (BPos2 < EPos2) {
									RSize[1] = EPos2 - BPos2 + 1;
									for (Z = BPos2; Z<= EPos2; Z++)
										OLSize = OLSize + OLSeq[Z];
                                  
								}
								else{
									RSize[1] = EPos2 + LS - BPos2 + 1;
									for (Z = 1; Z <= EPos2; Z++)
										OLSize = OLSize + OLSeq[Z];
                                  
									for (Z = BPos2; Z <= LS; Z++)
										OLSize = OLSize + OLSeq[Z];
								
								}
								
								
								if (OLSize > 0){
									dOLSize = (double)(OLSize);
									dR0 = (double)(RSize[0]);
									dR1 = (double)(RSize[1]);
									TMatch[1] = (dOLSize * 2.0) / (dR0+dR1);
								}
                                else
                                    TMatch[1] = 0;
                                        
                                otMatch = TMatch[1];
                                if (TMatch[0] * TMatch[1] > 1){
                                           
									//its in the right region but is it the same event?
									if (RCorr[WinPP + 6 + RList[WinPP + CSeq[1]*3]*9] > 0.83 && TMatch[1] > 0.6)
										TMatch[0] = 1;
                                                
                                                
									if (RCorr[WinPP + 6 + 9*RList[WinPP + CSeq[1]*3]] > 0.83 || RCorr[WinPP + RList[WinPP + CSeq[1]]*9] > 0.83){
									 	//OLSize = FindOverlap(Len(StrainSeq(0)), SP(0), EP(1), RSize(2), OLSeqB(0))
									 	OLSize = 0;
										if (SP[0] < EP[1]) {
											RSize[3] = EP[1] - SP[0] + 1;
											for (Z = SP[0]; Z<= EP[1]; Z++)
												OLSize = OLSize + OLSeqB[Z];
                                  
										}
										else{
											RSize[3] = EP[1] + LS - SP[0] + 1;
											for (Z = 1; Z <= EP[1]; Z++)
												OLSize = OLSize + OLSeqB[Z];
                                  
											for (Z = SP[0]; Z <= LS; Z++)
												OLSize = OLSize + OLSeqB[Z];
											
										}           
										if (OLSize > 0){
											dOLSize = (double)(OLSize);
											dR0 = (double)(RSize[2]);
											dR1 = (double)(RSize[3]);
											TMatch[1] = (dOLSize * 2.0) / (dR0+dR1);
											//TMatch[1] = (OLSize * 2) / (RSize(2) + RSize(3))
										}
                                        else
                                            TMatch[1] = 0;
                                                    
                                        if (TMatch[1] > 0.2)
											TMatch[0] = TMatch[0] + 1;

										else if (RCorr[WinPP + RList[WinPP + CSeq[1]*3]*9] > 0.83 ){
											if (TMatch[1] == 0 || OLSize == RSize[2])
												TMatch[0] = TMatch[0] - 0.5;
                                                       
										}
                                                    
									}
                                                
									if (RCorr[WinPP + 6 + RList[WinPP + CSeq[1]*3]*9] > 0.83 || RCorr[WinPP + 3 + RList[WinPP + CSeq[1]*3]*9] > 0.83){
										//OLSize = FindOverlap(Len(StrainSeq(0)), SP(2), EP(3), RSize(4), OLSeqE(0))
                                        OLSize = 0;
										if (SP[2] < EP[3]) {
											RSize[5] = EP[3] - SP[2] + 1;
											for (Z = SP[2]; Z<= EP[3]; Z++)
												OLSize = OLSize + OLSeqE[Z];
                                  
										}
										else{
											RSize[5] = EP[3] + LS - SP[2] + 1;
											for (Z = 1; Z <= EP[3]; Z++)
												OLSize = OLSize + OLSeqE[Z];
                                  
											for (Z = SP[2]; Z <= LS; Z++)
												OLSize = OLSize + OLSeqE[Z];
											
										}                
										if (OLSize > 0){
											dOLSize = (double)(OLSize);
											dR0 = (double)(RSize[4]);
											dR1 = (double)(RSize[5]);
											TMatch[1] = (dOLSize * 2.0) / (dR0+dR1);
											//TMatch[1] = (OLSize * 2) / (RSize(2) + RSize(3))
										}
                                        else
                                            TMatch[1] = 0;
                                
                                                    
                                        if (TMatch[1] > 0.2)
											TMatch[0] = TMatch[0] + 1;
										else if (RCorr[WinPP + RList[WinPP + CSeq[1]*3]*9] > 0.83){
											if (TMatch[1] == 0 || OLSize == RSize[4])
												TMatch[0] = TMatch[0] - 0.5;
                                                        
										}
                                                    
									}
                                     //swap around parents and recombinants later (after the next detection step)
									if (TMatch[0] >= 1){
										FoundOne[CSeq[1]] = 1;
                                        os2 =  RList[WinPP + CSeq[1]*3]*3;           
										if (BMatch[WinPP + os2] < otMatch){
											OKSeq[WinPP + 3 + os2*18] = otMatch;
                                            BMatch[WinPP + os2] = (float)(otMatch);
                                            BPMatch[WinPP + os2*2] = BPos2;
                                            BPMatch[WinPP + 3 + os2*2] = EPos2;
										}
										Y--;
									}
                                            
                                            
                                           
								}
								else
									Y--;
								 
							}		
						}
					}
				}
			}//Next Y
		}
    }//Next X
	return(0);
}


int FAR pascal MakePValMap(int DN, int LS, int PermNum, short int *Map, float *PValMap){
	int Y, X, Z, TopS, BottomS, DoneNum, LastX, os1, mpos, os3; 
	LastX=0;
	os1= (LS+1);
	//pvalmap ls,permnum
	//map ls,permnum
	for (Y = DN; Y <= (LS - DN + 1); Y++){
        TopS = 1000000; 
		BottomS = 0;
        DoneNum = 0;
		os3 = Y;
        for (X = 0; X <= PermNum; X++){
            DoneNum = 0;
            BottomS = 0;
			
            for (Z = 0; Z <= PermNum; Z++){
                mpos = Map[os3 + Z*os1];
                if (mpos > BottomS){ 
					if (mpos < TopS){
						BottomS = mpos;
						DoneNum = 1;
					}
				}

                
            }
            if (DoneNum == 1){
                DoneNum = 0;
                for (Z = 0; Z <= PermNum; Z++){
					mpos = Map[os3 + Z*os1];
                    if (mpos == BottomS){
                        PValMap[Y + (X + DoneNum)*os1] = (float)(mpos);
                        DoneNum++;
                    }
                }
                
                TopS = BottomS;
                
                if (DoneNum > 1)
					X = X + DoneNum - 1;
                
				LastX = X + 1;
			}
            else{
                for (Z = LastX; Z <= PermNum; Z++)
                    Map[os3 + Z*os1] = 0;
                
                break;
            }
        }
    }
	return(1);
}



int FAR pascal AddToMap(int A,int S, double Win, int LS,int *APos, short int *Map){
int B,C,os3, SX, EX;
os3 = (LS+1);
SX = (S - (int)((Win) / 2));
            EX = (S + (int)((Win) / 2));
            //return (EX);                            
			for (B = SX; B <= EX; B++){
					if (B < 1)
						C = APos[LS] + B;
                    else if (B > APos[LS])
						C = B - APos[LS];
					else
						C = B;
                                     
                                            
                    Map[C + A*os3] = Map[C + A*os3] + 1;
                                                
			}
			return(1);
}

int FAR pascal CheckBPOL(int LS, int d, int LSSeq, int NewStart, int RecSize,short int *tSeqNum, int *ns, int *ne, int *XDiffPos){

	int Z, NS, NE, GoOn, os1;
	NS = XDiffPos[NewStart];
    if (NewStart + RecSize <= LSSeq) 
		NE = XDiffPos[NewStart + RecSize];
    else
		NE = XDiffPos[(NewStart + RecSize) - LSSeq];
                                
    //does this event cross any previous breakpoints?
    *ns = NS;
	*ne = NE;
	os1 = d*(LS+1);
    GoOn = 1;
	if (NS < NE){
		for (Z = NS; Z<= NE; Z=Z+5){
			if (tSeqNum[Z + os1] )
               return(0);
		}
	}
    else{
		for (Z = NS; Z<= LS; Z=Z+3){
			if (tSeqNum[Z+ os1] )
               return(0);
		}
		for (Z = 1; Z<= NE; Z=Z+3){
			if (tSeqNum[Z + os1])
               return(0);
		}
	}
                               
	return (GoOn);
}


int FAR pascal MakeTreeMatrix(int Nextno, int UBFM, int UBD, int UBTM, float *FMat, float *TreeMatrix, float *Distance){
	int X,Y,A,B, off1, off2, off3, off4, off5, off6;
	off1=UBFM+1;
	off3 = UBD+1;
	off5 = UBTM+1;
	A = 0;
	B = 0;
	for (X = 0; X <= Nextno; X++){
		off2 = off1*X;
		off4 = off3*X;
		if (FMat[X + off2] != 3){
            B = A + 1;
			off6 = off5*A;
            for (Y = X + 1; Y <= Nextno; Y++){
                if(FMat[Y + Y*off1] != 3){
                    TreeMatrix[B + off6] = 1 - Distance[Y + off4];
                    TreeMatrix[A + B*off5] = TreeMatrix[B + off6];
                    B = B + 1;
                }
            }
            A = A + 1;
		}
	}
	return(1);
}

int FAR pascal MakeTreeFMat(int Nextno, int UBFM,  int UBTF, float *FMat, float *TreeFMat){
	int X,Y,A,B, off1, off2,  off5, off6;
	off1=UBFM+1;
	off5 = UBTF+1;
	A = 0;
	B = 0;
	for (X = 0; X <= Nextno; X++){
		off2 = off1*X;
		
		if (FMat[X + off2] != 3){
            B = A + 1;
			
			off6 = off5*A;
			TreeFMat[A + off6] = 0;
            for (Y = X + 1; Y <= Nextno; Y++){
                if( FMat[Y + Y*off1] != 3){
                    TreeFMat[B + off6] = FMat[Y + off2];
                    TreeFMat[A + B*off5] = TreeFMat[B + off6];
                    B = B + 1;
                }
            }
            A = A + 1;
		}
	}
	return(1);
}

int FAR pascal MakeTreeSMat(int Nextno, int UB4, int UBFM,  int UBTS, float *FMat, float *TreeSMat, float *SMat){
	int X,Y,A,B, off1, off2, off5, off6;
	off1=UBFM+1;
	off5 = UBTS+1;
	A = 0;
	B = 0;
	for (X = 0; X <= Nextno; X++){
		off2 = off1*X;
		
		if (FMat[X + off2] != 3){
            B = A + 1;
			
			off6 = off5*A;
			TreeSMat[A + off6] = 0;
			if (UB4 > 0){
				for (Y = X + 1; Y <= Nextno; Y++){
					if( FMat[Y + Y*off1] != 3){
						
						TreeSMat[B + off6] = SMat[Y + off2];
						TreeSMat[A + B*off5] = TreeSMat[B + off6];
						
						B = B + 1;
					}
				}
			}
            A = A + 1;
		}
		else{
			
             FMat[X + off2] = 0;
             if (UB4 > 0) 
                 SMat[X + off2] = 0;

		}
	}
	return(1);
}

int FAR pascal EraseEmpties(int Nextno, int UB, int UBFM, int SCO, int *ISeqs, float *FMat, float *FubValid, float *SMat, float *SubValid){
	int X, Y, EraseF, off1, off2;

	off1 = UBFM+1;

	for (X = 0; X <= Nextno; X++){
        off2 = X*off1;
        if (FMat[X + off2] != 3){
        
            EraseF = 0;
            
            for (Y = 0; Y <= 2; Y++){
                if (ISeqs[Y] <= Nextno){
                    if (X != ISeqs[0] && X != ISeqs[1] && X != ISeqs[2]){
                        
                        if (FubValid[ISeqs[Y] + off2] < SCO || SubValid[ISeqs[Y] + off2] < SCO){
                            EraseF = 1;
                            break;
                        }
                    
                    }
                }
            }
            
            if (EraseF == 1){
                
                for (Y = 0; Y <= Nextno ; Y++){
                    FMat[X + Y*off1] = 3.0;
                    FMat[Y + off2] = 3.0;
                    if (UB > 0){
                        SMat[X + Y*off1] = 3.0;
                        SMat[Y + off2] = 3.0;
                    }
                    
                                    
                }
                
            }
            
        }
    }

	return(1);

}


int FAR pascal ClearNodeArrays(int PermNextno,int TType, int UBNF, int UBNMR, int UBNXY1, int UBNXY2, float *NodeMaxRep,  unsigned char *NodeFind, int *NodeXY){
	int X, Y, off1, off2, off3, off4, off5, off6;
	off1 = UBNF+1;
	off3 = UBNMR+1;
	off4 = UBNXY1+1;
	off6 = UBNXY2+1;
	off6 = off6*off4;
	for (X = 0; X <= PermNextno; X++){
		off2 = off1*X;
		off5 = off4*X;
        for (Y = 0; Y <= PermNextno; Y++)
            NodeFind[Y+off2] = 0;
        
        NodeMaxRep[X] = 0;
        NodeMaxRep[X + off3] = 0;
        NodeXY[TType + off5] = -1;
        NodeXY[TType + off5 + off6] = -1;
    }


	return(1);
}


int FAR pascal FillSeqLines(int PermNextno, int NumSeqLines, int Offset1, int Offset2, int Offset4, int RSN1, int Col1, int Col2, int Col3, int Col4, int UBSCR, int UBSL, int UBCD, short int *ColDist, int *SeqLines,unsigned char *SeqColRef){

	int X, off1, NS, off2, off3;
	off1 = UBSCR+1;
	NS = NumSeqLines;
	off2 = UBSL+1;
	off3 = UBCD+1;
	for (X = 0; X<= PermNextno; X++){
        if (SeqColRef[RSN1 + X*off1] > 0){
            SeqLines[NS*off2] = 0; // thing to draw is a rectangle
            SeqLines[2 + NS*off2] = Offset4;// 'X1
            SeqLines[3 + NS*off2] = X * 13;// 'Y1
            SeqLines[4 + NS*off2] = Offset1;// 'X2
            SeqLines[5 + NS*off2] = (X + ColDist[RSN1 + X*off3] - 1) * 13 + Offset2;// 'Y2
            if (SeqColRef[RSN1 + X*off1] == 1)
                SeqLines[1 + NS*off2] = Col1;
            else if (SeqColRef[RSN1 + X*off1] == 2)
                SeqLines[1 + NS*off2] = Col2;
            else if (SeqColRef[RSN1 + X*off1] == 3)
                SeqLines[1 + NS*off2] = Col3; 
            else if (SeqColRef[RSN1 + X*off1] == 4)
                SeqLines[1 + NS*off2] = Col4; 
            
			X =  X + ColDist[RSN1 + X*off3];
            NS = NS + 1;
        }
    }





	return(NS);
}


int FAR pascal FindDupFlash(int A, int B, int UBF, int *FlashntNum, int *Flashnt){
	int C, ActiveNum, os, os2, fn;
	ActiveNum = *FlashntNum;
	os = UBF+1;
	fn = *FlashntNum;
    for (C = 0; C < fn; C++){
        os2 = os*C;
		if (Flashnt[1 + os2] == A ){
            if (Flashnt[os2] == B){
                ActiveNum = C;
                fn=fn-1;
                break;
            }
        }
    }

	*FlashntNum = fn;

	return(ActiveNum);
}

int FAR pascal P4Draw(int Chunk, int LSeq, int SSB, float MinID, int UBID1, int UBID2, float IV,short int HeightOfWindow, float StepSizeC, int *Decompress, float *DisplayID, unsigned char *ImageData){
	int X, Z, Y, StartPos, os, os2, os3, os4, ShortColourR, ShortColourG, ShortColourB;
	float Temp, Interval;
	
	Interval = IV;
	os  = UBID1+1;
	os2 = os*(UBID2+1);
	for (X = 1; X <= LSeq-SSB; X = X + SSB){
        if (Interval > 0)
            Temp = (DisplayID[X] - MinID) / Interval;
        else{
            Temp = 1;
            Interval = 1;
        }
        Temp = (int)(Temp * 765.0);
        ShortColourR = (int)(Temp);

        if (ShortColourR > 255){
            ShortColourR = 255;
            ShortColourG = (int)(Temp - 255);
            
            if (ShortColourG > 255){
                ShortColourB = (int)(Temp - 510);
                ShortColourG = 255;
			}
            else
                ShortColourB = 0;
            
		}

        else{
            ShortColourB = 0;
            ShortColourG = 0;
        }
        
        if (ShortColourR < 0)
			ShortColourR = 0;
		
		
		StartPos = (int)((float)(Decompress[X] / StepSizeC));
        for (Z = StartPos; Z <= StartPos + (Chunk - 1); Z++){
            if (Z <= UBID2){
				os3 = os*Z;
				//sp = (int)((1 - ((DisplayID[X] - MinID) / Interval)) * HeightOfWindow);
				for (Y = 0; Y < HeightOfWindow ; Y++){
					os4 = Y*os2 + os3;
					ImageData[os4] = ShortColourG;
					ImageData[os4+1] = ShortColourB;
					ImageData[os4+2] = ShortColourR;
				}
			}
        }
    }
	return(1);
}

int FAR pascal P11Draw(int Chunk, int LSeq, int SSB, float MinID, int UBID1, int UBID2, float Interval,short int HeightOfWindow, float StepSizeC, int *Decompress, float *DisplayID, unsigned char *ImageData){
	int X, Z, Y, StartPos, os, os2, os3, os4, sp;
	

	os  = UBID1+1;
	os2 = os*(UBID2+1);
	for (X = 1; X < LSeq; X = X + SSB){
		sp = (int)((1 - ((DisplayID[X] - MinID) / Interval)) * HeightOfWindow);
        StartPos = (int)((float)(Decompress[X] / StepSizeC));
        for (Z = StartPos; Z <= StartPos + (Chunk - 1); Z++){
            if (Z <= UBID2){
				os3 = os*Z;
				
				for (Y = sp; Y < HeightOfWindow ; Y++){
					os4 = Y*os2 + os3;
					ImageData[os4] = 0;
					ImageData[os4+1] = 0;
					ImageData[os4+2] = 0;
				}
			}
        }
    }
	return(1);
}


int FAR pascal FillVSiteMatC(int Nextno, int PS1, int PS2, int UBSN, int UBSL, int UBVSM, int *SList, int *PermPlantNum, int *VSitesMat, int *OffsetPerm, int *DiffPos, int LSub, short int *SeqNum, unsigned char *WorthDoing){
	int X, Y, PN, PO, A, B, Z, DPZ, DPY, os1, os2, ps1os, ps2os, os3, os4, os5, os6, os7, os8, os9;
	os1 = UBSN+1;
	os3 = UBSL+1;
	os4 = UBVSM+1;
	os5 = os4*os4;
	os6 = os5*2;
	os7 = os5*3;
	ps1os = PS1*os1;
	ps2os = PS2*os1;
	for (X = 0; X <= Nextno; X++){
		os2= X*os1;
		if (WorthDoing[X] == 1){
			PN = PermPlantNum[X];
			PO = OffsetPerm[PN];
			for (A = 1; A<= LSub; A++){
				Z = A + PO;
				if (Z > LSub)
					Z = Z - LSub;
				
				DPZ = DiffPos[Z];
				if (SeqNum[DPZ + os2] == SeqNum[DPZ + ps1os]){
					SList[A] = SList[A] + 1;
					for (B = A + 1; B <= LSub; B++){
						Y = B + PO;
						if (Y > LSub)
							Y = Y - LSub;
					
						DPY = DiffPos[Y];
						
						if (SeqNum[DPY + os2] == SeqNum[DPY + ps1os]) 
							VSitesMat[A + B*os4] = VSitesMat[A + B*os4] + 1;
						else if (SeqNum[DPY + os2] == SeqNum[DPY + ps2os]) 
							VSitesMat[A + B*os4 + os5] = VSitesMat[A + B*os4 + os5] + 1;
						
						
					}
				}
				else if (SeqNum[DPZ + os2] == SeqNum[DPZ + ps2os]){
					SList[A + os3] = SList[A + os3] + 1;
            
				
					for (B = A + 1; B <= LSub; B++){
						Y = B + PO;
						if (Y > LSub)
							Y = Y - LSub;
					
						DPY = DiffPos[Y];
						
						if (SeqNum[DPY + os2] == SeqNum[DPY + ps1os]) 
							VSitesMat[A + B*os4 + os6] = VSitesMat[A + B*os4 + os6] + 1;
						else if (SeqNum[DPY + os2] == SeqNum[DPY + ps2os])
							VSitesMat[A + B*os4 + os7] = VSitesMat[A + B*os4 + os7] + 1;
						
						
					}
				}
			}
    
		}

	}
	//Fill empty part of the matrix
	for (X = 1; X < LSub; X++){
		os8 = X*os4;
		for (Y = X + 1; Y <= LSub; Y++){
			os9 = Y*os4;
			VSitesMat[Y + os8] = VSitesMat[X + Y*os4];
			VSitesMat[Y + os8 + os5] = VSitesMat[X + os9 + os5];
			VSitesMat[Y + os8 + os6] = VSitesMat[X + os9 + os6];
			VSitesMat[Y + os8 + os7] = VSitesMat[X + os9 + os7];
		}
	}
	return(1);
}


int FAR pascal FillSeqLines2(int NumSeqLines, int Offset1, int Offset2, int Offset4, int RSN1, int Col1, int Col2, int Col3, int Col4, int UBSL, short int *ColDist2, int *SeqLines,unsigned char *SeqColRef2, int *ColPos2){

	int X,  NS, StartP, EndP, off2, SeqCol, os3;
	off2 = UBSL+1;
	NS = NumSeqLines;
	StartP = ColPos2[RSN1];
    EndP = ColPos2[RSN1 + 1] - 2;
    if (StartP != EndP){
        if (SeqColRef2[RSN1] == 1)
            SeqCol = Col1;
        else if (SeqColRef2[RSN1] == 2)
            SeqCol = Col2; 
        else if (SeqColRef2[RSN1] == 3)
            SeqCol = Col3;
        else if (SeqColRef2[RSN1] == 4)
            SeqCol = Col4;
        

		for (X = StartP; X <= EndP; X=X+2){
			os3 = NS*off2;
			SeqLines[os3] = 0; // thing to draw is a rectangle
            SeqLines[1 + os3] = SeqCol;
			SeqLines[2 + os3] = Offset4;// 'X1
            SeqLines[3 + os3] = (int)(ColDist2[X]) * 13;
            SeqLines[4 + os3] = Offset1;// 'X2
            SeqLines[5 + os3] = (int)(ColDist2[X + 1]) * 13 + Offset2;// 'Y2
            NS = NS + 1;
        }
    }




	return(NS);
}


int FAR pascal CopyXOListsX (int UB1, int UB3, int UB2, int UB4, int NextNo, short int *CurrentXover, short int *PCurrentXOver, XOVERDEFINE *PXOList, XOVERDEFINE *XOverList, int *NumRecsI){
	int X,Y,DA,Ma,Mi, os1, off1, off2;
	off1 = UB1+1;
	off2 = UB2+1;
	for (X = 0; X <= NextNo; X++){
		for (Y = 1; Y <= CurrentXover[X]; Y++){
			PCurrentXOver[X] = PCurrentXOver[X] + 1;
			if (PCurrentXOver[X] <= UB3){
				os1 = X + PCurrentXOver[X]*off1;
				PXOList[os1] = XOverList[X + Y*off2];
        
				DA = PXOList[os1].Daughter;
				Ma = PXOList[os1].MajorP;
				Mi = PXOList[os1].MinorP;
        
				NumRecsI[DA] = NumRecsI[DA] + 1;
				
				if (Ma <= NextNo)
					NumRecsI[Ma] = NumRecsI[Ma] + 1;
				if (Mi <= NextNo)
					NumRecsI[Mi] = NumRecsI[Mi] + 1;
			}
				
		}
	}
	return(1);
}

int FAR pascal FillNuc(int X, int holder, int Nextno, int UBSN, int UBN, unsigned char *NucXX, unsigned char *NucMat2, short int *SeqNum){
	int Y, os1, os02;
	os1= UBSN+1;
	os02 = UBN+1;
	for (Y = 0; Y<= Nextno; Y++)
		NucXX[holder + Y*os02] = NucMat2[(int)(SeqNum[X + Y*os1])];
	
	return(1);
}

int FAR pascal MakeAA(int Nextno, int X, int UBSN, int *AA, unsigned char  *NucMat, short int *SeqNum){
	int Y, h1, h2, os1;
	os1 = UBSN+1;
	for (Y = 0; Y<= Nextno; Y++){
		h1 = (int)(SeqNum[X + Y*os1]);
		h2 = (int)(NucMat[h1]); 
		AA[h2]=1;
	}


	return(1);
}


int FAR pascal MakeSeqCatCount2 (int Nextno, int LSeq, int UBSN1, int UBSCC1, int StartPosInAlign,int EndPosInAlign,  int *SeqCatCount,  int *AA, short int *SeqNum, unsigned char *NucMat, unsigned char *SeqSpace, unsigned char  *NucMatB, unsigned char  *NucMat2, unsigned char *flp, unsigned char *ml, unsigned char *nl){

	int X, Y, os1, os2, ANum, NumNucs, off3, off2;
	os1 = UBSN1+1; 
	os2 = UBSCC1+1;
	ANum=0;
	SeqCatCount[0]=0;
	SeqCatCount[1]=0;
	SeqCatCount[2]=0;
	SeqCatCount[3]=0;
	SeqCatCount[4]=0;
	SeqCatCount[5]=0;
	SeqCatCount[6]=0;
	SeqCatCount[7]=0;
	SeqCatCount[8]=0;
	SeqCatCount[9]=0;
	off3 = Nextno+1;
	if (StartPosInAlign <= EndPosInAlign){


		for (X = StartPosInAlign; X <= EndPosInAlign; X++){
			off2=off3*X;
			AA[0] = 0;
			AA[1] = 0;
			AA[2] = 0;
			AA[3] = 0;
			AA[4] = 0;
			
			for (Y = 0; Y <= Nextno; Y++)
				AA[NucMat[SeqNum[X+Y*os1]]] = 1;
			
			ANum = (int)(AA[1] + AA[2] + AA[3] + AA[4]);
			
			SeqSpace[X] = AA[0];
			NumNucs = (int)(AA[0]);
			SeqCatCount[NumNucs + ANum*os2] = SeqCatCount[NumNucs + ANum*os2] + 1;
			
			for (Y = 1; Y <= 4; Y++){
				if (AA[Y] == 1){
					NucMat2[NucMatB[Y]] = NumNucs;
					NumNucs = NumNucs+1;
				}
			}
			ml[X] = AA[0];
			nl[X] = ANum;
			for (Y = 0; Y<= Nextno; Y++)
				flp[Y + off2] = NucMat2[(int)(SeqNum[X + Y*os1])];
		}
    }
	else if (StartPosInAlign > EndPosInAlign){
		for (X = StartPosInAlign; X <= LSeq; X++){
			off2=off3*X;
			AA[0] = 0;
			AA[1] = 0;
			AA[2] = 0;
			AA[3] = 0;
			AA[4] = 0;
			
			for (Y = 0; Y <= Nextno; Y++)
				AA[NucMat[SeqNum[X+Y*os1]]] = 1;
			
			ANum = (int)(AA[1] + AA[2] + AA[3] + AA[4]);
			
			SeqSpace[X] = AA[0];
			NumNucs = (int)(AA[0]);
			SeqCatCount[NumNucs + ANum*os2] = SeqCatCount[NumNucs + ANum*os2] + 1;
			NumNucs = AA[0];
			for (Y = 1; Y <= 4; Y++){
				if (AA[Y] == 1){
					NucMat2[NucMatB[Y]] = NumNucs;
					NumNucs = NumNucs+1;
				}
			}
			ml[X] = AA[0];
			nl[X] = ANum;
			for (Y = 0; Y<= Nextno; Y++)
				flp[Y + off2] = NucMat2[(int)(SeqNum[X + Y*os1])];
		}
		for (X = 1; X <= EndPosInAlign; X++){
			off2=off3*X;
			AA[0] = 0;
			AA[1] = 0;
			AA[2] = 0;
			AA[3] = 0;
			AA[4] = 0;
			
			for (Y = 0; Y <= Nextno; Y++)
				AA[NucMat[SeqNum[X+Y*os1]]] = 1;
			
			ANum = (int)(AA[1] + AA[2] + AA[3] + AA[4]);
			
			SeqSpace[X] = AA[0];
			NumNucs = (int)(AA[0]);
			SeqCatCount[NumNucs + ANum*os2] = SeqCatCount[NumNucs + ANum*os2] + 1;
			NumNucs = AA[0];
			for (Y = 1; Y <= 4; Y++){
				if (AA[Y] == 1){
					NucMat2[NucMatB[Y]] = NumNucs;
					NumNucs = NumNucs+1;
				}
			}
			ml[X] = AA[0];
			nl[X] = ANum;
			for (Y = 0; Y<= Nextno; Y++)
				flp[Y + off2] = NucMat2[(int)(SeqNum[X + Y*os1])];
		}

	}

	return(1);
}


int FAR pascal MakeNucSets(int Nextno, int LSeq, int UBSN1, int UBSCC1, int StartPosInAlign, int EndPosInAlign, int *AA, unsigned char  *NucMatB, unsigned char *Nuc11, unsigned char *Nuc02, unsigned char *Nuc12, unsigned char *Nuc03, unsigned char *Nuc13, unsigned char *Nuc04, unsigned char *Nuc14, int *SeqCatCount, short int *SeqNum, unsigned char  *NucMat, unsigned char  *NucMat2, unsigned char *SeqCat, unsigned char *SeqSpace){

	int X, Y, os1, os2, holder, holder2, ANum, NumNucs, h1, h2;

	int os11, os02, os12, os03, os13, os04, os14;

	os1 = UBSN1+1;
	os2 = UBSCC1+1;
	
	os11 = SeqCatCount[3]+1;
	os02 = SeqCatCount[4]+1;
	os12 = SeqCatCount[5]+1;
	os03 = SeqCatCount[6]+1;
	os13 = SeqCatCount[7]+1;
	os04 = SeqCatCount[8]+1;
	os14 = SeqCatCount[9]+1;
	
	SeqCatCount[0]=0;
	SeqCatCount[1]=0;
	SeqCatCount[2]=0;
	SeqCatCount[3]=0;
	SeqCatCount[4]=0;
	SeqCatCount[5]=0;
	SeqCatCount[6]=0;
	SeqCatCount[7]=0;
	SeqCatCount[8]=0;
	SeqCatCount[9]=0;
	ANum = 0;
	holder = 0;
	X = StartPosInAlign;
	holder2 = 0;
	
	while (X != EndPosInAlign){
		

		AA[0] = 0;
		AA[1] = 0;
		AA[2] = 0;
		AA[3] = 0;
		AA[4] = 0;
		
		for (Y = 0; Y<= Nextno; Y++){
			h1 = (int)(SeqNum[X + Y*os1]);
			h2 = (int)(NucMat[h1]); 
			AA[h2]=1;
		}
			
		
		//return(holder);
		ANum = AA[1] + AA[2] + AA[3] + AA[4];
		
		SeqCat[X] = ANum;
		SeqSpace[X] = AA[0];
		SeqCatCount[AA[0] + ANum*os2] = SeqCatCount[AA[0] + ANum*os2] + 1;

		NumNucs = AA[0];
		
		
		for (Y = 1; Y <= 4; Y++){
			if (AA[Y] == 1){
				NucMat2[NucMatB[Y]] = NumNucs;
				NumNucs = NumNucs+1;
			}
		}
		
		holder = (int)(SeqCatCount[AA[0] + ANum*os2]);
		if (AA[0] == 1){
			if (ANum == 1){
					for (Y = 0; Y<= Nextno; Y++)
						Nuc11[holder + Y*os11] = NucMat2[SeqNum[X + Y*os1]];
			}
			else if (ANum == 2 && AA[0] == 1){
				for (Y = 0; Y<= Nextno; Y++)
					Nuc12[holder + Y*os12] = NucMat2[SeqNum[X + Y*os1]];
			}
			else if  (ANum == 3){
				for (Y = 0; Y<= Nextno; Y++)
					Nuc13[holder + Y*os13] = NucMat2[SeqNum[X + Y*os1]];
				
			}
			else if (ANum == 4 && AA[0] == 1){
				for (Y = 0; Y<= Nextno; Y++)
					Nuc14[holder + Y*os14] = NucMat2[SeqNum[X + Y*os1]];
			}
		}
		else{

			if (ANum == 2){
				for (Y = 0; Y<= Nextno; Y++)
					Nuc02[holder + Y*os02] = NucMat2[SeqNum[X + Y*os1]];
			}
			else if  (ANum == 3){
				for (Y = 0; Y<= Nextno; Y++)
					Nuc03[holder + Y*os03] = NucMat2[SeqNum[X + Y*os1]];
			}
			else if (ANum == 4 && AA[0] == 0){
				for (Y = 0; Y<= Nextno; Y++)
					Nuc04[holder + Y*os04] = NucMat2[SeqNum[X + Y*os1]];
			}

			
		
		}
		X=X+1;
		if (X > LSeq)
			X = 1;
		//if (X == EndPosInAlign)
		//	break;
	}




	return(1);
}

int FAR pascal MakeValTots(int Nextno, int SCO, int UBX, int UBFM, int UBFV, int UBMP, int *ValtotS, int *ValtotF, int *ISeqs, unsigned char *MissPair, float *FubValid, float *SubValid, float *FMat, float *SMat){
	int Z,X, Y, off1, off2, off3, off4, off5, off6, GoOn, A;
	off1=UBFM+1;
	off3= UBFV+1;
	off5 = UBMP+1;
	GoOn=0;
	for (X = 0; X<=Nextno; X++){
        off2=off1*X;
		
        if (FMat[X + off2] != 3.0){
            off4=off3*X;
			off6=off5*X;
            for (Y = X + 1; Y <= Nextno; Y++){
                if (FMat[Y + off1*Y] != 3.0){
                    if (FMat[Y + off2] != 3.0){
						if (FubValid[Y + off4] < SCO){
                            MissPair[X + Y*off5] = 1;
                            MissPair[Y + off6] = 1;
                            for (Z = 0; Z <=2; Z++){
								A = ISeqs[Z];
                                if (ISeqs[Z] <= UBX){
                                    ValtotF[X] = ValtotF[X] + (int)(FubValid[A + X*off3]);
                                    ValtotF[Y] = ValtotF[Y] + (int)(FubValid[A + Y*off3]);
                                }
                            }
                            GoOn = 1;
                        }
                        if (SubValid[Y + off4] < SCO && SMat[Y + off2]!= 3.0){
                            MissPair[X + Y*off5] = 1;
                            MissPair[Y + off6] = 1;
                            for (Z = 0; Z <=2; Z++){
								A = ISeqs[Z];
                                if (ISeqs[Z] <= UBX){
                                    ValtotS[X] = ValtotS[X] + (int)(SubValid[A + X*off3]);
                                    ValtotS[Y] = ValtotS[Y] + (int)(SubValid[A + Y*off3]);
                                }
                            }
                            GoOn = 1;
                        }
					}
                }
            }
        
        }
    }

	return(GoOn);
}
unsigned char FAR pascal FixOverlaps(unsigned char DoneThisOne, int CurBegin, int CurEnd, int CurProg, int X, int Y, int MSX, float LSAdjust,int UBPD, int UBXONC1, int UBXONC2, unsigned char *ProgDo,short int *XOverNoComponent, short int *MaxXONo){
	int Z, RN, os1, os2, os3, os4, os5, holder;
	unsigned char dto;
	double J, K, L;
	os1 = UBXONC1+1;
	os2 = os1*(UBXONC2+1);
	os3 = CurProg + MSX*(UBPD+1);
	os4= X*os1;
	dto = DoneThisOne;
	//os5=
	//srand((int)(CurProb));
	L=(double)(RAND_MAX);
	os5 = CurProg + os4 ;
	for (Z = CurBegin; Z<= CurEnd; Z++){
            
        //if (CurProb > 0){
            
			K=(double)(rand());
			J=(K/L)*3;
			
			RN = (int)(J)+1;
            //RN = (int)((rand() / RAND_MAX)*100 +1);//Int((3 * Rnd) + 1)
            //return(RN);
            if (RN == 2){
                holder = (int)(Z * LSAdjust);
                XOverNoComponent[os5+ holder*os2]  = Y;
                
                ProgDo[os3] = 1;
                
                if (dto == 0){
                    MaxXONo[MSX] = MaxXONo[MSX] + 1;
                    dto = 1;
				}
            }

       // }
    }

	return(dto);
}

int FAR pascal MakeSeqCatCount (int Nextno, int LSeq, int UBSN1, int UBSCC1, int StartPosInAlign,int EndPosInAlign,  int *SeqCatCount,  int *AA, short int *SeqNum, unsigned char *NucMat){

	int X, Y, os1, os2, ANum;
	os1 = UBSN1+1; 
	os2 = UBSCC1+1;
	ANum=0;
	if (StartPosInAlign <= EndPosInAlign){


		for (X = StartPosInAlign; X <= EndPosInAlign; X++){
			AA[0] = 0;
			AA[1] = 0;
			AA[2] = 0;
			AA[3] = 0;
			AA[4] = 0;
			
			for (Y = 0; Y <= Nextno; Y++)
				AA[NucMat[SeqNum[X+Y*os1]]] = 1;
			
			ANum = AA[1] + AA[2] + AA[3] + AA[4];
			//SeqCat[X] = ANum;
			//SeqSpace[X] = AA[0];
			SeqCatCount[AA[0] + ANum*os2] = SeqCatCount[AA[0] + ANum*os2] + 1;
		}
    }
	else if (StartPosInAlign > EndPosInAlign){
		for (X = StartPosInAlign; X <= LSeq; X++){
			AA[0] = 0;
			AA[1] = 0;
			AA[2] = 0;
			AA[3] = 0;
			AA[4] = 0;
			
			for (Y = 0; Y <= Nextno; Y++)
				AA[NucMat[SeqNum[X+Y*os1]]] = 1;
			
			ANum = AA[1] + AA[2] + AA[3] + AA[4];
			//SeqCat[X] = ANum;
			//SeqSpace[X] = AA[0];
			SeqCatCount[AA[0] + ANum*os2] = SeqCatCount[AA[0] + ANum*os2] + 1;
		}
		for (X = 1; X <= EndPosInAlign; X++){
			AA[0] = 0;
			AA[1] = 0;
			AA[2] = 0;
			AA[3] = 0;
			AA[4] = 0;
			
			for (Y = 0; Y <= Nextno; Y++)
				AA[NucMat[SeqNum[X+Y*os1]]] = 1;
			
			ANum = AA[1] + AA[2] + AA[3] + AA[4];
			//SeqCat[X] = ANum;
			//SeqSpace[X] = AA[0];
			SeqCatCount[AA[0] + ANum*os2] = SeqCatCount[AA[0] + ANum*os2] + 1;
		}

	}

	return(1);
}


int FAR pascal CopyDistandFindMinMax(int Nextno, int UBT, int UBD, float *MaxDistSch, float *MinDistSch, float *TDistance, float *Distance){
	int X, Y, os1, os2;
	float MaxD, MinD;
	os1 = UBD+1;
	os2 = UBT+1;
	MaxD = *MaxDistSch;
	MinD = *MinDistSch;
	for (X = 0; X < Nextno; X++){

        for (Y = X + 1; Y <= Nextno; Y++){
            if (Y <= UBD){ 
                TDistance[X + Y*os2] = Distance[X+ Y*os1];
                TDistance[Y + X*os2] = TDistance[X + Y*os2];
    
                if (TDistance[X + Y*os2] > MaxD)
                    MaxD = TDistance[X + Y*os2];
                
                if (TDistance[X + Y*os2] < MinD)
                    MinD = TDistance[X + Y*os2];
                
			}
                
            else
                break;
            
		}

    }

	*MaxDistSch = MaxD;
	*MinDistSch = MinD;
	return(1);

}


int FAR pascal GoRight(int Seq1, int Seq2, int Seq3, int CircularFlag, int startpos, int LS, int UBMD, unsigned char *MissingData){
 int CycleX, Z, os1,os2,os3, X;
 os1 = Seq1*(UBMD+1);
 os2 = Seq2*(UBMD+1);
 os3 = Seq3*(UBMD+1);
 Z = startpos;
 CycleX=0;
 for (X = 1; X <= LS; X++){
            Z = Z + 1;
           
            if (Z > LS) {
                if (CircularFlag == 0){
                    Z = 1;
                    break;
    }
                else{
                    Z = 1;
                    CycleX = CycleX + 1;
                    if (CycleX == 3)
                        break;
                   
                }
   }
             if (MissingData[Z + os1] == 0 && MissingData[Z + os2] == 0 && MissingData[Z + os3] == 0)
                break;
           
           
    }
 return (Z);
}

int FAR pascal GoLeft(int Seq1, int Seq2, int Seq3, int CircularFlag, int startpos, int LS, int UBMD, unsigned char *MissingData){
 int X, CycleX, Z, os1,os2,os3;
 os1 = Seq1*(UBMD+1);
 os2 = Seq2*(UBMD+1);
 os3 = Seq3*(UBMD+1);
 Z = startpos;
 CycleX=0;
 for (X = 1; X <= LS; X++){
            Z = Z - 1;
           
            if (Z < 1) {
                if (CircularFlag == 0){
                    Z = LS;
                    break;
    }
                else{
                    Z = LS;
                    CycleX = CycleX + 1;
                    if (CycleX == 3)
                        break;
                   
                }
   }
            if (MissingData[Z + os1] == 0 && MissingData[Z + os2] == 0 && MissingData[Z + os3] == 0)
                break;
           
           
    }
 return (Z);
}


int FAR pascal CalcHits(int WinPP, int LS, int CTest, int BPos2, int EPos2, int UBSN, int UBCM, short int *SeqNum, int *ISeqs, int *CompMat, float *Hits, float *Tots){
// (byval WinPP as long, byval LS as long, byval CTest as long, byval BPos2 as long, byval EPos2 as long, byval UBSN as long, byval UBCM as long, byref SeqNum as integer, byref ISeqs as long, byref CompMat as long, byref Hits as single, byref Tots as single) as long 
 int A, B, CPar, os1, os2, os3; 
 os1 = UBCM+1;
 os3 = UBSN+1;
 for (A = 0; A<= 1; A++){
  os2=os1*A;
        Tots[A] = 0;
        Hits[A] = 0;
        CPar = ISeqs[CompMat[WinPP + A*os2]];
        if (BPos2 < EPos2){
       
            for (B = BPos2; B<= EPos2; B++){
                if (SeqNum[B + CTest*os3] != 46){
                    if (SeqNum[B + CPar*os3] != 46){
                        Tots[A] = Tots[A] + 1;
                        if (SeqNum[B + CPar*os3] != SeqNum[B + CTest])
                            Hits[A] = Hits[A] + 1;
                      
                    }
                }
   }
  }
        else{
            for (B = 1; B <= EPos2; B++){
                if (SeqNum[B + CTest*os3] != 46){
                    if (SeqNum[B + CPar*os3] != 46){
                        Tots[A] = Tots[A] + 1;
                        if (SeqNum[B + CPar*os3] != SeqNum[B + CTest])
                            Hits[A] = Hits[A] + 1;
                      
                    }
                }
            }
           
            for (B = BPos2; B <= LS; B++){
                if (SeqNum[B + CTest*os3] != 46){
                    if (SeqNum[B + CPar*os3] != 46){
                        Tots[A] = Tots[A] + 1;
                        if (SeqNum[B + CPar*os3] != SeqNum[B + CTest])
                            Hits[A] = Hits[A] + 1;
                      
                    }
                }
            }
        }
        if (Tots[A] > 0)
            Hits[A] = (float)(Hits[A] / Tots[A]);
        else
            Hits[A] = (float)(0);
       
      
    }

 return(1);
}


int FAR pascal CheckEnds(int LS, int RL, int LSS, int ChF, int CirF, int Seq1, int Seq2, int Seq3, int BPos , int EPos , short int *SeqNum , int *XPD, int *XDP, unsigned char *MissingData){
 int X, Target, os1, os2, os3, warn;
 os1 = Seq1*(LS+1);
 os2 = Seq2*(LS+1);
 os3 = Seq3*(LS+1);
 warn=0;
 if (ChF == 0){
   
  if (XPD[BPos] - RL > 0)
   Target = XDP[XPD[BPos] - RL];
  else{
   if (CirF == 1){
    if (XPD[BPos] - RL + LSS >= 0)
     Target = XDP[XPD[BPos] - RL + LSS];
    else
     Target = 1;
    
   }
   else
    Target = 1;
   
  }
  if (Target < BPos){
   for (X = Target; X <= BPos; X++){
    if (MissingData[X + os1] == 1 || MissingData[X + os2] == 1 || MissingData[X + os3] == 1){
     warn = 1;
     break;
    }
   }
  }
  else{
   for (X = Target; X <LS; X++){
    if (MissingData[X + os1] == 1 || MissingData[X + os2] == 1 || MissingData[X + os3] == 1){
     warn = 1;
     break;
    }
   }
   if (warn == 0) {
    if (CirF == 0){
     if (MissingData[LS + os1] == 1 || MissingData[LS + os2] == 1 || MissingData[LS + os3] == 1)
      warn = 1;
     
     if (MissingData[1 + os1] == 1 || MissingData[1 + os2] == 1 || MissingData[1 + os3] == 1)
      warn = 1;
    }
   }
   if (warn == 0) { 
    for (X = 2; X<= BPos; X++){
     if (MissingData[X + os1] == 1 || MissingData[X + os2] == 1 || MissingData[X + os3] == 1){
      warn = 1;
      break;
     }
    }
   }
  }
 }
 else if (ChF == 1){
   
  if (XPD[EPos] + RL < LSS)
   Target = XDP[XPD[EPos] + RL];
  else{
   if (CirF == 1)
    Target = XDP[XPD[EPos] + RL - LSS];
           
   else
    Target = LS;
   
  }
  if (XPD[EPos] - RL > 0)
            EPos = XDP[XPD[EPos] - RL];
        else{
            if (CirF == 1){
                if (XPD[EPos] - RL + LSS >= 0)
                    EPos = XDP[XPD[EPos] - RL + LSS];
                else
                    EPos = 1;
              
   }
            else
                EPos = 1;
           
        }
        if (EPos < 1){
            if (CirF == 1)
                EPos = EPos + LS;
            else
           
                EPos = LS;
           
        }
  if (Target > EPos){
   for (X = EPos; X <= Target; X++){
    if (MissingData[X + os1] == 1 || MissingData[X + os2] == 1 || MissingData[X + os3] == 1){
     warn = 1;
     break;
    }
   }
  }
  else{
   for (X = EPos; X<=LS-1; X++){
    if (MissingData[X + os1] == 1 || MissingData[X + os2] == 1 || MissingData[X + os3] == 1){
     warn = 1;
     break;
    }
   }
   if (warn == 0) {
    if (CirF == 0){
     if (MissingData[LS + os1] == 1 || MissingData[LS + os2] == 1 || MissingData[LS + os3] == 1)
      warn = 1;
     
     if (MissingData[1 + os1] == 1 || MissingData[1 + os2] == 1 || MissingData[1 + os3] == 1)
      warn = 1;
    }
   }
   if (warn == 0){
    for (X = 2; X <= Target; X++){
     if (MissingData[X + os1] == 1 || MissingData[X + os2] == 1 || MissingData[X + os3] == 1){
      warn = 1;
      break;
     }
    }
   }
  }
 }
 return(warn);
}

int FAR pascal FindSubSeq2(short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, short int nextno,short int seq1,short int seq2,short int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,short int *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff, short int *validspacer)

//int FAR pascal FindSubSeq(short int lenseq,short int seq1,short int seq2,short int seq3, short int *seqnum, short int *xoverseqnum)

{ 
	
	int hoc, oc;
	short int s1,s2,s3,sz;
	short int holder = 0;
	short int y = 0;
	int g=0;
	oc = 0;
	hoc=0;
	
	if (spacerflag==0){
		hoc = xoverwindow*10;
		for (int x = 1; x < lenseq; x++){
			

			*(xposdiff + x) = y;
			s1 = *(seqnum + x + seq1*lenseq);
			s2 = *(seqnum + x + seq2*lenseq);
			s3 = *(seqnum + x + seq3*lenseq);
			if (s1 != s2 || s1 != s3) {
				
				if (s1 != s2 && s1 != s3 && s2 != s3){
				 g++;    
				}
				else {
					if (s1 > 65  && s2 > 65  && s3 > 65){
						y ++;
						*(xdiffpos + y) = x;
						*(xposdiff + x) = y;
					}    
				}
			}
		}
	}
	
	if (spacerflag==1){
		for (int x = 1; x < lenseq; x++){
			
				*(xposdiff + x) = y;
				s1 = *(seqnum + x + seq1*lenseq);
				s2 = *(seqnum + x + seq2*lenseq);
				s3 = *(seqnum + x + seq3*lenseq);
				
				if (s1 != s2 || s1 != s3) {
					
					if (s1 != s2 && s1 != s3 && s2 != s3){
					 g++;    
					}
					else {
						if (s1 > 65  && s2 > 65  && s3 > 65){
							if (s1  !=  s2  && s1  != s3) {
							//If seq1 is odd one
								
								
								if (outlyer == seq1){
									if (oc > 0){
										if (oc > hoc)
											hoc = oc;
										oc--;
									}
                                       
									*(xdiffpos + y) = x;
									*(xposdiff + x) = y;
									
								}
								else {
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
										if (sz == s1) {
										//If difference is legitimate
											if( *(xdiffpos + y) != x){
												oc += 2;
												y++;
                                        
												*(xdiffpos + y) = x;
												*(xposdiff + x) = y;
												z = spacerno;
												
											}
													
										}
										
									}
											
								}
							}
							else if (s2  != s1  && s2  != s3) {
								//If seq2 is odd one
								
								if (outlyer == seq2){
									if (oc >0){
										if (oc > hoc)
											hoc = oc;
										oc--;
									}
									y++;
                                       
									*(xdiffpos + y) = x;
									*(xposdiff + x) = y;
											
								}
								else{
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
										if (s2 == sz){
										//If difference is legitimate
                                        
											if( *(xdiffpos + y) != x){
												oc+=2;
												y++;
                                       
												*(xdiffpos + y) = x;
												*(xposdiff + x) = y;
												z = spacerno;
													
											}
										}
									}
								}
							}
							else if (s3  != s1  && s3  != s2) {
							//If seq3 is odd one
								if (outlyer == seq3){
									if (oc >0){
										if (oc > hoc)
											hoc = oc;
										oc--;
									}
									y++;
                                        
									*(xdiffpos + y) = x;
									*(xposdiff + x) = y;
									
																	
								}
								else{
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
										if (s3 == sz){
													
										//If difference is legitimate
											if( *(xdiffpos + y) != x){
												oc+=2;
												y++;
												*(xdiffpos + y) = x;
												*(xposdiff + x) = y;
												z = spacerno;
											}
										}
									}
								}
							}
						}    
					}
				}
			
		}
	}
	if (spacerflag>1){
		for (int x = 1; x < lenseq; x++){
			s1 = *(seqnum + x + seq1*lenseq);
			s2 = *(seqnum + x + seq2*lenseq);
			s3 = *(seqnum + x + seq3*lenseq);
			*(xposdiff + x) = y;
			
			if (s1 != s2 || s1 != s3) {
				
				if (s1 != s2 && s1 != s3 && s2 != s3 ){
				 g++;    
				}
				else {
					if (s1 > 65  && s2 > 65  && s3 > 65){
                       
                        
						if (s1  != s2  && s1  != s3) {
								//If seq1 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
										if (sz == s1){
										//If difference is legitimate
                                        
											y++;
											*(xdiffpos + y) = 0;

											if (seq1 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}


											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}	
									}
								}
								if (s2  != s1  && s2  != s3) {
								//If seq2 is odd one
									for (short int z = 1; z <= spacerno; z++){
										sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
										
										if (s2 == sz){
										//If difference is legitimate
                                        
											y++;
											*(xdiffpos + y) = 0;
											if (seq2 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
									}
								}
								if (s3 != s1  && s3  != s2) {
								//If seq3 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
										
										if (s3 == sz){
                                   
										//If difference is legitimate
                                       
											y++;
											*(xdiffpos + y) = 0;

											if (seq3 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
									}
						}
					}    
				}
			}
		}
	}
	
	
	//for (b = y+1; b < y + xoverwindow; b++)
	//	*(xdiffpos + b) = 0;

	
	//for (b = lenseq+1; b < lenseq + xoverwindow; b++)
	//	*(xposdiff + b) = 0;

	if (hoc < oc)
		hoc = oc;

	if (hoc < xoverwindow * 2)
		return (-y);
	else
		return(y);
}


/*int FAR pascal FindSubSeq(int rlen,short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, short int nextno,short int seq1,short int seq2,short int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,short int *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff, short int *validspacer , int *diffmap)

//int FAR pascal FindSubSeq(short int lenseq,short int seq1,short int seq2,short int seq3, short int *seqnum, short int *xoverseqnum)

{ 
	
	int hoc, oc, b, x;
	short int s1,s2,s3,sz;
	short int holder = 0;
	short int y = 0;
	int g=0;
	oc = 0;
	hoc=0;
	
	if (spacerflag==0){
		hoc = xoverwindow*10;
		for (int a = 1; a < rlen; a++){
			x = diffmap[a];

			*(xposdiff + x) = y;
			s1 = *(seqnum + x + seq1*lenseq);
			s2 = *(seqnum + x + seq2*lenseq);
			s3 = *(seqnum + x + seq3*lenseq);
			if (s1 != s2 || s1 != s3) {
				
				if (s1 != s2 && s1 != s3 && s2 != s3){
				 g++;    
				}
				else {
					if (s1 > 65  && s2 > 65  && s3 > 65){
                       
                        
						y ++;

						*(xoverseqnum + y) = s1;
						*(xoverseqnum + y + lenseq) = s2;
						*(xoverseqnum + y + lenseq*2) = s3;
                                        
						*(xoverseqnumw + y + xoverwindow) = s1;
						*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
						*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
						*(xdiffpos + y) = x;
						*(xposdiff + x) = y;
					}    
				}
			}
		}
		for (b = 1; b<= xoverwindow;b++){
			*(xoverseqnumw + b ) = *(xoverseqnum + y - xoverwindow + b);
			*(xoverseqnumw + b + lenseq + xoverwindow*2) = *(xoverseqnum + y - xoverwindow + b + lenseq);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 1)
			*(xoverseqnumw + b + lenseq*2 + xoverwindow*4) = *(xoverseqnum + y - xoverwindow + b + lenseq*2);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 2)
                                        
			*(xoverseqnumw + y + xoverwindow + b ) = *(xoverseqnum + b);//XOverSeqNum(X, 0)
			*(xoverseqnumw + y + xoverwindow + b  + lenseq + xoverwindow*2) = *(xoverseqnum + b + lenseq);
			*(xoverseqnumw + y + xoverwindow + b  + lenseq*2 + xoverwindow*4) = *(xoverseqnum + b + lenseq*2);
		}
	}
	
	if (spacerflag==1){
		for (int a = 1; a < rlen; a++){
			
				x = diffmap[a];
				
				*(xposdiff + x) = y;
				s1 = *(seqnum + x + seq1*lenseq);
				s2 = *(seqnum + x + seq2*lenseq);
				s3 = *(seqnum + x + seq3*lenseq);
				
				if (s1 != s2 || s1 != s3) {
					
					if (s1 != s2 && s1 != s3 && s2 != s3){
					 g++;    
					}
					else {
						if (s1 > 65  && s2 > 65  && s3 > 65){
							if (s1  !=  s2  && s1  != s3) {
							//If seq1 is odd one
								
								
								if (outlyer == seq1){
									if (oc > 0){
										if (oc > hoc)
											hoc = oc;
										oc--;
									}
									y++;
									*(xoverseqnum + y) = s1;
									*(xoverseqnum + y + lenseq) = s2;
									*(xoverseqnum + y + lenseq*2) = s3;
                                        
									*(xoverseqnumw + y + xoverwindow) = s1;
									*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
									*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
									*(xdiffpos + y) = x;
									*(xposdiff + x) = y;
									
								}
								else {
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
										if (sz == s1) {
										//If difference is legitimate
											if( *(xdiffpos + y) != x){
												oc += 2;
												y++;
												*(xoverseqnum + y) = s1;
												*(xoverseqnum + y + lenseq) = s2;
												*(xoverseqnum + y + lenseq*2) = s3;
                                        
												*(xoverseqnumw + y + xoverwindow) = s1;
												*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
												*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
												*(xdiffpos + y) = x;
												*(xposdiff + x) = y;
												z = spacerno;
												
											}
													
										}
										
									}
											
								}
							}
							else if (s2  != s1  && s2  != s3) {
								//If seq2 is odd one
								
								if (outlyer == seq2){
									if (oc >0){
										if (oc > hoc)
											hoc = oc;
										oc--;
									}
									y++;
									*(xoverseqnum + y) = s1;
									*(xoverseqnum + y + lenseq) =s2;
									*(xoverseqnum + y + lenseq*2) = s3;
                                        
									*(xoverseqnumw + y + xoverwindow) = s1;
									*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
									*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
									*(xdiffpos + y) = x;
									*(xposdiff + x) = y;
											
								}
								else{
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
										if (s2 == sz){
										//If difference is legitimate
                                        
											if( *(xdiffpos + y) != x){
												oc+=2;
												y++;
												*(xoverseqnum + y) = s1;
												*(xoverseqnum + y + lenseq) = s2;
												*(xoverseqnum + y + lenseq*2) = s3;
                                        
												*(xoverseqnumw + y + xoverwindow) = s1;
												*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
												*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
												*(xdiffpos + y) = x;
												*(xposdiff + x) = y;
												z = spacerno;
													
											}
										}
									}
								}
							}
							else if (s3  != s1  && s3  != s2) {
							//If seq3 is odd one
								if (outlyer == seq3){
									if (oc >0){
										if (oc > hoc)
											hoc = oc;
										oc--;
									}
									y++;
									*(xoverseqnum + y) = s1;
									*(xoverseqnum + y + lenseq) = s2;
									*(xoverseqnum + y + lenseq*2) = s3;
                                        
									*(xoverseqnumw + y + xoverwindow) = s1;
									*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
									*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
									*(xdiffpos + y) = x;
									*(xposdiff + x) = y;
									
																	
								}
								else{
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs+z)*lenseq);
										if (s3 == sz){
													
										//If difference is legitimate
											if( *(xdiffpos + y) != x){
												oc+=2;
												y++;
												*(xoverseqnum + y) = s1;
												*(xoverseqnum + y + lenseq) = s2;
												*(xoverseqnum + y + lenseq*2) = s3;
                                        
												*(xoverseqnumw + y + xoverwindow) = s1;
												*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
												*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;

												*(xdiffpos + y) = x;
												*(xposdiff + x) = y;
												z = spacerno;
											}
										}
									}
								}
							}
						}    
					}
				}
			
		}
		for (b = 1; b<= xoverwindow;b++){
			*(xoverseqnumw + b ) = *(xoverseqnum + y - xoverwindow + b);
			*(xoverseqnumw + b + lenseq + xoverwindow*2) = *(xoverseqnum + y - xoverwindow + b + lenseq);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 1)
			*(xoverseqnumw + b + lenseq*2 + xoverwindow*4) = *(xoverseqnum + y - xoverwindow + b + lenseq*2);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 2)
                                        
			*(xoverseqnumw + y + xoverwindow + b ) = *(xoverseqnum + b);//XOverSeqNum(X, 0)
			*(xoverseqnumw + y + xoverwindow + b  + lenseq + xoverwindow*2) = *(xoverseqnum + b + lenseq);
			*(xoverseqnumw + y + xoverwindow + b  + lenseq*2 + xoverwindow*4) = *(xoverseqnum + b + lenseq*2);
		}
	}
	if (spacerflag>1){
		for (int a = 1; a < rlen; a++){
			x = diffmap[a];
			s1 = *(seqnum + x + seq1*lenseq);
			s2 = *(seqnum + x + seq2*lenseq);
			s3 = *(seqnum + x + seq3*lenseq);
			*(xposdiff + x) = y;
			
			if (s1 != s2 || s1 != s3) {
				
				if (s1 != s2 && s1 != s3 && s2 != s3 ){
				 g++;    
				}
				else {
					if (s1 > 65  && s2 > 65  && s3 > 65){
                       
                        
						if (s1  != s2  && s1  != s3) {
								//If seq1 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
										if (sz == s1){
										//If difference is legitimate
                                        
											y++;
											*(xdiffpos + y) = 0;

											if (seq1 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}


											*(xoverseqnum + y) = s1;
											*(xoverseqnum + y + lenseq) = s2;
											*(xoverseqnum + y + lenseq*2) = s3;
                                        
											*(xoverseqnumw + y + xoverwindow) = s1;
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}	
									}
								}
								if (s2  != s1  && s2  != s3) {
								//If seq2 is odd one
									for (short int z = 1; z <= spacerno; z++){
										sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
										
										if (s2 == sz){
										//If difference is legitimate
                                        
											y++;
											*(xdiffpos + y) = 0;
											if (seq2 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}
											*(xoverseqnum + y) = s1;
											*(xoverseqnum + y + lenseq) = s2;
											*(xoverseqnum + y + lenseq*2) = s3;
                                        
											*(xoverseqnumw + y + xoverwindow) = s1;
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
									}
								}
								if (s3 != s1  && s3  != s2) {
								//If seq3 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										sz = *(seqnum + x + *(spacerseqs + z) * lenseq);
										
										if (s3 == sz){
                                   
										//If difference is legitimate
                                       
											y++;
											*(xdiffpos + y) = 0;

											if (seq3 != outlyer)
												oc+=2;
											else{
												if (oc >0){
													if (oc > hoc)
														hoc = oc;
													oc--;
												}
											}

											*(xoverseqnum + y) = s1;
											*(xoverseqnum + y + lenseq) = s2;
											*(xoverseqnum + y + lenseq*2) = s3;
                                        
											*(xoverseqnumw + y + xoverwindow) = s1;
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = s2;
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = s3;
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
									}
						}
					}    
				}
			}
		}
		for (b = 1; b <= xoverwindow;b++){
			*(xoverseqnumw + b ) = *(xoverseqnum + y - xoverwindow + b);
			*(xoverseqnumw + b + lenseq + xoverwindow*2) = *(xoverseqnum + y - xoverwindow + b + lenseq);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 1)
			*(xoverseqnumw + b + lenseq*2 + xoverwindow*4) = *(xoverseqnum + y - xoverwindow + b + lenseq*2);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 2)
                                        
			*(xoverseqnumw + y + xoverwindow + b ) = *(xoverseqnum + b);//XOverSeqNum(X, 0)
			*(xoverseqnumw + y + xoverwindow + b  + lenseq + xoverwindow*2) = *(xoverseqnum + b + lenseq);
			*(xoverseqnumw + y + xoverwindow + b  + lenseq*2 + xoverwindow*4) = *(xoverseqnum + b + lenseq*2);
        
		}
	}
	
	
	//for (b = y+1; b < y + xoverwindow; b++)
	//	*(xdiffpos + b) = 0;

	
	//for (b = lenseq+1; b < lenseq + xoverwindow; b++)
	//	*(xposdiff + b) = 0;

	if (hoc < oc)
		hoc = oc;

	if (hoc < xoverwindow * 2)
		return (-y);
	else
		return(y);
}*/

double FAR pascal MakeGoodC(int Nextno, int lenseq, int *GoodC, int *BPosLR, short int *SeqNum){
    //goodc nextno,1
	int Y,X, Z, SP, EP,vs;
	double vsx;
	for (Z = 0; Z < 2; Z++){
        if (Z == 0){
            SP = BPosLR[0];
            EP = BPosLR[1];
		}
        else{
            SP = BPosLR[2];
            EP = BPosLR[3];
        }
        for (X = 0; X <= Nextno; X++){
            vs = 0;
            if (SP < EP) {
                for (Y = SP; Y <= EP; Y++){
                    if (SeqNum[Y + X*(lenseq+1)] != 46)
                        vs++;
                }
                vsx = (double)(vs);
				
				if (vsx > 10)
					GoodC[X + Z*(Nextno+1)] = 1;
			}
            else{
                for (Y = SP; Y <= lenseq; Y++){
                    if (SeqNum[Y + X*(lenseq+1)] != 46)
                        vs++;
				}
                    
                
				for (Y = 1; Y <= EP; Y++){
                    if (SeqNum[Y + X*(lenseq+1)] != 46)
                        vs++;
				}
                    
                vsx = (double)(vs);
				
				if (vsx > 10)
					GoodC[X + Z*(Nextno+1)] = 1;
            }
		}
        
    }
	return(1);
}

int FAR pascal CollapseNodesX(int NextNo, float CutOff, int *T, float *DLen, float *CMat, float *AMat, float *TraceBak){

	int X, Y, Z, A, GoOn,off1,off2, off3;
	float LODist;

	off1 = NextNo+1;
	for (X = 0; X <= NextNo; X++){
		if (DLen[X] < CutOff){

			//First find two sequences with this dist
			GoOn = 0;
			LODist = 100000;
			for (Y = 0; Y < NextNo; Y++){
				off2 = Y*off1;
				for (Z = Y + 1; Z <= NextNo; Z++){
                
					if (AMat[Z+off2] == TraceBak[X]){
						GoOn = 1;
						T[0] = Y;
						T[1] = Z;
						off3 = Z*off1;
						for (A = 0; A <= NextNo; A++){
							if (AMat[A+off2] == AMat[A+off3]){
								if (AMat[A+off2] > TraceBak[X] && AMat[A+off2] < LODist)
									LODist = AMat[A+off2] ;
							
							}
						}
					}
				}
				//If GoOn = 1 Then Exit For
			}
        
			//Find next lowest dist
			if (GoOn == 1 ){
            
				if (LODist < 100000){
					for (Y = 0; Y < NextNo; Y++){
						off2 = Y*off1;
						for (Z = Y + 1; Z <= NextNo; Z++){
                        
							if (AMat[Z+off2] == TraceBak[X]){
								AMat[Y+ Z*off1] = (float)(LODist);
								AMat[Z+off2] = (float)(LODist);
                         
							}
						}
					}
				}
				else{
					for (Y = 0; Y < NextNo; Y++){
						off2 = Y*off1;
						for (Z = Y + 1; Z <= NextNo; Z++){
                    
							if (AMat[Z+off2] == TraceBak[X]){
								CMat[Y+ Z*off1] = TraceBak[X];
								CMat[Z+off2] = TraceBak[X];
                        
							}
                        
						}
					}
				}
				
			}
		}
		else{
			for (Y = 0; Y < NextNo; Y++){
				off2 = Y*off1;
				for (Z = Y + 1; Z <= NextNo; Z++){
					if (AMat[Z+off2] == TraceBak[X]){
						CMat[Y+ Z*off1] = TraceBak[X];
						CMat[Z+off2] = TraceBak[X];
                
					}
				}
			}
		}
    
	}
	return(1);

}
int FAR pascal MakePairs(int Nextno, int Da, int Ma, int Mi, int WinPP, int *RNum, int *Rlist, int *DoPairs){
	int WinPPY, off1;
	for (WinPPY = 0; WinPPY <= RNum[WinPP]; WinPPY++){
        off1 =  Rlist[WinPP + WinPPY*3];       
		if (off1 == Da || off1 == Ma || off1 == Mi){ 
                        
			DoPairs[Mi + Ma*(Nextno+1)] = 1;
            DoPairs[Ma + Mi*(Nextno+1)] = 1;
                    
            DoPairs[Da + Ma*(Nextno+1)] = 1;
            DoPairs[Ma + Da*(Nextno+1)] = 1;
                   
            DoPairs[Mi + Da*(Nextno+1)] = 1;
            DoPairs[Da + Mi*(Nextno+1)] = 1;
                    
            break;
		}
		
	}
	return(WinPPY);
}
int FAR pascal FindOverlap(int lenseq, int BPos2, int EPos2,int *RSize, int *OLSeq){
	int Z;
	int OLSize = 0;
	if (BPos2 < EPos2) {
		RSize[1] = EPos2 - BPos2 + 1;
        for (Z = BPos2; Z<= EPos2; Z++)
			OLSize = OLSize + OLSeq[Z];
                                  
	}
	else{
		RSize[1] = EPos2 + lenseq - BPos2 + 1;
        for (Z = 1; Z <= EPos2; Z++)
			OLSize = OLSize + OLSeq[Z];
                                  
        for (Z = BPos2; Z <= lenseq; Z++)
			OLSize = OLSize + OLSeq[Z];
	
	}
	return (OLSize);
}

int FAR pascal FindNext(int StartPosX,int HighHomol,int MedHomol, int LowHomol, int LenXoverSeq, int xoverwindow, int *XOverHomologyNum)
{
	int X,off1,off2,off3;
	int limit = xoverwindow*2+1;
	
	//*(xoverhomologynum+1) = t1/limit;
	//*(xoverhomologynum+1+limit+lenxoverseq) = t2/limit;
	//*(xoverhomologynum+1+limit*2+lenxoverseq*2 ) = t3/limit;
	off1 = (MedHomol - 1)*LenXoverSeq + limit*(MedHomol - 1);
	off2 = (HighHomol - 1)*LenXoverSeq + limit*(HighHomol - 1);
	off3 = (LowHomol - 1)*LenXoverSeq+ limit*(LowHomol - 1);
	for (X = StartPosX; X <= LenXoverSeq; X++){
		
		if (XOverHomologyNum[X + off1] > XOverHomologyNum [X + off2]){
                if (XOverHomologyNum [X +off1] > XOverHomologyNum [X + off3])
					return X;
		}
				
	}
	return -1;
}

/*int FAR pascal FindSubSeqB(short int spacerflag,short int outlyer, short int xoverwindow,short int lenseq, short int nextno,short int seq1,short int seq2,short int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,short int *xoverseqnumw,short int *spacerseqs,short int *xdiffpos,short int *xposdiff)

//int FAR pascal FindSubSeq(short int lenseq,short int seq1,short int seq2,short int seq3, short int *seqnum, short int *xoverseqnum)

{ 
	
	short int y = 0;
	int g=0;
	
	if (spacerflag==1){
		for (int x = 1; x < lenseq; x++){
			
			if (*(seqnum + x + seq1*lenseq) != *(seqnum + x + seq2*lenseq) || *(seqnum + x + seq1*lenseq) != *(seqnum + x + seq3*lenseq) || *(seqnum + x + seq2*lenseq) != *(seqnum + x + seq3*lenseq)) {
				
				if (*(seqnum + x + seq1*lenseq) != *(seqnum + x + seq2*lenseq) && *(seqnum + x + seq1*lenseq) != *(seqnum + x + seq3*lenseq) && *(seqnum + x + seq2*lenseq) != *(seqnum + x + seq3*lenseq) ){
				 g=g+1;    
				}
				else {
					if (*(seqnum + x + seq1*lenseq) > 65  && *(seqnum + x + seq2*lenseq) > 65  && *(seqnum + x + seq3*lenseq) > 65){
                       
                        
						if (*(seqnum + x + seq1*lenseq)  != *(seqnum + x + seq2*lenseq)  && *(seqnum + x + seq1*lenseq)  != *(seqnum + x + seq3*lenseq)) {
								//If seq1 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										if (outlyer == seq1){
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
										if (*(seqnum + x + *(spacerseqs + z) * lenseq) == *(seqnum + x + (seq1 * lenseq)) && outlyer != seq1){
										//If difference is legitimate
                                        
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}	
									}
								}
								if (*(seqnum + x + seq2*lenseq)  != *(seqnum + x + seq1*lenseq)  && *(seqnum + x + seq2*lenseq)  != *(seqnum + x + seq3*lenseq)) {
								//If seq2 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										if (outlyer == seq2){
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
										if (*(seqnum + x + seq2*lenseq) == *(seqnum + x + *(spacerseqs+z)*lenseq) && outlyer != seq2){
										//If difference is legitimate
                                        
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
									}
								}
								if (*(seqnum + x + seq3*lenseq)  != *(seqnum + x + seq1*lenseq)  && *(seqnum + x + seq3*lenseq)  != *(seqnum + x + seq2*lenseq)) {
								//If seq3 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										if (outlyer == seq3){
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
										if (*(seqnum + x + seq3*lenseq) == *(seqnum + x + *(spacerseqs+z)*lenseq)&& outlyer != seq3){
                                   
										//If difference is legitimate
                                       
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
									}
							
                            
						}
					}    
				}
			}
		}
		for (short int b = 1; b<= xoverwindow;b++){
			*(xoverseqnumw + b ) = *(xoverseqnum + y - xoverwindow + b);
			*(xoverseqnumw + b + lenseq + xoverwindow*2) = *(xoverseqnum + y - xoverwindow + b + lenseq);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 1)
			*(xoverseqnumw + b + lenseq*2 + xoverwindow*4) = *(xoverseqnum + y - xoverwindow + b + lenseq*2);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 2)
                                        
			*(xoverseqnumw + y + xoverwindow + b ) = *(xoverseqnum + b);//XOverSeqNum(X, 0)
			*(xoverseqnumw + y + xoverwindow + b  + lenseq + xoverwindow*2) = *(xoverseqnum + b + lenseq);
			*(xoverseqnumw + y + xoverwindow + b  + lenseq*2 + xoverwindow*4) = *(xoverseqnum + b + lenseq*2);
        
			

		}
	}
	if (spacerflag>1){
		for (int x = 1; x < lenseq; x++){
			
			if (*(seqnum + x + seq1*lenseq) != *(seqnum + x + seq2*lenseq) || *(seqnum + x + seq1*lenseq) != *(seqnum + x + seq3*lenseq) || *(seqnum + x + seq2*lenseq) != *(seqnum + x + seq3*lenseq)) {
				
				if (*(seqnum + x + seq1*lenseq) != *(seqnum + x + seq2*lenseq) && *(seqnum + x + seq1*lenseq) != *(seqnum + x + seq3*lenseq) && *(seqnum + x + seq2*lenseq) != *(seqnum + x + seq3*lenseq) ){
				 g=g+1;    
				}
				else {
					if (*(seqnum + x + seq1*lenseq) > 65  && *(seqnum + x + seq2*lenseq) > 65  && *(seqnum + x + seq3*lenseq) > 65){
                       
                        
						if (*(seqnum + x + seq1*lenseq)  != *(seqnum + x + seq2*lenseq)  && *(seqnum + x + seq1*lenseq)  != *(seqnum + x + seq3*lenseq)) {
								//If seq1 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										
										if (*(seqnum + x + *(spacerseqs + z) * lenseq) == *(seqnum + x + (seq1 * lenseq))){
										//If difference is legitimate
                                        
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}	
									}
								}
								if (*(seqnum + x + seq2*lenseq)  != *(seqnum + x + seq1*lenseq)  && *(seqnum + x + seq2*lenseq)  != *(seqnum + x + seq3*lenseq)) {
								//If seq2 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										
										if (*(seqnum + x + seq2*lenseq) == *(seqnum + x + *(spacerseqs+z)*lenseq)){
										//If difference is legitimate
                                        
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
									}
								}
								if (*(seqnum + x + seq3*lenseq)  != *(seqnum + x + seq1*lenseq)  && *(seqnum + x + seq3*lenseq)  != *(seqnum + x + seq2*lenseq)) {
								//If seq3 is odd one
									for (short int z = 1; z <= spacerno; z++){ 
										
										if (*(seqnum + x + seq3*lenseq) == *(seqnum + x + *(spacerseqs+z)*lenseq)){
                                   
										//If difference is legitimate
                                       
											y = y + 1;
											*(xoverseqnum + y) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnum + y + lenseq) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnum + y + lenseq*2) = *(seqnum + x + seq3*lenseq);
                                        
											*(xoverseqnumw + y + xoverwindow) = *(seqnum + x + seq1*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq + xoverwindow*2) = *(seqnum + x + seq2*lenseq);
											*(xoverseqnumw + y + xoverwindow + lenseq*2 + xoverwindow*4) = *(seqnum + x + seq3*lenseq);
                                        
                                        
											*(xdiffpos + y) = x;
											*(xposdiff + x) = y;
											z = spacerno;
										}
									}
							
                            
						}
					}    
				}
			}
		}
		for (short int b = 1; b<= xoverwindow;b++){
			*(xoverseqnumw + b ) = *(xoverseqnum + y - xoverwindow + b);
			*(xoverseqnumw + b + lenseq + xoverwindow*2) = *(xoverseqnum + y - xoverwindow + b + lenseq);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 1)
			*(xoverseqnumw + b + lenseq*2 + xoverwindow*4) = *(xoverseqnum + y - xoverwindow + b + lenseq*2);//XOverSeqNum(LenXOverSeq - XOverWindow + X, 2)
                                        
			*(xoverseqnumw + y + xoverwindow + b ) = *(xoverseqnum + b);//XOverSeqNum(X, 0)
			*(xoverseqnumw + y + xoverwindow + b  + lenseq + xoverwindow*2) = *(xoverseqnum + b + lenseq);
			*(xoverseqnumw + y + xoverwindow + b  + lenseq*2 + xoverwindow*4) = *(xoverseqnum + b + lenseq*2);
        
			

		}

	
	}
	//outlyer=50;
	return(y);
}*/


int FAR pascal XOHomology(short int inlyer, int lenstrainseq,int lenxoverseq,short int xoverwindow, char *xoverseqnumw, int *xoverhomologynum)
{
	int limit = xoverwindow*2+1;
	int limit2 = limit*2;
	int lenstrainseq2, xoverwindow2, xoverwindow4, lenxoverseq2, ll1, ll2, off3, off4;
	int g = 0;
	int  y,z, x, off1, off2, h, of1,of2, of3,  t1, t2, t3;
	
	
	
	
    lenstrainseq2 = lenstrainseq*2;
	xoverwindow2 = xoverwindow*2;
	xoverwindow4=xoverwindow*4;
	lenxoverseq2 = lenxoverseq*2;

	off1 = lenstrainseq + xoverwindow2;
	off2 = lenstrainseq2 + xoverwindow4;
	
	t1 = 0;
	t2 = 0;
	t3 = 0;

	
	for(z = 1;z <= limit;z++){
		t1 += *(xoverseqnumw + z);
		t2 += *(xoverseqnumw + z + off1);
		t3 += *(xoverseqnumw + z + off2);
		/*if(n1 == n2) 
			t1++;
		else if(n1 == n3) 
			t2++;
		else if(n2 == n3){    
		       t3++;
		}*/
	}

	

	ll1 = lenxoverseq+limit;
	ll2 = lenxoverseq2+limit2;

	*(xoverhomologynum+1) = t1;
	*(xoverhomologynum+1+ll1) = t2;
	*(xoverhomologynum+1+ll2) = t3;
	
	
	off3 = off1+xoverwindow2;
	off4 = off2+xoverwindow2;
	
	off1--;
	off2--;
	
	
	for (y = 0; y < 3; y++){
		if (y == 0){
			h=t1;
			of1= -1;
			of2 = xoverwindow2;
			of3 = 0;
		}
		else if (y==1){
			h=t2;
			of1 = off1;
			of2 = off3;
			of3 =ll1;
		}
		else{
			h=t3;
			of1 = off2;
			of2 = off4;
			of3 = ll2;
		}
		
		for(x = 2;x <= lenxoverseq+1;x++){
			//if (xoverseqnumw[x + of1])
			//	h--;
			//if (xoverseqnumw[x + of2])
			//	h++;
			h = h - xoverseqnumw[x + of1] + xoverseqnumw[x + of2];
			xoverhomologynum[x + of3] = h ;
		}
		
	}

	

	
    
    
	return(1);
}


int FAR pascal XOHomologyB(int seq1, int seq2, int seq3, short int inlyer, int lenseq,int lenxoverseq,short int xoverwindow, double *xoverhomologynum, short int *seqnum,double *avhomol, int *xdiffpos)
{
	//speedup idea = doing same thing I'm doing for maxchi - ie doesn't
	//require any checks etc of whether or not things are equil - maybe 
	//even doing them both together
	
	short int limit = xoverwindow*2+1;
	short int g = 0;
	short int n1, n2, n3;
	double ah1,ah2,ah3,t1,t2,t3;
	int x,goon, lo, ro,s1,s2,s3;
	ah1 = 0;
	ah2 = 0;
	ah3 = 0;

	t1 = 0;
	t2 = 0;
	t3 = 0;

	goon = 0;
	
	s1 = seq1*lenseq;
	s2 = seq2*lenseq;
	s3 = seq3*lenseq;

	//short int num0 = 0;
	//short int num1 = 0;
	//short int num2 = 0;

	for(short int z = -xoverwindow+1;z <= xoverwindow + 1;z++){
		if (z < 1){
			
			n1 = *(seqnum + xdiffpos[lenxoverseq + z] + seq1*lenseq);
			n2 = *(seqnum + xdiffpos[lenxoverseq + z] + seq2*lenseq);
			n3 = *(seqnum + xdiffpos[lenxoverseq + z] + seq3*lenseq);
		}
		else{
			n1 = *(seqnum + xdiffpos[z] + seq1*lenseq);
			n2 = *(seqnum + xdiffpos[z] + seq2*lenseq);
			n3 = *(seqnum + xdiffpos[z] + seq3*lenseq);
		}


		if( n1 == n2) 
		        t1++;
		else if( n1 == n3) 
		        t2++;
		else if( n2 == n3)    
		       t3++;
		
	}

	if (inlyer == 1){
		if (t2 > t1 || t3>t1)
			goon = 1;
	}
	else if (inlyer == 2){
		if (t1 > t2 || t3>t2)
			goon = 1;
	}
	else if (inlyer == 3){
		if (t2 > t3 || t1>t3)
			goon = 1;
	}

	*(xoverhomologynum+1) = t1;
	*(xoverhomologynum+1+limit+lenxoverseq) = t2;
	*(xoverhomologynum+1+limit*2+lenxoverseq*2 ) = t3;
	
	ah1 =  t1;
	ah2 =  t2;
	ah3 =  t3;
	
	//bit overlapping the left end
	for(x =  2;x <=  xoverwindow+1;x++){
		lo = x-xoverwindow-1+lenxoverseq;
		ro = x+xoverwindow;
		
		if(*(seqnum + xdiffpos[lo] + s1) == *(seqnum + xdiffpos[lo] + s2))
			t1--;

		else if(*(seqnum + xdiffpos[lo] + s1) == *(seqnum + xdiffpos[lo] + s3)) 
			t2--;

		else  
			t3--;
		
		
		if( *(seqnum + xdiffpos[ro] + s1) == *(seqnum + xdiffpos[ro]+ s2))
			t1++;

		else if( *(seqnum + xdiffpos[ro] + s1) == *(seqnum + xdiffpos[ro] +  s3)) 
			t2++;
			
		else  
			t3++;
		
		if (goon == 0){
			if (inlyer == 1){
				if (t2 > t1 || t3>t1)
					goon = x;
			}
			else if (inlyer == 2){
				if (t1 > t2 || t3>t2)
					goon = x;
			}
			else {
				if (t2 > t3 || t1>t3)
					goon = x;
			}
		}

		*(xoverhomologynum+x) = t1 ;
		*(xoverhomologynum+x+lenxoverseq+limit)= t2;
		*(xoverhomologynum+x+lenxoverseq*2+limit*2) =t3;
		
		ah1+= t1;
		ah2+= t2;
		ah3+= t3;
       
	}
	
	//bit in middle
	for(x =  xoverwindow+2;x <=  lenxoverseq - xoverwindow;x++){
		lo = x-xoverwindow-1;
		ro = x+xoverwindow;
		
		if(*(seqnum + xdiffpos[lo] + s1) == *(seqnum + xdiffpos[lo] + s2))
			t1--;

		else if(*(seqnum + xdiffpos[lo] + s1) == *(seqnum + xdiffpos[lo] + s3)) 
			t2--;

		else  
			t3--;
		
		
		if( *(seqnum + xdiffpos[ro] + s1) == *(seqnum + xdiffpos[ro]+ s2))
			t1++;

		else if( *(seqnum + xdiffpos[ro] + s1) == *(seqnum + xdiffpos[ro] +  s3)) 
			t2++;
			
		else  
			t3++;
		
		if (goon == 0){
			if (inlyer == 1){
				if (t2 > t1 || t3>t1)
					goon = x;
			}
			else if (inlyer == 2){
				if (t1 > t2 || t3>t2)
					goon = x;
			}
			else {
				if (t2 > t3 || t1>t3)
					goon = x;
			}
		}

		*(xoverhomologynum+x) = t1 ;
		*(xoverhomologynum+x+lenxoverseq+limit)= t2;
		*(xoverhomologynum+x+lenxoverseq*2+limit*2) =t3;
		
		ah1+= t1;
		ah2+= t2;
		ah3+= t3;
       
	}

//bit at end

	for(x = lenxoverseq - xoverwindow+1;x <=  lenxoverseq + xoverwindow;x++){
		lo = x-xoverwindow;
		ro = x+xoverwindow - lenxoverseq;
		
		if(*(seqnum + xdiffpos[lo] + s1) == *(seqnum + xdiffpos[lo] + s2))
			t1--;

		else if(*(seqnum + xdiffpos[lo] + s1) == *(seqnum + xdiffpos[lo] + s3)) 
			t2--;

		else  
			t3--;
		
		
		if( *(seqnum + xdiffpos[ro] + s1) == *(seqnum + xdiffpos[ro]+ s2))
			t1++;

		else if( *(seqnum + xdiffpos[ro] + s1) == *(seqnum + xdiffpos[ro] +  s3)) 
			t2++;
			
		else  
			t3++;
		
		if (goon == 0){
			if (inlyer == 1){
				if (t2 > t1 || t3>t1)
					goon = x;
			}
			else if (inlyer == 2){
				if (t1 > t2 || t3>t2)
					goon = x;
			}
			else {
				if (t2 > t3 || t1>t3)
					goon = x;
			}
		}

		*(xoverhomologynum+x) = t1 ;
		*(xoverhomologynum+x+lenxoverseq+limit)= t2;
		*(xoverhomologynum+x+lenxoverseq*2+limit*2) =t3;
		
		ah1+= t1;
		ah2+= t2;
		ah3+= t3;
       
	}

	*(avhomol+1) = ah1/lenxoverseq/limit;
    *(avhomol+2) = ah2/lenxoverseq/limit;
    *(avhomol+3) = ah3/lenxoverseq/limit;
    
    
	return(goon);
}

/*int FAR pascal XOHomology(int lenstrainseq,int lenxoverseq,short int xoverwindow, short int *xoverseqnumw, double *xoverhomologynum,double *avhomol)
{
	short int limit = xoverwindow*2+1;
	short int g = 0;
	short int n1, n2, n3;
	double t1,t2,t3;
	t1 = 0;
	t2 = 0;
	t3 = 0;
	//short int num0 = 0;
	//short int num1 = 0;
	//short int num2 = 0;

	for(short int z = 1;z <= limit;z++){
		n1 = *(xoverseqnumw + z);
		n2 = *(xoverseqnumw + z + lenstrainseq + xoverwindow*2);
		n3 = *(xoverseqnumw + z + lenstrainseq*2 + xoverwindow*4);
		if( n1 == n2) 
		        t1++;
	//			num0++;
		if( n1 == n3) 
		        t2++;
	//			num1++;
		if( n2 == n3){    
		       t3++;
	//		   num2 = *(xoverseqnumw + lenxoverseq +  limit + z );
		}
	}
	*(xoverhomologynum+1) = t1/limit;
	*(xoverhomologynum+1+limit+lenxoverseq) = t2/limit;
	*(xoverhomologynum+1+limit*2+lenxoverseq*2 ) = t3/limit;
	
	*(avhomol+1) =  *(xoverhomologynum+1);
	*(avhomol+2) =  *(xoverhomologynum+1+lenxoverseq+limit);
	*(avhomol+3) =  *(xoverhomologynum+1+lenxoverseq*2+limit*2);

	for(int x = 2;x <= lenxoverseq+1;x++){
		*(xoverhomologynum+x) = *(xoverhomologynum+x-1) *limit;
		*(xoverhomologynum+x+lenxoverseq+limit)= *(xoverhomologynum+x-1+lenxoverseq+limit)*limit;
		*(xoverhomologynum+x+lenxoverseq*2+limit*2) =*(xoverhomologynum+x-1+lenxoverseq*2+limit*2)*limit;
	
		if( *(xoverseqnumw + x-1) == *(xoverseqnumw + x-1 + lenstrainseq + xoverwindow*2)){ 
		    *(xoverhomologynum+x) = *(xoverhomologynum+x)-1;
		}
		if( *(xoverseqnumw + x-1) == *(xoverseqnumw + x-1 + lenstrainseq*2 + xoverwindow*4)){ 
		    *(xoverhomologynum+x+lenxoverseq+limit) = *(xoverhomologynum+x+lenxoverseq+limit) - 1;
		}
		if( *(xoverseqnumw + x-1 + lenstrainseq + xoverwindow*2) == *(xoverseqnumw + x-1 + lenstrainseq*2 + xoverwindow*4)){    
		       *(xoverhomologynum+x+lenxoverseq*2+limit*2) = *(xoverhomologynum+x+lenxoverseq*2+limit*2) - 1;
		}


	
		if( *(xoverseqnumw + x+xoverwindow*2) == *(xoverseqnumw + x+xoverwindow*2 + lenstrainseq + xoverwindow*2)){ 
            *(xoverhomologynum+x) = *(xoverhomologynum+x)+1;
		}
		if( *(xoverseqnumw +x+xoverwindow*2) == *(xoverseqnumw + x+xoverwindow*2 + lenstrainseq*2 + xoverwindow*4)){ 
            *(xoverhomologynum+x+lenxoverseq+limit) = *(xoverhomologynum+x+lenxoverseq+limit) + 1;
		}	
		if( *(xoverseqnumw + x+xoverwindow*2 + lenstrainseq + xoverwindow*2) == *(xoverseqnumw + x+xoverwindow*2 + lenstrainseq*2 + xoverwindow*4)){   
		    *(xoverhomologynum+x+lenxoverseq*2+limit*2) = *(xoverhomologynum+x+lenxoverseq*2+limit*2) + 1;
		}

		*(xoverhomologynum+x) = *(xoverhomologynum+x) /limit;
		*(xoverhomologynum+x+lenxoverseq+limit)= *(xoverhomologynum+x+lenxoverseq+limit)/limit;
		*(xoverhomologynum+x+lenxoverseq*2+limit*2) =*(xoverhomologynum+x+lenxoverseq*2+limit*2)/limit;
		
		*(avhomol+1) = *(avhomol+1) + *(xoverhomologynum+x);
		*(avhomol+2) = *(avhomol+2) + *(xoverhomologynum+x+lenxoverseq+limit);
		*(avhomol+3) = *(avhomol+3) + *(xoverhomologynum+x+lenxoverseq*2+limit*2);
       
	}
	*(avhomol+1) = *(avhomol+1)/lenxoverseq;
    *(avhomol+2) = *(avhomol+2)/lenxoverseq;
    *(avhomol+3) = *(avhomol+3)/lenxoverseq;
    
    
	return(1);
}*/


int FAR pascal MakeTMatch(int WinPP, int *CompMat, int *TMatchX, int *RNum, int *FoundOne, int *SQ, int *Rlist, int *FOX, int *CSeq, double *tMatch, int *invlist){
	//rlist -2,nextno
	//tmatchx - 1,1
	//compmat - 2,1
	int GoOn = 0;
	int Z, A, B, tWinPP, hold, hMatch;
	A=0;
	
	tMatch[0] = 0;
	for (Z = 0; Z < 3; Z++){
		for (A = 0; A <= RNum[WinPP]; A++){
			//if (invlist[WinPP + A*3] == 0){
				if (FoundOne[A] == 0){
					if (FOX[A] == 0){
						if (SQ[Z] == Rlist[WinPP + A*3]){
							GoOn = 1;
							break;
						}
					}
				}
			//}
		}
		if (GoOn == 1)
			break;
	}
	if (GoOn == 1){
		FOX[A] = 1;
        
        //CSeq[0] = Rlist[WinPP + A*3];
        
        //ie an event involving a recombinant sequence is found.
        if (FoundOne[A] == 0){
			CSeq[1] = A;
			tWinPP = Z;
			for (A = 0; A < 2; A++){
				
				hold = RNum[CompMat[WinPP + A*3]] +1;
				//How well do the parents overlap?

                for (Z = 0; Z < 2; Z++){
					for (B = 0; B < hold; B++){
						if (invlist[CompMat[WinPP + A*3] + B*3] == 0){
							if (Rlist[CompMat[WinPP + A*3] + B*3] == SQ[CompMat[tWinPP + Z*3]])
								TMatchX[A + Z*2] = 1;
						}
                    }
                }
			}
                              
            hMatch = 0;
            for (A = 0; A < 2; A++){
				if (TMatchX[A] + TMatchX[A + 2] > 0){ 
					if(TMatchX[A*2] + TMatchX[1 + A*2] > 0)
						hMatch++;
				}
                
            }
            
            tMatch[0] = hMatch+1;
			
		}
	}
	
	return(1);
}



int FAR pascal GetColPix(int CurScale, float MR, int Y, HDC Pict, float PosS0, float PosS1, float XAddj, int PosE, int StSX, int X, int UBRM, int UBHM, float Min, float *RegionMat, int *ColPix, int *HeatMap)
{
	int os, os2, os3, Z;
	float RM, h3;

	os = UBRM+1;
	os2 = UBHM+1;
	os3 = 1020*os2;
	Z = X + StSX;
    RM = RegionMat[X + Y*os];
    do {
        if (RegionMat[Z + Y*os] != RM)
			
			break;

		

        Z = Z + StSX;
		if (Z > PosE)
			break;
		
    } while (Z <= PosE);
    
	Z=Z-StSX;
    
    if (RM >= Min){ 
		h3 =(RM - Min) / MR;
        if (h3 < 1)
            *ColPix = HeatMap[CurScale + (int)(h3 * 1020)*os2];
        else
            *ColPix = HeatMap[CurScale + os3];
        
	}
    else
        *ColPix = 8421504;//RGB(128, 128, 128)
    
	
	if (Z == X)
		SetPixelV (Pict, (int)((X - PosS0) * XAddj), (int)((Y - PosS1) * XAddj),*ColPix);

	return(Z);
}




int FAR pascal GetColPix2(float Band, int *XDP, int *ZDP, int CurScale, float MR, int Y, HDC Pict, float PosS0, float PosS1, float XAddj, int PosE, int StSX, int X, int UBRM, int UBHM, float Min, float *RegionMat, int *ColPix, int *HeatMap)
{
	int os, os2, os3, Z;
	float RM, h3, ZD, XD;

	os = UBRM+1;
	os2 = UBHM+1;
	os3 = 1020*os2;
	Z = X + StSX;
    RM = RegionMat[X + Y*os];
    do {
        if (RegionMat[Z + Y*os] != RM)
			
			break;

		

        Z = Z + StSX;
		if (Z > PosE)
			break;
		
    } while (Z <= PosE);
    
	Z=Z-StSX;
    
	ZD=(float)(Z+0.5);
	XD=(float)(X-0.5);
	*XDP = (int)((XD-PosS0)*XAddj+Band);
	*ZDP = (int)((ZD-PosS0)*XAddj+Band+1);
    if (RM >= Min){ 
		if (RM > MR)
			RM=MR;
		h3 =(RM - Min) / MR;
        if (h3 < 1)
            *ColPix = HeatMap[CurScale + (int)(h3 * 1020)*os2];
        else
            *ColPix = HeatMap[CurScale + os3];
        
	}
    else
        *ColPix = 8421504;//RGB(128, 128, 128)
    
	
	//if (Z == X)
	//	SetPixelV (Pict, (int)((X - PosS0) * XAddj), (int)((Y - PosS1) * XAddj),*ColPix);

	return(Z);
}

double FAR pascal ProbCalc(double *fact, int xoverlength,int numincommon,double indprob,int lenxoverseq)
{
	int z, target;
	long double nfactorial;
	long double mfactorial;
	long double nmfactorial, hold, hold2;
	
	double probability = 0;
	double td1,td2,prob=0;
	td1 = (double)(xoverlength);
	td2 = (double)(lenxoverseq);
    //addjustfactor = 1;
	
    nfactorial = (long double)(fact[xoverlength]);
    //for(y=1; y<=xoverlength;y++){
	//	nfactorial = nfactorial * y;
	//}                 
	for (z = numincommon; z<=xoverlength;z++){
		target = xoverlength - z;
        
        mfactorial = (long double) (fact[z]);
		//for (y = 2; y <= z;y++){
        //    mfactorial = mfactorial * y;
        //}
        nmfactorial = (long double)(fact[target]);                      
        //for (a = 2; a <= target;a++){
		//	nmfactorial = nmfactorial * a;
		//}
		
		hold =  mfactorial* nmfactorial;
		hold2 = nfactorial / hold;
        probability = probability +  pow(indprob, z) * pow((1 - indprob),(xoverlength - z)) * hold2;
                        
	}
	//td2 = td2/td1;
	probability = probability * td2 /td1;

	/*if (1 - probability == 1) {
        if (probability < 1) 
			probability = probability * (lenxoverseq / xoverlength);
    
	}
	else{
        if (probability < 0)
            probability = -1;
        else if (probability < 1){
			td1 = lenxoverseq / xoverlength;
			td2 = 1 - probability;
            probability = 1 - pow(td1,td2);//((1 - probability) ^ ((lenxoverseq / xoverlength)));
        
		}
	}*/


    //if (probability < 1){
	//	if 1-probability >
	//	probability = 1 - pow((1 - probability),(lenxoverseq / xoverlength));
    //                
	//}
	//else{
	//	probability=1;
	//}
	//if (probability < 0.000000000000001){
	//	probability = 0;
	//}
		
	return (probability);
}


float FAR pascal FindMaxNS(int RSize,  float *RegionMat){
	float MaxN;
	int X, Y;
	
	MaxN = 0;
	
	for (X = 0; X<= RSize; X++){
		for (Y = X + 1; Y <= RSize; Y++){
			if (RegionMat[X +  Y*(RSize+2)] > MaxN)
				MaxN = RegionMat[X +  Y*(RSize+2)];
		}
	}

	return(MaxN);
}

double FAR pascal FindMaxN(int RSize,  double *RegionMat){
	double MaxN;
	int X, Y;
	
	MaxN = 0;
	
	for (X = 0; X<= RSize; X++){
		for (Y = X + 1; Y <= RSize; Y++){
			if (RegionMat[X +  Y*(RSize+2)] > MaxN)
				MaxN = RegionMat[X +  Y*(RSize+2)];
		}
	}

	return(MaxN);
}


int FAR pascal MakeHeatPlot (double MaxN, int UBHM, int CS,HDC pict,int RSize, double XAddj, int *HeatMap, double *RegionMat){
	int X,Y, off1;
	
	
	off1 = (UBHM+1) ;
	
	

	for (X = 1; X<=RSize; X++){
		for (Y = X; Y<=RSize; Y++){
			SetPixelV (pict, (int)(X * XAddj), (int)(Y * XAddj), HeatMap[CS+(int)(((RegionMat[X + Y*(RSize+2)]) / MaxN) * 1020)*off1]);
            SetPixelV (pict, (int)(Y * XAddj), (int)(X * XAddj), HeatMap[CS+(int)(((RegionMat[Y + X*(RSize+2)]) / MaxN) * 1020)*off1]);
		//	SetPixelV (pict, X, Y, HeatMap((int)((RegionMat[Y + X*(RSize+2)] / MaxN) * 1020)))
		}
            
	}

	off1=(int)(MaxN);
	return(off1);
}




int FAR pascal OptLeftBPMC(int LO, double HiLeft, int TopL, int MaxX, int MaxY, int WinWin, int LenXOverSeq, int LS, char *Scores, char *MDMap){

	int Z, X, P, M, n, CurWin, CurWinPos, Failcount, outthing;//, IH;
	double A,C,B,D,thMChi, E, G;
	//scores -lseq,2
	G = 0;
    for (X = LO - WinWin; X <= LO - 1; X++){
		if (X < 1 )
			G = G + Scores[LenXOverSeq + X + MaxY*(LS+1)];
		else if (X > LenXOverSeq)
			G = G + Scores[X - LenXOverSeq + MaxY*(LS+1)];
		else
            G = G + Scores[X+ MaxY*(LS+1)];
                      
	}
	//IH=E;
	//return (IH);
    P = MaxX - 1;
    M = LO - 1;
    n = LO - WinWin;
                    
    if (P < 1)
		P = LenXOverSeq + P;
                    
    if (n < 1)
		n = LenXOverSeq + n;

    if (M < 1)
		M = LenXOverSeq + M;
                    
    A = (double)(G);
    C = (double)(TopL);
    CurWin = (int)(HiLeft*10000);
    CurWinPos = M;
    Failcount = 0;
	Z=5;
    while(Z==5){
                        
		A = A - Scores[M + MaxY*(LS+1)];
        C = C - Scores[P + MaxY*(LS+1)];
        C = C + Scores[M + MaxY*(LS+1)];
        P = P - 1;
        n = n - 1;
        M = M - 1;
        if (MDMap[P] == 1 || MDMap[n] == 1 || MDMap[M] == 1)
			break;
                        
		if (P < 1)
			P = LenXOverSeq;
                        
		if (n < 1)
			n = LenXOverSeq;
                        
		if (M < 1)
			M = LenXOverSeq;
                        
        if (MDMap[P] == 1 || MDMap[n] == 1 || MDMap[M] == 1)
			break;
                        
		A = A + Scores[n + MaxY*(LS+1)];
		B = WinWin - A;
		D = WinWin - C;
		if (A + C > 0 && B + D > 0){
			E = A * D - B * C;
			thMChi = E * E * 2;
			E = (A + C) * (B + D);
			E = E * WinWin;
                            
			thMChi = thMChi / E;
			if (thMChi < 0)
				thMChi = fabs(thMChi);
            if ((int)(thMChi*10000) > CurWin){
				CurWin = (int)(thMChi*10000);
				CurWinPos = M;
				Failcount = 0;
			}
			else{
				Failcount = Failcount + 1;
				if (Failcount > WinWin / 10)
					break;
                               
			}
		}
                
	}

	outthing=CurWinPos;
    outthing++;
	return(outthing);
}


int FAR pascal OptRightBPMC(int RO, double HiRight, int TopR, int MaxX, int MaxY, int WinWin, int LenXOverSeq, int LS, char *Scores, char *MDMap){

	int X, P, M, n, CurWin, CurWinPos, Failcount, outthing, Z;//, IH;
	double A,C,B,D,thMChi, E, G;
	//scores -lseq,2
	G = 0;
    for (X = RO +1; X <= RO +WinWin; X++){
		if (X < 1 )
			G = G + Scores[LenXOverSeq + X + MaxY*(LS+1)];
		else if (X > LenXOverSeq)
			G = G + Scores[X - LenXOverSeq + MaxY*(LS+1)];
		else
            G = G + Scores[X+ MaxY*(LS+1)];
                      
	}
	//IH=E;
	//return (IH);
    P = RO+WinWin;
    M = RO + 1;
    n = MaxX;//LO - WinWin;
    Z=5;                
    if (P > LenXOverSeq)
        P = P - LenXOverSeq;
    
    if (n > LenXOverSeq)
        n = n - LenXOverSeq;
    
    if (M > LenXOverSeq)
        M = M - LenXOverSeq;
    
                    
    A = (double)(TopR);
    C = (double)(G);
	
    CurWin = (int)(HiRight*10000);
    CurWinPos = M;
    Failcount = 0;
    while(Z==5){
                        
		A = A - Scores[n + MaxY*(LS+1)];
        C = C - Scores[M + MaxY*(LS+1)];
        A = A + Scores[M + MaxY*(LS+1)];
        P = P + 1;
        n = n + 1;
        M = M + 1;
        
		if (MDMap[P] == 1 || MDMap[n] == 1 || MDMap[M] == 1)
			break;
                        
		if (P > LenXOverSeq)
			P = 1;
                        
		if (n > LenXOverSeq)
			n = 1;
                        
		if (M > LenXOverSeq)
			M = 1;

		
                        
        if (MDMap[P] == 1 || MDMap[n] == 1 || MDMap[M] == 1)
			break;
                        
		C = C + Scores[P + MaxY*(LS+1)];
		B = WinWin - A;
		D = WinWin - C;
		if (A + C > 0 && B + D > 0){
			E = A * D - B * C;
			thMChi = E * E * 2;
			E = (A + C) * (B + D);
			E = E * WinWin;
                            
			thMChi = thMChi / E;
			if (thMChi < 0)
				thMChi = fabs(thMChi);
            if ((int)(thMChi*10000) > CurWin){
				CurWin = (int)(thMChi*10000);
				CurWinPos = M;
				Failcount = 0;
			}
			else{
				Failcount = Failcount + 1;
				if (Failcount > WinWin / 10)
					break;
                               
			}
		}
                
	}

	outthing=CurWinPos-1;
    
	return(outthing);
}

int FAR pascal CheckMissingData(int Seq1, int Seq2, int Seq3, int XB, int XE, int LS, unsigned char *MissingData){
	int zz, off1, off2, off3;
	off1=(LS+1)*Seq1;
	off2=(LS+1)*Seq2;
	off3=(LS+1)*Seq3;
	if (XB < XE){
        for (zz = XB; zz <= XE; zz++){
            if (MissingData[zz + off1] == 1 || MissingData[zz + off2] == 1 || MissingData[zz + off3] == 1)
                return(0);

        }
	}
    else{
        for (zz = 1; zz <= XE; zz++){
            if (MissingData[zz + off1] == 1 || MissingData[zz + off2] == 1 || MissingData[zz + off3] == 1)
                return(0);
        }
        for (zz = XB; zz <= LS; zz++){
            if (MissingData[zz + off1] == 1 || MissingData[zz + off2] == 1 || MissingData[zz + off3] == 1)
                return(0);
        }
    }


	return(1);
}



int FAR pascal MakeImageData(int bkr, int bkg, int bkb,int SX,int SY, int PosE1, int PosE0, int PosS1, int PosS0, int StS, int StSX, int CurScale, float XAD, float Min, float MR, int UBID1, int UBID2, int UBID3, int UBRM1, int UBHM1, int *HeatMap, float *RegionMat, unsigned char *ImageData){

	int Y, X, YP, XP, R, G, B, N, M,Band, os1, os2, os3, os4, os5, os6, os7, H3, ColPix;
	float  RM, H2;
	unsigned char Rx, Gx, Bx;

	os1 = UBRM1+1;
	os3 = UBHM1+1;
	os4 = UBID1+1;
	os5 = UBID2+1;
	if (XAD>1)
		Band = (int)(XAD/1 +1 +1);
	else 
		Band = 0;
	//Band=5;
	for (Y = SY;  Y <= PosE1; Y+=StS){
		YP = (int)((Y - PosS1) * XAD);
		
        if (YP <= UBID3 && YP >=0){
			os2 = os1*Y;
			os6 = YP*os4*os5;
            for (X = SX; X <= PosE0; X+=StSX){
                XP = (int)((X - PosS0) * XAD);
                if (XP <= UBID2 && XP >=0){
                    //'Z = GetColPix(CurScale, MR, Y, Pict, PosS(0), PosS(1), XAD, PosE(0), StSX, X, UBound(RegionMat, 1), UBound(HeatMap, 1), Min, RegionMat(0, 0), ColPix, HeatMap(0, 0))
                    RM = RegionMat[X + os2];
                    if (RM >= Min){
                        H2 = (RM - Min) / MR;
                        
						if (H2 <= 1)
                            H3 = (int)(H2 * 1020);
                        else
                            H3 = 1020;
                        
                        ColPix = HeatMap[CurScale + H3*os3];
                        R = (ColPix / 65536);
                        G = ((ColPix - R * 65536) / 256);
                        B = (ColPix - R * 65536 - G * 256);
						Rx=(unsigned char)(R);
						Gx=(unsigned char)(G);
						Bx=(unsigned char)(B);


					}
                    else{
                        Rx = bkr;
                        Gx = bkg;
                        Bx = bkb;
					}
					if (Band == 0){
						os7 = XP*os4 + os6;
						ImageData[os7] = Rx;
						ImageData[1 + os7] = Gx;
						ImageData[2 + os7] = Bx;
					}
					else{
						for (M= YP-Band; M <= YP+Band; M++){
							if (M <= UBID3 && M >=0){
								os6 = M*os4*os5;

								for (N= XP-Band; N <= XP+Band; N++){
									if (N <= UBID2 && N >=0){
										os7 = N*os4 + os6;
										ImageData[os7] = Rx;
										ImageData[1 + os7] = Gx;
										ImageData[2 + os7] = Bx;
									}
								}
							}

						}


					}

                    
                }
            }
        }
	}



	return(1);
}


int FAR pascal MakeMatrixRRX(int RSize, int UBRRX, int UBRRP, float MaxN, float cov1, float cov2,float *MatrixRRP, float *MatrixRRX){
	int X, Y, osx, osp, osp2;
	osx = UBRRX+1;
	osp = UBRRP+1;
	osp2 = osp*osp;
	for (X = 1; X <= RSize; X++){
        for (Y = 1; Y <= RSize; Y++){
            if (X != Y){ 
                if (MatrixRRP[X + Y*osp] > cov2 && MatrixRRP[X + Y*osp + osp2] > cov2 )
                    MatrixRRX[X+ Y*osx] = -1;
                else if (MatrixRRP[X + Y*osp]  <= cov1)
                    MatrixRRX[X+ Y*osx] = MaxN;
                else if (MatrixRRP[X + Y*osp]  <= cov2)
                    MatrixRRX[X+ Y*osx] = (int)((MaxN * 0.95) - 1);
                else if (MatrixRRP[X + Y*osp + osp2]  <= cov1)
                    MatrixRRX[X+ Y*osx] = 0;
                else if (MatrixRRP[X + Y*osp + osp2]  <= cov2 )
                    MatrixRRX[X+ Y*osx] = (int)((MaxN * 0.05) + 1);
                else
                    MatrixRRX[X+ Y*osx] = -1;
                
			}
            else
                MatrixRRX[X+ Y*osx] = -1;
            
        }
	}

	return(1);
}




int FAR pascal MakeCntHit(int BPos, int EPos, int SWinx, int NextNo, int LenVarSeq, int LS, double *CntHit, unsigned char *VarSiteMap, float *VarSiteSmooth, int *VRPos){
	//varsitemap 2,ls,nextno
	//varsitesmooth 2,ls,nextno
	int Tot, A,B,X,Z,Y,ST,os1, os2, os3;
	double TotX, SWin, NCnt;
	os2 = (LS+1)*3;

	if (SWinx <= 0) 
		SWin = 3;
	else
		SWin = (double)(SWinx);

	for (A = 0; A < 3; A++){
        for (B = 0; B <= NextNo; B++){
            Tot = 0;
			os1 = A+B*os2;
            for (X = 1 - SWinx; X <= SWinx+1; X++){
            
                if (X < 1)
                    Z = LenVarSeq + X;
                else if (X > LenVarSeq)
                    Z = X - LenVarSeq;
                else
                    Z = X;
                
                Tot = Tot + VarSiteMap[(Z*3) + os1];
				//Tot = Tot + VarSiteMap[A + (Z*3) + B*(LS+1)*3];
            }
            TotX = (double)(Tot);
            
			VarSiteSmooth[3 + os1] = (float)(TotX / ((SWinx * 2 + 1) * 2));
            //VarSiteSmooth[A + 3 + B*(LS+1)*3] = TotX / ((SWinx * 2 + 1) * 2);
			for (X = 2; X <= LenVarSeq; X++){
                Z = X - SWinx - 1;
                if (Z < 1)
                    Tot = Tot - VarSiteMap[3*(LenVarSeq + Z) + os1];
					//Tot = Tot - VarSiteMap[A + 3*(LenVarSeq + Z) + B*3*(LS+1)];
                else if (Z > LenVarSeq)
                    Tot = Tot - VarSiteMap[3*(Z - LenVarSeq) + os1];
					//Tot = Tot - VarSiteMap[A + 3*(Z - LenVarSeq) + B*3*(LS+1)];
                else
                    Tot = Tot - VarSiteMap[3*Z + os1];
					//Tot = Tot - VarSiteMap[A + 3*Z + os1];
                Z = X + SWinx;

                if (Z > LenVarSeq)
                    Tot = Tot + VarSiteMap[3*(Z - LenVarSeq) + os1];
					//Tot = Tot + VarSiteMap[A + 3*(Z - LenVarSeq) + B*3*(LS+1)];
                else
                     Tot = Tot + VarSiteMap[3*Z + os1];
					 //Tot = Tot - VarSiteMap[A + 3*Z + B*3*(LS+1)];

                TotX = (double)(Tot);
                VarSiteSmooth[X*3 + os1] = (float)(TotX / ((SWinx * 2 + 1) * 2));
                //VarSiteSmooth[A + X*3 + B*3*(LS+1)] = TotX / ((SWinx * 2 + 1) * 2);
            }
        }
    }


	//return(1);
    
    if (BPos > 1)
        ST = BPos-1;
    else
        ST = BPos;
    
    
    
    NCnt = 0.0;
	//cnthit 2,1,nextno
	os3 = 6; 
    if (BPos < EPos){
        for (X = 1; X <= VRPos[ST-1]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os2] > 0.6)
                       CntHit[Y + Z*6] = CntHit[Y + Z*6] + (VarSiteSmooth[Y+os2] - 0.6) / 0.4;
                       
                  
                }
            }
            
        }
        for (X = VRPos[EPos + 1]; X <= VRPos[LS]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os2] > 0.6)
                       CntHit[Y + Z*6] = CntHit[Y + Z*6] + (VarSiteSmooth[Y+os2] - 0.6) / 0.4;
                       
                  
                }
            }
        }
        
        for (Y = 0; Y < 3; Y++){
            for (Z = 0; Z <= NextNo; Z++)
            
                 CntHit[Y + Z*6] =  CntHit[Y + Z*6] / NCnt;
             
        }
        NCnt = 0;
        for (X = VRPos[BPos]; X <= VRPos[EPos]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os2] > 0.6)
                       CntHit[Y + 3 + Z*6] = CntHit[Y + 3 + Z*6] + (VarSiteSmooth[Y+os2] - 0.6) / 0.4;
                       
                  
                }
            }
        }
        for (Y = 0; Y < 3; Y++){
            for (Z = 0; Z <= NextNo; Z++)
            
                 CntHit[Y + 3 + Z*6] =  CntHit[Y + 3 + Z*6] / NCnt;
             
        }
    }
	else{
		for (X = 1; X <= VRPos[EPos]; X++){
				NCnt = NCnt + 1;
				os1 = X*3;
				for (Z = 0; Z <= NextNo; Z++){
					os2 = Z*3*(LS+1)+os1;
					for (Y = 0; Y<3; Y++){
						if (VarSiteSmooth[Y+os2] > 0.6)
						   CntHit[Y + 3 + Z*6] = CntHit[Y + 3 + Z*6] + (VarSiteSmooth[Y+os2] - 0.6) / 0.4;
					}
				}
		}
        for (X = VRPos[BPos]; X <= VRPos[LS]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os2] > 0.6)
                       CntHit[Y + 3 +  Z*6] = CntHit[Y + 3 + Z*6] + (VarSiteSmooth[Y+os2] - 0.6) / 0.4;
                       
                  
                }
            }
        }
        for (Y = 0; Y < 3; Y++){
            for (Z = 0; Z <= NextNo; Z++)
            
                 CntHit[Y + 3 + Z*6] =  CntHit[Y + 3 + Z*6] / NCnt;
             
        }
        NCnt = 0;
        for (X = VRPos[EPos + 1]; X <= VRPos[BPos - 1]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os2] > 0.6)
                       CntHit[Y + Z*6] = CntHit[Y + Z*6] + (VarSiteSmooth[Y+os2] - 0.6) / 0.4;
                       
                  
                }
            }
        }
        for (Y = 0; Y < 3; Y++){
            for (Z = 0; Z <= NextNo; Z++)
            
                 CntHit[Y + Z*6] =  CntHit[Y + Z*6] / NCnt;
             
        }
    }


	return(1);
}

int FAR pascal MakeCntHit2(int BPos, int EPos, int SWinx, int NextNo, int LenVarSeq, int LS, int UBVSM, double *CntHit, short int *VarSiteMap, float *VarSiteSmooth, int *VRPos){
	//varsitemap 2,ls,nextno
	//varsitesmooth 2,ls,nextno
	int Tot, A,B,X,Z,Y,ST,os1, os2, os3, os4, os5, os6, os7;
	double TotX, SWin, NCnt;
	os2 = (LS+1)*3;
	os4 = (LenVarSeq+1)*3;
	os6 = (UBVSM+1)*3;
	if (SWinx <= 0) 
		SWin = 3;
	else
		SWin = (double)(SWinx);

	for (A = 0; A < 3; A++){
        for (B = 0; B <= NextNo; B++){
            Tot = 0;
			os1 = A+B*os2;
			os5 = A+B*os4;
			os7 = A+B*os6;
            for (X = 1 - SWinx; X <= SWinx+1; X++){
            
                if (X < 1)
                    Z = LenVarSeq + X;
                else if (X > LenVarSeq)
                    Z = X - LenVarSeq;
                else
                    Z = X;
                
                Tot = Tot + VarSiteMap[(Z*3) + os7];
				//Tot = Tot + VarSiteMap[A + (Z*3) + B*(LS+1)*3];
            }
            TotX = (double)(Tot);
            
			VarSiteSmooth[3 + os5] = (float)(TotX / ((SWinx * 2 + 1) * 2));//this is timed by two because every match gets a score of 2
            //VarSiteSmooth[A + 3 + B*(LS+1)*3] = TotX / ((SWinx * 2 + 1) * 2);
			for (X = 2; X <= LenVarSeq; X++){
                Z = X - SWinx - 1;
                if (Z < 1)
                    Tot = Tot - VarSiteMap[3*(LenVarSeq + Z) + os7];
					//Tot = Tot - VarSiteMap[A + 3*(LenVarSeq + Z) + B*3*(LS+1)];
                else if (Z > LenVarSeq)
                    Tot = Tot - VarSiteMap[3*(Z - LenVarSeq) + os7];
					//Tot = Tot - VarSiteMap[A + 3*(Z - LenVarSeq) + B*3*(LS+1)];
                else
                    Tot = Tot - VarSiteMap[3*Z + os7];
					//Tot = Tot - VarSiteMap[A + 3*Z + os1];
                Z = X + SWinx;

                if (Z > LenVarSeq)
                    Tot = Tot + VarSiteMap[3*(Z - LenVarSeq) + os7];
					//Tot = Tot + VarSiteMap[A + 3*(Z - LenVarSeq) + B*3*(LS+1)];
                else
                     Tot = Tot + VarSiteMap[3*Z + os7];
					 //Tot = Tot - VarSiteMap[A + 3*Z + B*3*(LS+1)];

                TotX = (double)(Tot);
                VarSiteSmooth[X*3 + os5] = (float)(TotX / ((SWinx * 2 + 1) * 2));
                //VarSiteSmooth[A + X*3 + B*3*(LS+1)] = TotX / ((SWinx * 2 + 1) * 2);
            }
        }
    }


	//return(1);
    
    if (BPos > 1)
        ST = BPos-1;
    else
        ST = BPos;
    
    
    
    NCnt = 0.0;
	//cnthit 2,1,nextno
	os3 = 6; 
    if (BPos < EPos){
        for (X = 1; X <= VRPos[ST-1]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				os5 =  Z*os4+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os5] > 0.6)
                       CntHit[Y + Z*6] = CntHit[Y + Z*6] + (VarSiteSmooth[Y+os5] - 0.6) / 0.4;
                       
                  
                }
            }
            
        }
        for (X = VRPos[EPos + 1]; X <= VRPos[LS]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				os5 =  Z*os4+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os5] > 0.6)
                       CntHit[Y + Z*6] = CntHit[Y + Z*6] + (VarSiteSmooth[Y+os5] - 0.6) / 0.4;
                       
                  
                }
            }
        }
        
        for (Y = 0; Y < 3; Y++){
            for (Z = 0; Z <= NextNo; Z++)
            
                 CntHit[Y + Z*6] =  CntHit[Y + Z*6] / NCnt;
             
        }
        NCnt = 0;
        for (X = VRPos[BPos]; X <= VRPos[EPos]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				os5 =  Z*os4+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os5] > 0.6)
                       CntHit[Y + 3 + Z*6] = CntHit[Y + 3 + Z*6] + (VarSiteSmooth[Y+os5] - 0.6) / 0.4;
                       
                  
                }
            }
        }
        for (Y = 0; Y < 3; Y++){
            for (Z = 0; Z <= NextNo; Z++)
            
                 CntHit[Y + 3 + Z*6] =  CntHit[Y + 3 + Z*6] / NCnt;
             
        }
    }
	else{
		for (X = 1; X <= VRPos[EPos]; X++){
				NCnt = NCnt + 1;
				os1 = X*3;
				for (Z = 0; Z <= NextNo; Z++){
					os2 = Z*3*(LS+1)+os1;
					os5 =  Z*os4+os1;
					for (Y = 0; Y<3; Y++){
						if (VarSiteSmooth[Y+os5] > 0.6)
						   CntHit[Y + 3 + Z*6] = CntHit[Y + 3 + Z*6] + (VarSiteSmooth[Y+os5] - 0.6) / 0.4;
					}
				}
		}
        for (X = VRPos[BPos]; X <= VRPos[LS]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				os5 =  Z*os4+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os5] > 0.6)
                       CntHit[Y + 3 +  Z*6] = CntHit[Y + 3 + Z*6] + (VarSiteSmooth[Y+os5] - 0.6) / 0.4;
                       
                  
                }
            }
        }
        for (Y = 0; Y < 3; Y++){
            for (Z = 0; Z <= NextNo; Z++)
            
                 CntHit[Y + 3 + Z*6] =  CntHit[Y + 3 + Z*6] / NCnt;
             
        }
        NCnt = 0;
        for (X = VRPos[EPos + 1]; X <= VRPos[BPos - 1]; X++){
            NCnt = NCnt + 1;
			os1 = X*3;
            for (Z = 0; Z <= NextNo; Z++){
				os2 = Z*3*(LS+1)+os1;
				os5 =  Z*os4+os1;
				for (Y = 0; Y<3; Y++){
					if (VarSiteSmooth[Y+os5] > 0.6)
                       CntHit[Y + Z*6] = CntHit[Y + Z*6] + (VarSiteSmooth[Y+os5] - 0.6) / 0.4;
                       
                  
                }
            }
        }
        for (Y = 0; Y < 3; Y++){
            for (Z = 0; Z <= NextNo; Z++)
            
                 CntHit[Y + Z*6] =  CntHit[Y + Z*6] / NCnt;
             
        }
    }


	return(1);
}

int FAR pascal FindBestRecSignal(char DoneTarget, int NextNo,int UB, double *LowP, char *DoneSeq, int *Trace, short int *PCurrentXOver,XOVERDEFINE *PXOList){
	int  X, Y, TotalNoRecombinants;
	double LowPX, CPVal;
	TotalNoRecombinants=0;
	LowPX = *LowP;
	for (X = 0; X <= NextNo; X++)
            TotalNoRecombinants = TotalNoRecombinants + PCurrentXOver[X];
           
	for (X = 0; X <= NextNo; X++){
		for (Y = 1; Y <= PCurrentXOver[X]; Y++){
             
			if (DoneSeq[X + Y*(NextNo+1)] == DoneTarget) {
                    //CPVal = PXOList(X, Y).Probability
					
                    CPVal = PXOList[X+Y*(UB+1)].Probability;
					//*LowP = (double)((PXOList[1+ 5*(NextNo+1)].PermPVal));
					//TotalNoRecombinants = (PXOList[1+ 5*(NextNo+1)].Eventnumber);
					//return(TotalNoRecombinants);
                    if (CPVal > 0 && CPVal < LowPX){
                        if (PXOList[X+Y*(UB+1)].Beginning != PXOList[X+Y*(UB+1)].Ending){
                            LowPX = CPVal;
                            Trace[0] = X;
                            Trace[1] = Y;
                            
						}
                    
                       
                    }
			}
		}
	}
	*LowP = LowPX;
	return(TotalNoRecombinants);
}

int FAR pascal MakeVarMap(int NextNo, int LS, short int *SeqNum, char *VarSiteMap, int *VRPos, int *VXPos, int *ISeqs, int *CompMat){
	int X,Y, Z, LenVarSeq, os0,os1,os2, os3, os4, s0,s1,s2, sx,sy,sz;
	//compmat 2,1
	//varsitemap 2,ls,nextno
	LenVarSeq = 0;
	os0 = (LS+1)*ISeqs[0];
	os1 = (LS+1)*ISeqs[1];
	os2 = (LS+1)*ISeqs[2];
	os4 = (LS+1)*3;
	for (X = 0; X <= LS; X++){
        VRPos[X] = LenVarSeq;
		s0 = SeqNum[X + os0];
        if (s0 != 46){
			s1 = SeqNum[X + os1];
            if (s1 != 46){
				s2 = SeqNum[X + os2];
                if (s2 != 46){
                    if (s0 != s1 || s0 !=s2){
                        LenVarSeq ++;
                        VXPos[LenVarSeq] = X;
						os3 = LenVarSeq*3;
						for (Y = 0; Y < 3; Y++){
							sx = SeqNum[X + ISeqs[Y]*(LS+1)];
							sy = SeqNum[X + ISeqs[CompMat[Y]]*(LS+1)];
							sz = SeqNum[X + ISeqs[CompMat[Y+3]]*(LS+1)];
                            for (Z = 0; Z <= NextNo; Z++){
                                if (sx == SeqNum[X + Z*(LS+1)])
                                    VarSiteMap[Y + os3 + Z*os4] = 2;
                                else if (SeqNum[X + Z*(LS+1)] != sy){
									if (SeqNum[X + Z*(LS+1)] != sz)
										VarSiteMap[Y + os3 + Z*os4] = 1;
								}
                                
                            }   
                        }            
                    }
                }
            }
        }
    }
	return(LenVarSeq);
}


int FAR pascal MakeVarMap2(int NextNo, int LS, int UBVSM, short int *SeqNum, short int *VarSiteMap, int *VRPos, int *VXPos, int *ISeqs, int *CompMat){
	int X,Y, Z, LenVarSeq, os0,os1,os2, os3, os4, s0,s1,s2, sx,sy,sz, os5,s4;
	//compmat 2,1
	//varsitemap 2,ls,nextno
	LenVarSeq = 0;
	os0 = (LS+1)*ISeqs[0];
	os1 = (LS+1)*ISeqs[1];
	os2 = (LS+1)*ISeqs[2];
	os4 = (LS+1)*3;
	os5= (UBVSM+1)*3;

	for (X = 0; X <= LS; X++){
        VRPos[X] = LenVarSeq;
		s0 = SeqNum[X + os0];
        if (s0 != 46){
			s1 = SeqNum[X + os1];
            if (s1 != 46){
				s2 = SeqNum[X + os2];
                if (s2 != 46){
                    if (s0 != s1 || s0 !=s2){
                        LenVarSeq ++;
                        VXPos[LenVarSeq] = X;
						os3 = LenVarSeq*3;
						for (Y = 0; Y < 3; Y++){
							sx = SeqNum[X + ISeqs[Y]*(LS+1)];
							sy = SeqNum[X + ISeqs[CompMat[Y]]*(LS+1)];
							sz = SeqNum[X + ISeqs[CompMat[Y+3]]*(LS+1)];
                            for (Z = 0; Z <= NextNo; Z++){
                                s4 = SeqNum[X + Z*(LS+1)];
								//if (s4 != 46){
									if (sx == s4)
										VarSiteMap[Y + os3 + Z*os5] = 2;
									else if (s4 != 46){
										//ElseIf SeqNum(X, SY) <> 46 Then
										if ((s4 == sy && sx == sz) || (sx == sy && s4 == sz) )  
											VarSiteMap[Y + os3 + Z*os5] = -1; 
										else if ((s4 == sy && s4 != sz) || (s4 != sy && s4 == sz) )
											VarSiteMap[Y + os3 + Z*os5] = 0;
                               
										else if (s4 != sy && s4 != sz)
												VarSiteMap[Y + os3 + Z*os5] = 1;
										
									}
							//	}
                                
                            }   
                        }            
                    }
                }
            }
        }
    }
	return(LenVarSeq);
}

int FAR pascal MakeRecCMatrix(int LS, int RSize,int ST, int EN, int *SCMatrix, float *RegionMat){
	int A, B, RS1, RS2, LS1, LS2, off1, off2 ,rsh;
	//regionmat = rsize+1,rsize+1;
	RS1 = 0;
	RS2 = 0;
	LS1 = -1; 
	LS2 = -1;
	rsh = RSize+2;
	if (ST < EN){
		for (A = 1; A < ST; A++){
			RS1 = SCMatrix[A];
			
			if (LS1 != RS1){
				off1 = RS1*(rsh);
				LS1 = RS1;
				for (B = ST; B <= EN; B++){
					RS2 = SCMatrix[B];
                    if (LS2 != RS2){
						LS2 = RS2;
						off2 = RS2*(rsh);
                        RegionMat[RS2 + off1] = RegionMat[RS2 + off1] + 1;
                        RegionMat[RS1 + off2] = RegionMat[RS2 + off1];
					}
				}
			}
		}
		for (A = EN + 1; A <= LS; A++){
            RS1 = SCMatrix[A];
			if (LS1 != RS1){
				LS1 = RS1;
                off1 = RS1*(rsh);        
				for (B = ST; B <= EN; B++){
                    RS2 = SCMatrix[B];
                    if (LS2 != RS2){
						LS2 = RS2;
						off2 = RS2*(rsh);
                        RegionMat[RS2 + off1] = RegionMat[RS2 + off1] + 1;
                        RegionMat[RS1 + off2] = RegionMat[RS2 + off1];
					}
				}
			}
		}
	}
	else{
		for (A = EN + 1; A < ST; A++){
            RS1 = SCMatrix[A];
			if (LS1 != RS1){
				LS1 = RS1;
                off1 = RS1*(rsh);         
				for (B = 1; B <= EN; B++){
                    RS2 = SCMatrix[B];
                    if (LS2 != RS2){
						LS2 = RS2;
						off2 = RS2*(rsh);
                        RegionMat[RS2 + off1] = RegionMat[RS2 + off1] + 1;
                        RegionMat[RS1 + off2] = RegionMat[RS2 + off1];
					}
				}
				for (B = ST; B <= LS; B++){
                    RS2 = SCMatrix[B];
                    if (LS2 != RS2){
						LS2 = RS2;
						off2 = RS2*(rsh);
                        RegionMat[RS2 + off1] = RegionMat[RS2 + off1] + 1;
                        RegionMat[RS1 + off2] = RegionMat[RS2 + off1];
					}
				}
			}
		}
                    
                
	}




	return(1);
}

int FAR pascal FindBesSeqSF(int Nextno, int *ListToRedo, float  *SMat, float *FMat, int *BestSeqS,int *BestSeqF){
	int X, Y, off1, off2;
	float MDValS, MDValF;

	off1 = Nextno+1;

	for (X = 0; X <= Nextno; X++){
        if (ListToRedo[X] == 1){
            MDValS = 10.0;
            MDValF = 10.0;
           
            for (Y = 0; Y <= Nextno; Y++){
            
                if (Y != X && ListToRedo[Y] == 0){
					off2 = X + Y*off1;
                    if (SMat[off2] < MDValS){
                        MDValS = SMat[off2];
                        BestSeqS[X] = Y;
                    }
                    if (FMat[off2] < MDValF){
                        MDValF = FMat[off2];
                        BestSeqF[X] = Y;
					}
				}
            }
            
            
            
        }
    
	}

	return(1);
}


int FAR pascal ReAddDists(int Nextno, int *ListToRedo, float *SAMat, float *FAMat,float *SCMat, float *FCMat, int *BestSeqS, int *BestSeqF){
	int X, Y, off1, off2, sx, fx, off3, offs, offf;
	off1=Nextno+1;
	for (X = 0; X <= Nextno; X++){
        if (ListToRedo[X] == 1){
            sx = BestSeqS[X];
			fx = BestSeqF[X];
            for (Y = 0; Y <= Nextno; Y++){
                off2 = X+Y*off1;
				off3 = Y+X*off1;
				offs = sx + BestSeqS[Y]*off1;
				offf = fx + BestSeqF[Y]*off1;
                if (Y != X){
                    if (ListToRedo[Y] == 1){
                        if (SAMat[off2] > SAMat[offs]) {
                            SCMat[off2] = SCMat[offs];
                            SCMat[off3] = SCMat[off2];
                            SAMat[off2] = SAMat[offs];
                            SAMat[off3] = SAMat[off2];
                        }
                        if (FAMat[off2] > FAMat[offf]) {
                            FCMat[off2] = FCMat[offf];
                            FAMat[off2] = FAMat[offf];
                            FCMat[off3] = FCMat[off2];
                            FAMat[off3] = FAMat[off2];
                        }
					}
                    else{
                        
                        
                        
                        if (SAMat[off2] > SAMat[offs]){
                            SCMat[off2] = SCMat[offs];
                            SCMat[off3] = SCMat[off2];
                            SAMat[off2] = SAMat[offs];
                            SAMat[off3] = SAMat[off2];
                        }
                        if (FAMat[off2] > FAMat[offf]){
                            FCMat[off2] = FCMat[offf];
                            FAMat[off2] = FAMat[offf];
                            FCMat[off3] = FCMat[off2];
                            FAMat[off3] = FAMat[off2];
                        }
                    
                    
                    }
				}
                else{
                    SCMat[off2] = 0;
                    SAMat[off2] = 0;
                    FCMat[off2] = 0;
                    FAMat[off2] = 0;
                }
            
            }
            
        }
    
    }



	return(1);
}

int FAR pascal FillSets(int UBS, int UBRL, int *RNum, int *RI, int *RList, unsigned char *Sets){
	
	int Z, A, TS, off1, off2;
	off1 = UBRL+1;
	off2 = UBS+1;
	for (Z = 0; Z <= 2; Z++){
        
        for (A = 0; A <= RNum[Z]; A++){
            TS = RList[Z + A*UBRL];
            if (RI[0] == TS || RI[1] == TS || RI[2] == TS){
                Sets[Z + RI[0]*off2] = 1;
                Sets[Z + RI[1]*off2] = 1;
                Sets[Z + RI[2]*off2] = 1;
            }
        }
    }

	return(1);
}

int FAR pascal FindMaxMapVal(int DN, int LS, int PermNum, int *MaxVals, short int *Map){
	int X, Y, off1;
	//maxvals, 1,permnum
	//Map - ls,permnum
	
	
	for (X = 1; X <= PermNum; X++){
		off1 = (LS+1)*X;
        for (Y = DN;Y <= LS - DN + 1; Y++){
			
            if (MaxVals[X*2] < Map[Y + off1]) 
				MaxVals[X*2] = Map[Y + off1];
           
        }
        
    }
	return(1);

}
int FAR pascal MakeSubSeqPerm(int LS, int D, int P1, int P2, short int *PermSeqNum,int *XDiffPos,int *XPosDiff){
	int LSSeq,B, osd, osp1, osp2;
	LSSeq = 0;
	osd = D*(LS+1);
	osp1 = P1*(LS+1);
	osp2 = P2*(LS+1);
    
	for (B = 0; B <=LS+200; B++)
		XDiffPos[B] = 0;
	
	for (B = 0; B <=LS+200; B++)
		XPosDiff[B] = 0;

	for (B = 1; B <= LS; B++){
                            
		XPosDiff[B] = LSSeq;
        if (PermSeqNum[B + osd] != 46) {
			if (PermSeqNum[B + osp1] != 46) {
				if (PermSeqNum[B + osp2] != 46){
					if (PermSeqNum[B + osd] != PermSeqNum[B + osp1] ){
						LSSeq ++;
                        XPosDiff[B] = LSSeq;
                        XDiffPos[LSSeq] = B;
					}
					else if (PermSeqNum[B + osd] != PermSeqNum[B +osp2]){
						LSSeq ++;
                        XPosDiff[B] = LSSeq;
                        XDiffPos[LSSeq] = B;

						
					}
				}
			}
                            
		}
	}

	return(LSSeq);
}

double FAR pascal DefineEvent(int ShortOutFlag, int LongWindedFlag, int MedHomol, int HighHomol, int LowHomol, int TargetX,int CircularFlag, int XX, int  XOverWindow, int  lenseq, int  LenXoverSeq, int  SeqDaughter, int  SeqMinorP, int *EndFlag, int  *Be, int  *En, int  *NCommon, int  *XOverLength, char *XOverSeqNum, int *XDiffPos, int *XOverHomologyNum){
	//xoverseqnum lenseq,2
	//xoverhomologynum LenXoverSeq + XOverWindow * 2, 2
	int X, off1, off2, off3, off4, off6,  Storex, Store, TC, NC;
	TC=0;
	
	off1 = LenXoverSeq + XOverWindow*2 + 1;
	off2 = (MedHomol - 1)*off1;
	off3 = (HighHomol - 1)*off1;
	off6 = (LowHomol - 1)*off1;

	if ((SeqDaughter == 0 && SeqMinorP == 1) || (SeqDaughter == 1 && SeqMinorP == 0))
		TC = 0;
	else if ((SeqDaughter == 0 && SeqMinorP == 2) || (SeqDaughter == 2 && SeqMinorP == 0))
		TC = 1;
	else if ((SeqDaughter == 2 && SeqMinorP == 1) || (SeqDaughter == 1 && SeqMinorP == 2))
		TC = 2;
	
	off4 = XOverWindow+TC*(lenseq+1+XOverWindow*2);
	
	
	
	
	X = XX;
	if (X > 1){
		while (X != 1){
			X--;
            
			if (XOverSeqNum[X + off4] == 0){// || s1 == 64){
				X++;
                break;
			}
		}
	}
    
	NC=0;
	if (XOverSeqNum[X + off4] == 0){
		while (X <= LenXoverSeq+1){
			X++;
			
            if (XOverSeqNum[X + off4])// && s1 != 64)
				break;
			if (X==LenXoverSeq+1){
				if (NC==1)
					break;
				X=0;
				NC++;
				*EndFlag=1;
			}
		}
	}

    

	if (CircularFlag == 0) {
		if (X == 1){
			if (XDiffPos[X] < TargetX)
				*Be = 1;
            else
				*Be = XDiffPos[X];
		}
		else
			*Be = XDiffPos[X];
	}
	else
		*Be = XDiffPos[X];
                   
	
	
	while (X <= LenXoverSeq){
		
        
        if (XOverSeqNum[X + off4])
			*NCommon = *NCommon + 1;
                        
        *XOverLength = *XOverLength + 1;
                                
        if (*XOverLength >= LenXoverSeq) 
			break;
                                
        X++;
        
		
		//if (s1 == 64)
		//	break;

        if (X > LenXoverSeq) {
        
			if (CircularFlag == 1){
				X = 0;
                *EndFlag = 1;
			}
			else{
				X = LenXoverSeq + 2 * XOverWindow + 1;
                break;
			}
		}

		if (XOverHomologyNum[X + off2] < XOverHomologyNum[X + off3] || XOverHomologyNum[X + off2] < XOverHomologyNum[X + off6]){
			if (XOverSeqNum[X + off4] == 0)
				break;
		}
        
	}
                    
    Storex = X;
    X--;
    Store = 0;
        
	while(X > 0){
		if(XOverSeqNum[X + off4] == 0){// || XOverSeqNum[X + off4] == 64){
			if (X < LenXoverSeq){
				if (X > 0){
					X--;
					Store = Store + 1;
					*XOverLength = *XOverLength - 1;
					if (*XOverLength == 1)
						break;
				}
				else {

					X = LenXoverSeq+1;

				
					break;
				}
			}
			else
				break;
		}
		else 
			break;
	}
    
	               
	
	if (X == LenXoverSeq && CircularFlag == 0){
		if (ShortOutFlag == 0 || ShortOutFlag == 6 || ShortOutFlag == 10)
			*En = lenseq;
		else
			*En = XDiffPos[LenXoverSeq];
                        
	}
	else{
		if (X >= LenXoverSeq){
			if (LongWindedFlag == 0)
				XDiffPos[X] = 0;
            else
                X = LenXoverSeq +1;
                          
		}
		else if(X < 1)
			X = LenXoverSeq+1;

        *En = XDiffPos[X];
	}
                            
    X = Storex + 1;
    if (*En == 0){
                                
		if (ShortOutFlag == 0 || ShortOutFlag == 6 || ShortOutFlag == 10)
			*En = lenseq - 1;
        else
            *En = XDiffPos[LenXoverSeq];
                        
	}
    return((double)(X));                 
	
}

double FAR pascal DistanceCalc2(short int nextno,int lenseq,short int *seqnum,double *distance,double *avdst)
{

	double **count, **valid;
	double dst,ad;
	dst=0.0;
	double upper=0.0;
	short int s1, s2;
	int j;

	ad = 0.0;
	
	count = (double **)malloc((nextno+1)*sizeof(double *));
	for (j = 0; j < nextno+1; j++)
		count[j] = (double *)malloc((nextno+1)*sizeof(double));
	
	valid = (double **)malloc((nextno+1)*sizeof(double *));
	for (j = 0; j < nextno+1; j++)
		valid[j] = (double *)malloc((nextno+1)*sizeof(double));
	
	
	
	for (int z = 1; z<=lenseq; z++){
		for(int x=0;x<=nextno-1;x++){
			s1 = *(seqnum + z + x * lenseq);
			for (int y = x+1; y<=nextno; y++){
			   s2 = *(seqnum + z + y * lenseq);
				if (s1 != s2 && s1 > 64 && s2 > 64){
					count[x][y] += 1.0;
					valid[x][y] += 1.0;
				}
				else{
					if(s1 > 64 && s2 > 64)
						valid[x][y] += 1.0;   
				}
			   
			}
   
		}
	}

	for(int x=0;x<nextno;x++){
		for (int y = x+1; y<=nextno; y++){
			dst = (valid[x][y] - count[x][y])/valid[x][y];
			*(distance + x + y*(nextno+1))= dst;
			*(distance + y + x*(nextno+1))= dst;
			ad = ad + (1.0 - dst);
			if(dst < upper)
				upper = dst;
		}
   
	}
	upper = (double)(1 - dst);

	//*(distance + 2 + 5*(nextno+1)) = 50.555; 
	//*(distance + y + x*nextno) = (lenseq - count) / lenseq; 
	*avdst = ad; 
	return(upper);
}


double FAR pascal DistanceCalcD(short int nextno,int lenseq,short int *seqnum,float *distance,float *validsiteno,short int *currentxover,float *distanceb)
{

int count=0;
int valid=0;

for(int x=0;x<=nextno;x++){
	for (int y = x+1; y<=nextno; y++){
		if(*(currentxover+x)==0 && *(currentxover+y)==0){
		
			*(distance + x + y*(nextno+1))= 1-*(distanceb + x + y*(nextno+1));//(lenseq-count)/lenseq; 
			*(distance + y + x*(nextno+1))= 1-*(distanceb + x + y*(nextno+1));//(lenseq-count)/lenseq; 

		}
		else{
			count = 0;
			valid = 0;
       
		   for (int z = 1; z<=lenseq; z++){
			   if (*(seqnum + z + x * lenseq) != *(seqnum + z + y * lenseq) && *(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
               
							count++;
							valid++;
				}
			   else{
					if(*(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
							valid++;   
					}
			   }
		   
		   }    
		   
		   *(distance + x + y*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
		   *(distance + y + x*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
		   *(validsiteno + x + y*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
		   *(validsiteno + y + x*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
	
		}
	}
        
}
//*(distance + 2 + 5*(nextno+1)) = 50.555; 
//*(distance + y + x*nextno) = (lenseq - count) / lenseq; 
       
return(count);
}


double FAR pascal DistanceCalcB(short int nextno,int lenseq,short int nonspacerno,short int *seqnum,float *distance,float *validsiteno)
{

int count=0;
int valid=0;


for(int x=0;x<=nextno;x++){
	
		for (int y = x+1; y<=nextno; y++){
		
			if ((x<=1) || (y<=1)){
				count = 0;
				valid = 0;
       
			   for (int z = 1; z<=lenseq; z++){
				   if (*(seqnum + z + x * lenseq) != *(seqnum + z + y * lenseq) && *(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
               
								count++;
								valid++;
					}
				   else{
						if(*(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
								valid++;   
						}
				   }
			   
			   }    
			   
			   *(distance + x + y*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
			   *(distance + y + x*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
			   *(validsiteno + x + y*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
			   *(validsiteno + y + x*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
		
			}
			   

		}
}


count=0;
valid=0;

for(x=2;x<=nextno;x++){
	
		for (int y = x+1; y<=nextno; y++){
		
			if ((x<=nonspacerno+3) || (y<=nonspacerno+3)){
				count = 0;
				valid = 0;
       
			   for (int z = 1; z<=lenseq; z++){
				   if (*(seqnum + z + x * lenseq) != *(seqnum + z + y * lenseq) && *(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
               
								count++;
								valid++;
					}
				   else{
						if(*(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
								valid++;   
						}
				   }
			   
			   }    
			   
			   *(distance + x + y*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
			   *(distance + y + x*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
			   *(validsiteno + x + y*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
			   *(validsiteno + y + x*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
		
			}
			   

		}
}
//*(distance + 2 + 5*(nextno+1)) = 50.555; 
//*(distance + y + x*nextno) = (lenseq - count) / lenseq; 
       
return(count);
}

/* NOTE: ignore these...haven't gotten them to work yet...
float FAR pascal _export div1(float a, float b)
  {
	return(a/b);
  }
 
int FAR pascal _export strpass1(char *pstr1)
  {
	char *msg1ptr="Message 1 from DLL";
	pstr1 = msg1ptr;
	return(1);
  }              */

//  #pragma argsused
//int FAR PASCAL LibMain(HINSTANCE hInstance,
//		       WORD wDataSegment,
//		       WORD wHeapSize,
//		       LPSTR lpszCmdLine)
//  {                               
//  if (wHeapSize != 0 )
//    UnlockData( 0 );
//    return 1;
//  }
//#pragma argsused


double FAR pascal DistanceCalcC(short int nextno,int lenseq,int beginning,int ending,short int *seqnum,float *distance,float *validsiteno)
{

int count=0;
int valid=0;

if (beginning < ending){ 
	for(int x=0;x<=nextno;x++){
		for (int y = x+1; y<=nextno; y++){
		   count = 0;
		   valid = 0;
       
		   for (int z = beginning; z<=ending; z++){
			   if (*(seqnum + z + x * lenseq) != *(seqnum + z + y * lenseq) && *(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
               
							count++;
							valid++;
				}
			   else{
					if(*(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
							valid++;   
					}
			   }
		   
		   }    
		   
		   *(distance + x + y*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
		   *(distance + y + x*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
		   *(validsiteno + x + y*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
		   *(validsiteno + y + x*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
		}
        
	}
}
else {

	for(int x=0;x<=nextno;x++){
		for (int y = x+1; y<=nextno; y++){
		   count = 0;
		   valid = 0;
       
		   for (int z = 1; z<=ending; z++){
			   if (*(seqnum + z + x * lenseq) != *(seqnum + z + y * lenseq) && *(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
               
							count++;
							valid++;
				}
			   else{
					if(*(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
							valid++;   
					}
			   }
		   
		   }    
		   for ( z = beginning; z<=lenseq; z++){
			   if (*(seqnum + z + x * lenseq) != *(seqnum + z + y * lenseq) && *(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
               
							count++;
							valid++;
				}
			   else{
					if(*(seqnum + z + x * lenseq) > 64 && *(seqnum + z + y * lenseq) > 64){
							valid++;   
					}
			   }
		   
		   }    


		   *(distance + x + y*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
		   *(distance + y + x*(nextno+1))= (float)(count);//(lenseq-count)/lenseq; 
		   *(validsiteno + x + y*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
		   *(validsiteno + y + x*(nextno+1))= (float)(valid);//(lenseq-count)/lenseq; 
		}
        
	}
	





}
//*(distance + 2 + 5*(nextno+1)) = 50.555; 
//*(distance + y + x*nextno) = (lenseq - count) / lenseq; 
       
return(count);
}


double FAR pascal DistanceCalcE(short int y, short int nextno,int lenseq,int beginning,int ending,short int *seqnum,float *distance)
{

	int count;
	int valid;
	int x, z;
	short int s1,s2;
	int xoff, yoff;
	double count2, valid2, dst;
	
	yoff = y*lenseq;
	if (beginning < ending){ 
		for(x = 0;x <= nextno;x++){
			if (x != y){
			   xoff = x*lenseq;
			   count = 0;
			   valid = 0;
			   for (z = beginning; z <= ending; z++){
				   s1 = *(seqnum + z + xoff);
				   s2 = *(seqnum + z + yoff);
				   if( s1 > 64 && s2 > 64){
						valid++;
						if (s1 != s2 )
							count++;
				   }
			   }
				count2 = count;
				valid2 = valid;
				if (valid2 > 0)
					dst = (valid2 - count2)/valid2;
				else
					dst = 0;
				*(distance + x + y*(nextno+1))= (float)(dst);
				*(distance + y + x*(nextno+1))= (float)(dst);
			}
		}
	}
	else {
		for(x = 0;x <= nextno;x++){
			if (x != y){
			   xoff = x*lenseq;
			   count = 0;
			   valid = 0;
			   for (z = 1; z <= ending; z++){
				   s1 = *(seqnum + z + xoff);
				   s2 = *(seqnum + z + yoff);
				   if( s1 > 64 && s2 > 64){
					   valid++;
					   if (s1 != s2 )
							count++;
				   }
			   }
			   for (z = beginning; z < lenseq; z++){
				   s1 = *(seqnum + z + xoff);
				   s2 = *(seqnum + z + yoff);
				   if( s1 > 64 && s2 > 64){
						valid++;
						if (s1 != s2 )
							count++;
				   }
			   }
				count2 = count;
				valid2 = valid;
				if (valid2 > 0)
					dst = (valid2 - count2)/valid2;
				else
					dst = 0;
				*(distance + x + y*(nextno+1))= (float)(dst);
				*(distance + y + x*(nextno+1))= (float)(dst);
			}
			
		}

	}
	return(1);
}


int FAR pascal FindHiSeqs(int LS, int RS, int RE, int Ac, int Mi, int Ma, short int *SeqNum, float *Dists, float *Valids,float *Diffs){

	int X, Y, S1, S2;
	
	if (RS < RE){
		for (Y = 0; Y < 3; Y++){
			Dists[Y] = 0; 
			Valids[Y] = 0; 
			Diffs[Y] = 0;
            if (Y == 0){
				S1 = Ac*(LS+1); 
				S2 = Mi*(LS+1);
			}
			else if (Y == 1){
				S1 = Ac*(LS+1); 
				S2 = Ma*(LS+1);
			}
			else{
				S1 = Mi*(LS+1); 
				S2 = Ma*(LS+1);

			}
			for (X = RS; X <= RE; X++){
				if (SeqNum[X + S1] != 46){
					if (SeqNum[X + S2] != 46){
						Valids[Y] = Valids[Y] + 1;
                        if (SeqNum[X + S1] != SeqNum[X + S2])
							Diffs[Y] = Diffs[Y] + 1;
					}
				}
			}
            if (Valids[Y] > 0)
				Dists[Y] = Diffs[Y] / Valids[Y];
            else
				Dists[Y] = (float)(Diffs[Y] /  0.00001);
                
		}
	}
	else{
		for (Y = 0; Y < 3; Y++){
            Dists[Y] = 0; 
			Valids[Y] = 0; 
			Diffs[Y] = 0;
            if (Y == 0){
				S1 = Ac*(LS+1); 
				S2 = Mi*(LS+1);
			}
			else if (Y == 1){
				S1 = Ac*(LS+1); 
				S2 = Ma*(LS+1);
			}
			else{
				S1 = Mi*(LS+1); 
				S2 = Ma*(LS+1);

			}
            for (X = RS; X <= LS; X++){
                if (SeqNum[X + S1] != 46){
					if (SeqNum[X + S2] != 46){
						Valids[Y] = Valids[Y] + 1;
                        if (SeqNum[X + S1] != SeqNum[X + S2])
							Diffs[Y] = Diffs[Y] + 1;
					}
				}
			}
            for (X = 1; X <= RE; X++){
                if (SeqNum[X + S1] != 46){
					if (SeqNum[X + S2] != 46){
						Valids[Y] = Valids[Y] + 1;
                        if (SeqNum[X + S1] != SeqNum[X + S2])
							Diffs[Y] = Diffs[Y] + 1;
					}
				}
			}
            if (Valids[Y] > 0)
				Dists[Y] = Diffs[Y] / Valids[Y];
            else
				Dists[Y] = (float)(Diffs[Y] /  0.00001);
		}
	}
	return(1);
}

double FAR pascal DistanceCalcF(short int seq1, short int seq2, short int seq3,  short int nextno,int lenseq,int beginning,int ending,double ahomol, short int *seqnum,float *dst, float *bkghomol)
{
    int xolen;
	float shomol, counts1, counts2, counts3, xolen2;
	float valids1,valids2,valids3;
	int z;
	short int s1,s2, s3;
	int s1off, s2off, s3off;
	//double count2, valid2, dst;
	
	shomol = 0;

	s1off = seq1*lenseq;
	s2off = seq2*lenseq;
	s3off = seq3*lenseq;
	
	counts1 = 0;
	valids1 = 0;
	counts2 = 0;
	valids2 = 0;
	counts3 = 0;
	valids3 = 0;

	if (beginning < ending){ 
		xolen = ending - beginning;
		for (z = beginning; z <= ending; z++){
			shomol += bkghomol[z];
			s1 = *(seqnum + z + s1off);
			s2 = *(seqnum + z + s2off);
			s3 = *(seqnum + z + s3off);
			if( s1 > 64 && s2 > 64){
				valids1++;
				if (s1 != s2 )
					counts1++;
			}
			if( s1 > 64 && s3 > 64){
				valids2++;
				if (s1 != s3 )
					counts2++;
			}
			if( s2 > 64 && s3 > 64){
				valids3++;
				if (s2 != s3 )
					counts3++;
			}
			
			if (valids1 > 0)
				dst[0] = (valids1 - counts1)/valids1;
			else
				dst[0] = 0;

			if (valids2 > 0)
				dst[1] = (valids2 - counts2)/valids2;
			else
				dst[1] = 0;

			if (valids3 > 0)
				dst[2] = (valids3 - counts3)/valids3;
			else
				dst[2] = 0;
		}
			
		
	}
	else {
		xolen = ending + lenseq-beginning;
		for (z = 1; z <= ending; z++){
			shomol += bkghomol[z];
			s1 = *(seqnum + z + s1off);
			s2 = *(seqnum + z + s2off);
			s3 = *(seqnum + z + s3off);
			if( s1 > 64 && s2 > 64){
				valids1++;
				if (s1 != s2 )
					counts1++;
			}
			if( s1 > 64 && s3 > 64){
				valids2++;
				if (s1 != s3 )
					counts2++;
			}
			if( s2 > 64 && s3 > 64){
				valids3++;
				if (s2 != s3 )
					counts3++;
			}
			
			if (valids1 > 0)
				dst[0] = (valids1 - counts1)/valids1;
			else
				dst[0] = 0;

			if (valids2 > 0)
				dst[1] = (valids2 - counts2)/valids2;
			else
				dst[1] = 0;

			if (valids3 > 0)
				dst[2] = (valids3 - counts3)/valids3;
			else
				dst[2] = 0;
		}
		for (z = beginning; z <= lenseq; z++){
			shomol += bkghomol[z];
			s1 = *(seqnum + z + s1off);
			s2 = *(seqnum + z + s2off);
			s3 = *(seqnum + z + s3off);
			if( s1 > 64 && s2 > 64){
				valids1++;
				if (s1 != s2 )
					counts1++;
			}
			if( s1 > 64 && s3 > 64){
				valids2++;
				if (s1 != s3 )
					counts2++;
			}
			if( s2 > 64 && s3 > 64){
				valids3++;
				if (s2 != s3 )
					counts3++;
			}
			
			if (valids1 > 0)
				dst[0] = (valids1 - counts1)/valids1;
			else
				dst[0] = 0;

			if (valids2 > 0)
				dst[1] = (valids2 - counts2)/valids2;
			else
				dst[1] = 0;

			if (valids3 > 0)
				dst[2] = (valids3 - counts3)/valids3;
			else
				dst[2] = 0;
		}

	}
	xolen2 = (float)(xolen);
	shomol /= xolen2;
	for (z = 0; z<=2; z++)
		dst[z] = 1-((1-dst[z]) / (((float)(ahomol))/shomol));
	return(shomol);
}

int FAR pascal DrawDiffs(HDC pict,int lenxoverseq, double xfactor,int *xdiffpos)
  
{
	long bakw, forw;
	int startc,y,t,overlap, inc;
	
	
	
	overlap = (long)(((1/xfactor)+1)/2);
	//if (overlap < 1)
	//	overlap = 1;
	inc = (int)(164/((overlap*2)+1)) - 1;
	if (inc < 1)
		inc = 1;
	for(int x = 0;x<=lenxoverseq;x++){
        bakw = *(xdiffpos + x) - overlap;
		forw = *(xdiffpos + x) + overlap;
		startc = inc;
		y=x-1;
		t = 1;
		while (y > 0){
			if (*(xdiffpos + y) < bakw)
				break;
			t++;
			y--;
		}
		
		y=x+1;
		
		while (y <= lenxoverseq){
			if (*(xdiffpos + y) > forw)
				break;
			t++;
			y++;
		}
		startc = 164 - (int)(inc*t);

		for (int z=11; z <=15; z++) 
		
			SetPixelV (pict,(int)(30 + *(xdiffpos + x) * xfactor), z,startc * 65793);
		
        x = y-1;
        
    }

	return(1);
}


int FAR pascal MakeDeleteArray(int FragSt, int FragEn, int FragCount, int *DeleteArray){

	int B;

	
		
			if (FragSt < FragEn){
				for (B = FragSt; B <= FragEn; B++)
					DeleteArray[B] = DeleteArray[B] + 1;
			}
			else{
                 for (B = FragSt; B <= FragCount; B++)
					DeleteArray[B] = DeleteArray[B] + 1;
				 for (B = 0; B <= FragEn; B++)
					DeleteArray[B] = DeleteArray[B] + 1;

			}
	return(1);


}


int FAR pascal DrawDiffsB(HDC pict,int lenxoverseq, double xfactor,int *xdiffpos)
  
{
	for(int x = 1;x<=lenxoverseq;x++){

		
		MoveToEx(pict, (int)(30 + *(xdiffpos + x) * xfactor), 11, 0);
        LineTo(pict, (int)(30 + *(xdiffpos + x) * xfactor), 15);
        
    }
	return(1);
}

int FAR pascal PlotDraw(HDC pict,int lenxoverseq, short int picheight, double xfactor,int *xdiffpos,  double *xoverhomologynum)
  

{
	MoveToEx(pict,(int)( 30 + *(xdiffpos + 1) * xfactor), (int)(picheight - (15 + *(xoverhomologynum + 1) * (picheight - 35))), 0);
	for(int x = 2;x<=lenxoverseq;x++){
        
                            
        
        LineTo(pict, (int)(30 + *(xdiffpos + x) * xfactor + xfactor), (int)(picheight - (15 + *(xoverhomologynum + x) * (picheight - 35))));
        
        
        
    }
	return(1);
}
 


 int FAR pascal CopyString(int xval, short int *picinfo,  unsigned char *varstring,int *numspaces)
  {	
  	
  	//short int xpos;
	
	unsigned short int pixcol;
  	
	int spacenum = 0;
	
	for (int xpos = 0;xpos < xval; xpos++){
			
			
			//pixcol=GetPixel(pict,xpos,ypos);
			//pixcol = pixcol/65536;
			//if (pixcol >=cutoff2) {
			pixcol = *(varstring + xpos)+1;
			*(picinfo + xpos+1) = pixcol;
			if (*(picinfo + xpos + 1) <65){
				spacenum++;
				
			
			}
			*(numspaces + xpos +1) = spacenum;
	}


  	
	return(xval);
  }


int FAR pascal InStrX(short int start, unsigned char *strng, unsigned short int target, short int slen)
  {	
	
	for (short int x = start;x < slen; x++){
			if (*(strng + x) == target){
				return(x);
			}
	}
	return(0);
  }

int FAR pascal GetSiteHomol(int lseq, short int nextno, short int *seqnum,  short int *idcount,int *seqhomol)
  {	
	
	int x,y, os, os2,os3, os4;
	short int sn;
	os=lseq+200;
	os2 = os*2;
	os3 = os*3;
	os4 = os*4;
	for (x = 1;x < lseq; x++){
		
		for (y = 0;y < nextno+1; y++){
			sn = *(seqnum + x + y*lseq);
			if (sn == 66){
					*(idcount + x) = *(idcount + x) + 1;
			}
			else{
				if (sn == 68){
					*(idcount + x + os) = *(idcount + x + os) + 1;
				}	
				else{
					if (sn == 72){
						*(idcount + x + os2) = *(idcount + x + os2) +1;
					}
					else{
						if (sn == 85){
							*(idcount + x + os3) = *(idcount + x + os3) +1;
						}
						else{
							if (sn != 46){
								*(idcount + x + os4) = y+1;
								/**(seqnum + x + y*lseq) = 46;*/
							}
						}
					}
				}
			}
		}
	
		*(seqhomol+x) = (*(idcount + x + os3)*(*(idcount + x + os3)-1) + *(idcount + x + os2)*(*(idcount + x + os2)-1) + *(idcount + x + os)*(*(idcount + x + os)-1) + *(idcount + x )*(*(idcount + x )-1) );
	}
	return(1);
  }


int FAR pascal CopyStringB(int xval, short int *picinfo,  unsigned char *varstring)
  {	
  	
  	//short int xpos;
	
	unsigned short int pixcol;
  	
	for (int xpos = 0;xpos < xval; xpos++){
			
			
			//pixcol=GetPixel(pict,xpos,ypos);
			//pixcol = pixcol/65536;
			//if (pixcol >=cutoff2) {
			pixcol = *(varstring + xpos)+1;
			*(picinfo + xpos+1) = pixcol;
			

	}


  	
	return(xval);
  }


int FAR pascal CopyStringC(int lenxoverseq, short int *xoverseqnum,  unsigned char *xoverseq)
  {	
  	
  	
	for(int x = 0;x<=lenxoverseq;x++){
        *(xoverseq+x) = *(xoverseqnum + x)-1;
        
                                            
     //   For a = 1 To SpacerNo
     //            XOverSeq(2 + a) = XOverSeq(2 + a) + Chr(SeqNum(XDiffPos(X), SpacerSeqs(a)) - 1) 'XDiffPos(Y) = X
     //           'Exit Sub
     //   Next a
	}
	


  	
	return(1);
  }


int FAR pascal CopyStringD(int lenxoverseq, short int *seqnum, int *xdiffpos, unsigned char *xoverseq)
  {	
  	
  	
	for(int x = 0;x<=lenxoverseq;x++){
        *(xoverseq+x) = *(seqnum + *(xdiffpos + x))-1;
        
                                            
     //   For a = 1 To SpacerNo
     //            XOverSeq(2 + a) = XOverSeq(2 + a) + Chr(SeqNum(XDiffPos(X), SpacerSeqs(a)) - 1) 'XDiffPos(Y) = X
     //           'Exit Sub
     //   Next a
	}
	


  	
	return(1);
  }

int FAR pascal HomologyWin(short int weightedflag,short int lenhsnum,short int beginning,short int ending,short int nextno, double *validsite,double *runningtotal,  short int *homologyseqnum, double *homology,double *bkghomology,double *adjustfactor)
{
	double numscore = 0;
	int x = beginning;	
	short int check = 0;
	//*(homology)= 10;
	//*(homology + 1 + 2*(nextno+1) + 3*(nextno+1)*(nextno+1)) = 10;
	//*(homology + 2 + 3*(nextno+1) + 4*(nextno+1)*(nextno+1)) = 20;

	for(int z = 0;z<=nextno;z++){
		for(int a=z+1;a<=nextno;a++){
                *(runningtotal + z + a*(nextno+1)) = 0;
				*(validsite + z + a*(nextno+1)) = 0;
                for (int y= 1 + x - beginning; y<=x+beginning;y++){
                
                
                    if( *(homologyseqnum + y + z*lenhsnum) == *(homologyseqnum +y + a*lenhsnum) && *(homologyseqnum + y + z*lenhsnum) > 64 ){
                        *(runningtotal + z + a*(nextno+1)) = *(runningtotal + z + a*(nextno+1)) +1;
                        *(validsite + z + a*(nextno+1)) = *(validsite + z + a*(nextno+1))+ 1;
					}
                    else{
						if (*(homologyseqnum + y + z*lenhsnum) > 64 && *(homologyseqnum + y + a*lenhsnum) > 64){
                        *(validsite + z + a*(nextno+1))= *(validsite + z + a*(nextno+1))+1;
						}
                    
					}
                }
                if( *(validsite + z + a*(nextno+1)) > 0){
                    *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1)) = *(runningtotal + z + a*(nextno+1)) / *(validsite + z + a*(nextno+1));
                }
				else{
                    *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1)) = 0.35;
                }
                if (weightedflag == 0){
                        *(bkghomology + x) = *(bkghomology + x) + *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1));
                        numscore++; 
				}
                else{
						*(bkghomology + x) = *(bkghomology + x) + *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1)) * ( *(adjustfactor + z)) * (*(adjustfactor + a));
                        numscore = numscore + (*(adjustfactor + z) * *(adjustfactor + a));
                        
				}
		}
	}
        
        
        *(bkghomology + x) = *(bkghomology + x)/ numscore;
       
   
   
    
   for (x = beginning+1; x <=ending;x++){
        
        numscore = 0;
        for (z = 0;z<=nextno;z++){
            for (int a = z + 1; a<=nextno; a++){
				if ( *(homologyseqnum + x - beginning + z*lenhsnum) == *(homologyseqnum + x - beginning + a*lenhsnum) && *(homologyseqnum + x - beginning + z*lenhsnum) > 65){
                    *(runningtotal + z + a*(nextno+1)) = *(runningtotal + z + a*(nextno+1)) -1;
                    *(validsite + z + a*(nextno+1)) = *(validsite + z + a*(nextno+1))- 1;   
					
					check = check+1;
				}
				else{
					if ( *(homologyseqnum + x - beginning + z*lenhsnum) > 64  &&  *(homologyseqnum + x - beginning + a*lenhsnum) > 64){// Then 'And (Mid$(HomologySeq(z), X - Beginning, 1) <> "." And Mid$(HomologySeq(a), X - Beginning, 1) <> ".") Then
						*(validsite + z + a*(nextno+1)) = *(validsite + z + a*(nextno+1))- 1;   
						
					}
					
				}
                  if ( *(homologyseqnum + x + beginning + z*lenhsnum) == *(homologyseqnum + x + beginning + a*lenhsnum) && *(homologyseqnum + x + beginning + z*lenhsnum) > 65){
						*(runningtotal + z + a*(nextno+1))= *(runningtotal + z + a*(nextno+1))+1;
						*(validsite + z + a*(nextno+1)) = *(validsite + z + a*(nextno+1))+1;  
                  }
				  else{
					if ( *(homologyseqnum + x + beginning + z*lenhsnum) > 64 &&  *(homologyseqnum + x + beginning + a*lenhsnum) > 64){// Then 'And (Mid$(HomologySeq(z), X - Beginning, 1) <> "." And Mid$(HomologySeq(a), X - Beginning, 1) <> ".") Then
						*(validsite + z + a*(nextno+1))= *(validsite + z + a*(nextno+1))+1;  
					}
                  }
                
                if( *(validsite + z + a*(nextno+1)) > 0){
                    *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1)) = *(runningtotal + z + a*(nextno+1)) / *(validsite + z + a*(nextno+1));
                }
				else{
                    *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1)) = 0.35;
                }
                if (weightedflag == 0){
                        *(bkghomology + x) = *(bkghomology + x) + *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1));
                        numscore++; 
				}
                else{
					//*(bkghomology + x) = *(bkghomology + x) + *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1) *  (*(adjustfactor + z)) *  (*(adjustfactor + a));
                        *(bkghomology + x) = *(bkghomology + x) + *(homology + z + a*(nextno+1) + x*(nextno+1)*(nextno+1)) * ( *(adjustfactor + z)) * (*(adjustfactor + a));
                        
						numscore = numscore + (*(adjustfactor + z) * *(adjustfactor + a));
                        
				}
            }
        }
        *(bkghomology + x) = *(bkghomology + x)/ numscore;
        
	}
	return(check);
}



int FAR pascal MakeSubSeqB(short int spacerno,int lenseq,short int nonspacerno,short int *seqnum,short int *rtseqs,short int *rtspacerseq)
{

for (int x = 0; x<=lenseq; x++){
	
	for(short int y=1;y<=spacerno;y++){
		//if (*(rtseqcomp + x + y * nextno) = y){
		
		   *(rtseqs + x + (y+3+nonspacerno)*(lenseq+1)) = *(seqnum + x + *(rtspacerseq+y) * (lenseq+1));
               
					
				
		//}
	   
	 }    

}        

//*(distance + 2 + 5*(nextno+1)) = 50.555; 
//*(distance + y + x*nextno) = (lenseq - count) / lenseq; 
       
return(*(seqnum + 1 + 5 * lenseq));
}


int FAR pascal MakeSubSeq(short int nextno,int lenseq,short int *seqnum,short int *rtseqs,double *rtseqcomp)
{


for (int x = 0; x<=lenseq; x++){
	for(short int y=0;y<=nextno;y++){
		if (*(rtseqcomp + y + x * (nextno+1)) == 1){
		
		   *(rtseqs + x + y * (lenseq+1)) = *(seqnum + x + y * (lenseq+1));
               
					
				
		}
	   
	 }    
	   
	   
}
        

//*(distance + 2 + 5*(nextno+1)) = 50.555; 
//*(distance + y + x*nextno) = (lenseq - count) / lenseq; 
       
return(1);
}

double FAR pascal ReverseC(int SLen,int NumberAB, int NumberXY, double *ValXY, double *OptXY, unsigned char *RecodeB, double *LaticeXY, double *TransitionM2,double *EmissionM2)
{


	//transition(numberxy-1, numberxy-1)
	//optxy(numberxy-1, numberxy-1)
	//emmision(numberab-1,numberxy-1)
	//laticeab(slen,numberxy-1)
	//laticexy(slen,numberxy-1)
	int A, B, X, off1, off2, off3;
	double MinV;

	off1 = NumberXY;
	off2 = NumberAB;
	off3 = SLen+1;
	
	for (X = SLen - 1; X >= 0; X--){
        
            for (A = 0; A < NumberXY; A++){ //first state
				for (B = 0; B < NumberXY; B++){ //second state
                    OptXY[A + B*off1] = LaticeXY[X + 1 + B*off3] + TransitionM2[A + B*off1]  + EmissionM2[RecodeB[X + 1]+ B*off2]; 
                    
                }
            }
         
            
            //ReDim ValXY(NumberXY - 1)
			for (A = 0; A < NumberXY; A++)
				ValXY[A]=0;

            for (A = 0; A < NumberXY; A++){
                MinV = -10000000000000000;
                for (B = 0; B < NumberXY; B++){
                    if (MinV < OptXY[A + B*off1]) 
                        MinV = OptXY[A + B*off1];
                    
                }
                LaticeXY[X + A*off3] = 0;
                for (B = 0; B < NumberXY; B++){
                    ValXY[B] = OptXY[A + B*off1] - MinV;
                    ValXY[B] = exp(ValXY[B]);
                    LaticeXY[X + A*off3] = LaticeXY[X + A*off3] + ValXY[B];
                    
                }
                LaticeXY[X + A*off3] = log(LaticeXY[X + A*off3]);
                LaticeXY[X + A*off3] = LaticeXY[X + A*off3] + MinV;
                
            }
            
    }
	return(1);
}


double FAR pascal GetLaticePath(int SLen, int NumberXY, double *LaticeXY, double *LaticeAB, int *LaticePath)
{

	int Y, X, off1;
	double MaxL;
	
	off1=SLen+1;

	MaxL = -10000000000000000;

	for (Y = 0; Y < NumberXY; Y++){
        
        if (LaticeXY[SLen + Y*off1] > MaxL){
            MaxL = LaticeXY[SLen + Y*off1];
            LaticePath[SLen] = (int)(LaticeAB[SLen + Y*off1]);
        }
        
    }
    
    for (X = SLen - 1; X >=0; X--){
        //for (Y = 0; Y< NumberXY; Y++)
                
                LaticePath[X] = (int)(LaticeAB[X + LaticePath[X + 1]*off1]);
               
		
    }
	return(MaxL);
}

double FAR pascal UpdateCounts(int SLen, int NumberABC, int NumberXY, int *LaticePath, unsigned char *RecodeB, double *TransitionCount, double *StateCount)
{

	//statecount(numberabc-1, numberxy)
	//transitioncount(numberxy-1,numberxy-1)
	int Z, off1,off2;

	off1 = NumberXY;
	off2 = NumberABC;
	for (Z = 0; Z < SLen; Z++)
            TransitionCount[LaticePath[Z] + LaticePath[Z + 1]*off1] = TransitionCount[LaticePath[Z] + LaticePath[Z + 1]*off1] + 1;
            

	
    for (Z = 0; Z <= SLen; Z++)
            StateCount[RecodeB[Z] + LaticePath[Z]*off2] = StateCount[RecodeB[Z] + LaticePath[Z]*off2] + 1;
	
	return(1);
}




double FAR pascal ForwardC(int SLen,int NumberAB, int NumberXY, double *ValXY, double *OptXY, unsigned char *RecodeB, double *LaticeXY, double *TransitionM2,double *EmissionM2)
{


	//transition(numberxy-1, numberxy-1)
	//optxy(numberxy-1, numberxy-1)
	//emmision(numberab-1,numberxy-1)
	//laticeab(slen,numberxy-1)
	//laticexy(slen,numberxy-1)
	int A, B, X, off1, off2, off3;
	double MinV;

	off1 = NumberXY;
	off2 = NumberAB;
	off3 = SLen+1;
	
	for (X = 1; X <= SLen; X++){
        
            for (A = 0; A < NumberXY; A++){ //first state
				for (B = 0; B < NumberXY; B++){ //second state
                    OptXY[A + B*off1] = LaticeXY[X - 1 + A*off3] + TransitionM2[A + B*off1]  + EmissionM2[RecodeB[X]+ B*off2]; 
                    
                }
            }
         
            
            //ReDim ValXY(NumberXY - 1)
			for (A = 0; A < NumberXY; A++)
				ValXY[A]=0;

            for (A = 0; A < NumberXY; A++){
                MinV = -10000000000000000;
                for (B = 0; B < NumberXY; B++){
                    if (MinV < OptXY[B + A*off1]) 
                        MinV = OptXY[B + A*off1];
                    
                }
                LaticeXY[X + A*off3] = 0;
                for (B = 0; B < NumberXY; B++){
                    ValXY[B] = OptXY[B + A*off1] - MinV;
                    ValXY[B] = exp(ValXY[B]);
                    LaticeXY[X + A*off3] = LaticeXY[X + A*off3] + ValXY[B];
                    
                }
                LaticeXY[X + A*off3] = log(LaticeXY[X + A*off3]);
                LaticeXY[X + A*off3] = LaticeXY[X + A*off3] + MinV;
                
            }
            
    }
	return(1);
}

double FAR pascal ViterbiC(int SLen,int NumberAB, int NumberXY, double *OptXY, unsigned char *RecodeB, double *LaticeXY, double *TransitionM2,double *EmissionM2, double *LaticeAB)
{


	//transition(numberxy-1, numberxy-1)
	//optxy(numberxy-1, numberxy-1)
	//emmision(numberab-1,numberxy-1)
	//laticeab(slen,numberxy-1)
	//laticexy(slen,numberxy-1)
	int A, B, X, off1, off2, off3, offa, offa2;
	
	off1 = NumberXY;
	off2 = NumberAB;
	off3 = SLen+1;
	for (X = 1; X <= SLen; X++){
        
		for (A = 0; A < NumberXY; A++){ //first state
			offa = X-1+A*off3;
			for (B = 0; B < NumberXY; B++){ //second state
                    OptXY[A + B*off1] = LaticeXY[offa] + TransitionM2[A + B*off1] + EmissionM2[RecodeB[X] + B*off2];
                    
                    
                   
            
			}
		}
           
            
            
        for (A = 0; A < NumberXY; A++){ //first state
            offa=X+A*off3;
			offa2 = A*off1;
			LaticeXY[offa] = -10000000000000000;
            for (B = 0; B < NumberXY; B++){ //second state
                if (LaticeXY[offa] < OptXY[B + offa2]){
                    LaticeXY[offa] = OptXY[B + offa2];
                    LaticeAB[offa] = B;
                }
            }
        }
            
	}
	return(1);
}


int FAR pascal MakeSubSeqC(short int nextno,int lenseq,short int *seqnum,short int *rtseqs,char *rtseqcomp,short int *currentxover)
{

	for(short int y=0;y<=nextno;y++){
		if (*(currentxover + y) > 0){
			for (int x = 0; x<=lenseq; x++){
			
				if (*(rtseqcomp + y + x * (nextno+1)) == 1){
				
				   *(rtseqs + x + y * (lenseq+1)) = *(seqnum + x + y * (lenseq+1));
               
							
						
				}
			   
			 }    
		}
		else{
			for (int x = 0; x<=lenseq; x++){
			
				
				
				   *(rtseqs + x + y * (lenseq+1)) = *(seqnum + x + y * (lenseq+1));
               
							
						
				
			   
			 }    
		
		}
		   
	}
        

//*(distance + 2 + 5*(nextno+1)) = 50.555; 
//*(distance + y + x*nextno) = (lenseq - count) / lenseq; 
       
return(1);
}


float FAR pascal ShortestDist(int nextno, int sortedno, float *distancebak,short int *treex,short int *treey)
{
float ShortestDistance = 1;
int x,y,xoff, os2;
os2 = nextno+1;    
    for (x = 0; x<nextno; x++){
		xoff = x*os2;
        for (y = x + 1; y<=nextno; y++){
            if(distancebak[y + xoff] < ShortestDistance){
                ShortestDistance = distancebak [y + xoff];
                treex[sortedno] = x;
                treey[sortedno] = y;
			}
        }
    }

return(ShortestDistance);
}


int FAR pascal UpdateDistMapX(int X, int Z, int Nextno, float *DistMap, float *NJSubDistance, int *WinningX){

	int A, Y,os1, os2;
	os1 = Nextno+1;
	for (Y = 0; Y<= Nextno; Y++){
		os2 = os1*Y;
        if (X != Y && Z != Y){
            if (DistMap[X] > NJSubDistance[X + os2]){
                DistMap[X] = NJSubDistance[X + os2];
                WinningX[X] = Y;
            }
            //recalculate affected distmap entries
            if (WinningX[Y] == X || WinningX[Y] == Z ){
                if (DistMap[Y] < 100){
                    DistMap[Y] = 100;
                    for (A = 0; A <= Nextno; A++){
                        if (A != Y){
                            if (DistMap[Y] > NJSubDistance[A + os2]){
                                DistMap[Y] = NJSubDistance[A + os2];
                                WinningX[Y] = A;
							}
                        }
                    }
                }
			}
            
        }
                
	}

	return(1);
}


int FAR pascal MakeDistMapX(int Nextno, float *DistMap, float *NJSubDistance, int *WinningX){


	int X, Y, os1;

	os1 = Nextno+1;
	for (X = 0; X<= Nextno; X++)
		DistMap[X] = 100;
        
    
    for (X = 0; X <= Nextno; X++){
        for (Y = X + 1; Y<= Nextno; Y++){
            if (DistMap[X] > NJSubDistance[X + Y*os1]){
                DistMap[X] = NJSubDistance[X + Y*os1];
                WinningX[X] = Y;
            }
            if (DistMap[Y] > NJSubDistance[X + Y*os1]) {
                DistMap[Y] = NJSubDistance[X + Y*os1];
                WinningX[Y] = X;
            }
            
        }
        
    }


	return(1);
}


float FAR pascal ShortestDistB(int nextno, int sortedno, float *OldX, int *WinningX, float *distancebak,short int *treex,short int *treey)
{
	float ShortestDistance, MinDist ;
	int x,xoff, os2, winx;
	os2 = nextno+1; 
	MinDist = (float)(1);
	ShortestDistance = (float)(1);
	
	winx=0;
    for (x = 0; x<=nextno; x++){
		if (OldX[x] < MinDist){
			MinDist = OldX[x];
			winx=x;
		}
		
	}	
	xoff = winx*os2;
	if (MinDist <1){
	
		ShortestDistance = distancebak [WinningX[winx] + xoff];
		if (winx < WinningX[winx]){
			treex[sortedno] = winx;
			treey[sortedno] = WinningX[winx] ;
		}
		else{
			treex[sortedno] = WinningX[winx] ;
			treey[sortedno] = winx;

		}
			
	}
	else 
		ShortestDistance = MinDist;
    

return(ShortestDistance);
}


int FAR pascal MakeDistanceBak(int UBD, int UBDB, int Nextno, float *Distance, float *DistanceBak){
	int X, Y, osd, osdb,os1;
	float td;
	osd = UBD+1;
	osdb = UBDB+1;

	for (X = 0; X < Nextno; X++){
		os1 = X*osd;
        for (Y = X + 1; Y <= Nextno; Y++){
            td = Distance[Y+os1];
            if (td > 0){
				td=1-td;
                DistanceBak[X + Y*osdb] = td;
                DistanceBak[Y + X*osdb] = td;
                
			}
            else{
                DistanceBak[X + Y*osdb] = (float)(0.999);
                DistanceBak[Y + X*osdb] = (float)(0.999);
                
            }
        }

    }



	return(1);
}

int FAR pascal TreeDist2(int Nextno, short int *TreeX, short int *TreeY, float *TreeDistance){
	int X, Y, Z, A;
	int tx,ty, tz, ta;
	tx=0;
	for (X = Nextno - 1; X >= 0; X--){
		ty = TreeY[X];
		for (Y = 1; Y <= Nextno; Y++){
			tx = TreeX[X + Y*(Nextno+1)];
			if (tx > -1){
				if (tx == ty)
					break;

                TreeDistance[tx + ty*(Nextno+1)] = TreeDistance[TreeX[X] + ty*(Nextno+1)];
                TreeDistance[ty + tx*(Nextno+1)] = TreeDistance[tx + ty*(Nextno+1)];
			}
            else
				break;
		}
		if (tx > -1) {
			for (Z = Y + 1; Z <= Nextno; Z++){
				tz = TreeX[X + Z*(Nextno+1)];
				if (tz > -1){
					for (A = 0; A < Y; A++){
						ta = TreeX[X + A*(Nextno+1)];
						TreeDistance[tz + ta*(Nextno+1)] = TreeDistance[TreeX[X] + ty*(Nextno+1)];
						TreeDistance[ta + tz*(Nextno+1)] = TreeDistance[tz + ta*(Nextno+1)];
					}
				}
                else
					break;
			}
		}
	}
	return(1);
}

double FAR pascal TreeDist(int nextno, float *treedistance,double *nodelength,short int *treex)
{

int x,y,z,a,b,xoff,yoff;


short int efflag=0;
	for (x = 0; x<=nextno; x++){
			xoff = x*(nextno+1);
            for (y = x+1; y<=nextno; y++){
				yoff =  y*(nextno+1);
                for (z = 0; z<=nextno; z++){
					
                    for ( a = 0; a<=nextno; a++){
						//aoff = a*(nextno+1);
                        if (*(treex + z + a*(nextno+1)) == x){ 
                            for ( b = a+1; b<=nextno; b++){
                                if (*(treex + z + b*(nextno+1)) == y){
					
                                    *(treedistance + (x + yoff)) = (float)((1 - *(nodelength + z)));
                                    *(treedistance + (y + xoff)) = (float)((1 - *(nodelength + z)));
                                    efflag = 1;
                                    break;
                                }
                            }
                            if (efflag == 1 ){ 
								break;
						
							}
						}
						else if(*(treex + z + a*(nextno+1)) == y){ 
								for ( b = a+1; b<=nextno; b++){
									if( *(treex + z + b*(nextno+1)) == x ){
										*(treedistance + (x + yoff)) = (float)((1 - *(nodelength + z)));
										*(treedistance + (y + xoff)) = (float)((1 - *(nodelength + z)));
										efflag = 1;
										break;
									}
								}
                       
                            
								if (efflag == 1 ){
									break;
							
								}
						}
					
						else if(*(treex + z + a*(nextno+1)) == -1){
									//efflag = 1;
									break;
							
						}
						
                        if (efflag == 1){ 
							break;
						}
                    }
                    if (efflag == 1){
						efflag = 0; 
						break;
					}
				}
			}
        
	}

return(1);
}


int FAR PASCAL WEP( int bSystemExit )
  {                               // DLL exit procedure
  return 1;
  }