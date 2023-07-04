// Header file for mathfun8 DLL
// This file should be copied to the c:\tcwin\include library with
// a file name of mathfun8.h

#ifndef __mathfun8
#define __mathfun8

#include <windows.h>



typedef struct node {
  struct node *next, *back;
  boolean tip;
  long number;
  short int nayme;
  float v;
  long xcoord, ycoord, ymin, ymax;
} node;

typedef struct tree {
  node **nodep;
  node *start;
} tree;

typedef struct XOVERDEFINE{
	unsigned char OutsideFlag;
    unsigned char  MissIdentifyFlag;
    unsigned char  ProgramFlag;
    unsigned char  SBPFlag;
    unsigned char  Accept;
	short int MajorP;
    short int MinorP;
    short int Daughter;
	int Beginning;
    int Ending; 
    int LHolder;
	int Eventnumber;
	float PermPVal;
    float BeginP; 
    float EndP;
    double Probability;
    double DHolder;

}XOVERDEFINE;

typedef struct POINTAPI{
    int XPos;
    int Y;
}POINTAPI;


//typedef struct tagLOGPEN { 
//    UINT     lopnStyle; 
//   POINT    lopnWidth; 
//    COLORREF lopnColor; 
//} LOGPEN, *PLOGPEN;

//extern "C" int FAR pascal  ThresholdPict(HDC pict,short int xval,short int yval,short int cutoff2,short int cutoff,short int *picinfo) ;
extern "C" int FAR pascal GetDScore(int NumTaxa, int i, int J, int *SqScore, short int *char_alignment, unsigned char *PairsMatrix);
extern "C" int FAR pascal get_f_and_g(unsigned char *inc_matrix,int *num_states,int num_chars, double *f_values,double *g_values);
extern "C" int FAR pascal FillIncMatrix(int i, int num_inf, int NumTaxa, int *inf_states,unsigned char *PairsScores, short int *char_alignment, unsigned char *PairsMatrix, int *SqScore, unsigned char *inc_matrix);
extern "C" int FAR pascal MakeStateMap(int num_taxa,int J, int UBSN1, short int *SeqNum, int *state_map,  int *gap_char);
extern "C" int FAR pascal pair_score( short int *alignment,  int *site_states,int char_a, int char_b, int num_sites, int num_taxa);
extern "C" int FAR pascal pair_score2( short int *alignment,  int *site_states,int char_a, int num_sites, int num_taxa, int *inc_matrix);
extern "C" int FAR pascal CopyColumn(int UBNA, int UBSN, int num_taxa, int site_count, short int *SeqNum, unsigned char *new_alignment);

extern "C" int FAR pascal MakeNewAlignment(int UBNA, int UBA, int *state_map, unsigned char *Alignment, short int *new_alignment);

extern "C" int FAR pascal  SeqMatrixCopy(short int nextno,short int groupnumber,double *seqmatrix,double *seqmatrixbak) ;
   ;
//extern "C" int FAR pascal  ThresholdChlorotic(HDC pict,short int xval,short int yval,short int cutoff2,short int cutoff,short int *picinfo) ;
//extern "C" int FAR pascal  ThresholdHealthy(HDC pict,short int xval,short int yval,short int cutoff2,short int *picinfo) ;

//extern "C" int FAR pascal  ThresholdBkgUp(HDC pict,short int xval,short int yval,short int ocutoff2,short int cutoff2,short int *picinfo) ;
//extern "C" int FAR pascal  ThresholdBkgDown(HDC pict,short int xval,short int yval,short int ocutoff2,short int cutoff2,short int *picinfo) ;
extern "C" int FAR pascal  SeqMatrixMan1(short int nextno, short int seqnumber, short int groupnumber,short int level,double discrepancy, int *numingroup, short int *seqcode,double *seqmatrix);
//extern "C" int FAR pascal  AdjThresholdDown(HDC pict,short int xval,short int yval, int ocutoff, int cutoff,short int *picinfo) ;
extern "C" int FAR pascal  SeqMatrixMan2(short int nextno, short int seqnumber, short int groupnumber,short int level,double discrepancy, int *numingroup, short int *seqcode,double *seqmatrix);
extern "C" int FAR pascal ShiftDown(short int diffspace,int lseq,short int lastdim,short int lastend, short int *parray);
extern "C" int FAR pascal ShiftUp(short int diffspace,int lseq,short int lastdim,short int lastend, short int *parray);
extern "C" int FAR pascal CopyArray3(short int lseq,short int lastdim,short int lastend, short int offsetp,short int offsett, short int *parray, short int *tarray);
extern "C" int FAR pascal FillArray(short int fillval,int rbegin,int utarget,int lseq,short int spos, short int *parray,short int *maxspos);
extern "C" int FAR pascal FillArray2(double a, int fillval,int rbegin,int utarget,int lseq,int spos, short int *parray,short int *maxspos);
extern "C" int far pascal FillArray3(int LCA, float fv, float *CurveArray);

extern "C" int FAR pascal CurveRight(int LCA, int ZoomR, int PosX, float SWin, float IncX2, float XFactor, float PZ2, float XF2, float *CurveArray);
extern "C" int FAR pascal CurveLeft(int ZoomL, int PosX, float SWin, float IncX, float XFactor, float PZ2, float XF2, float *CurveArray);
extern "C" int FAR pascal CurveMid(int LCA, int ZoomR, float AddjV, float HSWin2, float *CurveArray);

extern "C" int FAR pascal DrawDiffsC(int SP, int EP, int UBTS, float MaxTS, int UBID1, int UBID2,  float *Teststrip, unsigned char *ImageData);
extern "C" int FAR pascal DrawDiffsD(int Z, int BkR, int BkG, int BkB, int SP, int EP, int UBTS, float MaxTS, int UBID1, int UBID2,  int *ColAdj, float *Teststrip, unsigned char *ImageData);

extern "C" int FAR pascal MakeTestStrip(int UBX, float XFactor, int *XDiffPos, float *Teststrip) ;


extern "C" int FAR pascal GetPltValX (int B, int BSCBootReps, float *DstMat, double *PltVal);

extern "C" int FAR pascal FindSlot(int rbegin,int utarget,short int spos, short int *maxspos);
extern "C" int FAR pascal ReFindSlot(double a,int fs,int lseq,int rbegin,int utarget,short int spos, short int *parray,short int *maxspos);
extern "C" double FAR pascal SEQBOOT2 (int nseed,short int bsbootreps, int bsstepwin,short int *scratch, int *weightmod);
//double FAR pascal SEQBOOT2          (int nseed,short int bsbootreps, int bsstepwin,short int *scratch, int *weightmod)


extern "C" double FAR pascal TransferDist(int NSeqs, int cr, int Reps, float *tFMat, float *DstMat);
//double FAR pascal TransferDist         (int NSeqs, int cr, int Reps, float *tFMat, float *DstMat){


extern "C" int FAR pascal MaketSeqNum(int lseq, int NextNo, short int *tSeqNum2, short int *SeqNum, float *FMat);
//int FAR pascal MaketSeqNum(         int lseq, int NextNo, short int *tSeqNum2, short int *SeqNum, float *FMat){


extern "C" int FAR pascal MakeETSeqNumX(int NextNo,int lseq, int tlseq, int rs, int RE, short int *ETSeqNum, short int *TreeSeqNum);
//int FAR pascal MakeETSeqNumX(         int NextNo,int lseq, int tlseq, int rs, int RE, short int *ETSeqNum, short int *TreeSeqNum){


extern "C" int FAR pascal MakeSDM(int NextNo, int SLen, int *SP, int *EP, int *ISeqs, int *CompMat, unsigned char *MissingData, short int *SeqNum, double *SDM, double *DistMat);
extern "C" double FAR pascal FastBootDist(int df, int reps, int nextno,int lenseq,float *diffsx,float *validx,int *weightmod, short int *seqnum,float *distance);
extern "C" double FAR pascal FastBootDistI(int df, int reps, int nextno,int lenseq,float *diffsx,float *validx,int *weightmod, short int *seqnum,float *distance, int *IdenticalF, int *IdenticalR);

extern "C" double FAR pascal FastBootDistX(int df, int reps, int nextno,int lenseq,float *diffsx,float *validx,int *weightmod, short int *seqnum,float *distance);
extern "C" int FAR pascal CleanSCMat (int Nextno, int UBFM, int UBFC, float *FCMat, float *SCMat, float *FMat);
extern "C" int FAR pascal MakeImageData(int SX,int SY, int PosE1, int PosE0, int PosS1, int PosS0, int StS, int StSX, int CurScale, float XAD, float Min, float MR, int UBID1, int UBID2, int UBID3, int UBRM1, int UBHM1, int *HeatMap, float *RegionMat, unsigned char *ImageData);

//double FAR pascal FastBootDist         (int df, int reps, int nextno,int lenseq,float *diffsx,float *validx,int *weightmod, short int *seqnum,float *distance)

extern "C" int FAR pascal MakeIdentical0(int LSeq, int CountVSites, unsigned char *Identical0,unsigned char *StrainSeq, unsigned char *TempBig);


extern "C" int FAR pascal  CopyArray(short int xval,short int yval, short int *picinfo,short int *picinfobak) ;
extern "C" int FAR pascal  CopyArray2(short int xval,short int yval, short int *picinfo,short int *picinfobak) ;

extern "C" int FAR pascal  SeqMatrixMan3(short int nextno, short int seqnumber, short int groupnumber,short int level,double discrepancy, int *numingroup, short int *seqcode,double *seqmatrix);
//extern "C" int FAR pascal  LeafThresh(HDC pict,short int xval,short int yval, short int xpos,short int ypos, short int leafno,short int cutoff2,short int cutoff, short int *picinfobak,long *leaf);
extern "C" int FAR pascal LeafHistoSort(short int leafno, long leaftot,long *leafhisto,long double *leafhistop);
extern "C" int FAR pascal MakeOLSeqB(int BE, int en, int lseq, char *OLSeq);
extern "C" int FAR pascal CheckPatternX(int NextNo, int LSeq, int *ISeqs, int *ST, int *en, short int *SeqNum, double *Pattern, char *DonePattern);
extern "C" int FAR pascal MakeMatchMatX(int LSeq, int NextNo, int X, char *ContainSite, float *SMat, float *MatchMat,float *BMatch, int *BPMatch, short int *SeqNum, int *iseqs);

 extern "C"  int FAR pascal DoSetsA( int SZ1, int lseq, int *RI,char *OLSeq, char *Sets, char *doit);
 extern "C"   int FAR pascal DoSetsB(int SZ1, int lseq, int *RI,char *OLSeq);
extern "C" int FAR pascal CollapseNodesX(int NextNo, float CutOff, int *T, float *DLen, float *CMat, float *AMat, float *TraceBak);
//int FAR pascal CollapseNodesX         (int NextNo, double CutOff, int *T, float *DLen, float *CMat, float *AMat, float *TraceBak){


extern "C" int FAR pascal  LeafThresh2(HDC pict,short int xval,short int yval, short int xpos,short int ypos, short int leafno,short int cutoff2,short int cutoff, short int *picinfobak,long *leaf);
extern "C" int FAR pascal  LeafThresh3(HDC pict,short int xval,short int yval, short int xpos,short int ypos, short int cutoff2,long col, short int *picinfobak);
extern "C" int FAR pascal  LeafThresh4(HDC pict,short int xval,short int yval, short int xpos,short int ypos, short int cutoff2,long col, short int *picinfobak);

extern "C" int FAR pascal  Histogram(short int xval,short int yval, short int *picinfo,int *pixels);
extern "C" int FAR pascal  InvertBkg(short int xval,short int yval, short int *picinfo);
extern "C" int FAR pascal  ModPermArray(int Frm1Pic5ScaleWidth, int ub, int LastDim, int SPos, int B, short int *PermArray, short int *TempArray);
 
extern "C" int FAR pascal  WedgeThresh(HDC pict,short int xval,short int yval,short int xpos,short int ypos, short int correction, short int wedgecutoff, short int *picinfobak,long *wedgeseg);
extern "C" int FAR pascal  SearchArray(short int xval,short int yval, short int *picinfo);
//extern "C" int FAR pascal  FindWedge(short int xval,short int yval,short int *picinfo,short int *wedegx) ;
extern "C" int FAR pascal  SeqTally(short int nextno, short int seqnumber, short int groupnumber,short int level,double *tally, int *numingroup, short int *seqcode,double *seqmatrix);
extern "C" int FAR pascal  CopyString(int xval,short int *picinfo, unsigned char *varstring, int *numspaces);
extern "C" int FAR pascal  CopyStringB(int xval,short int *picinfo, unsigned char *varstring);
extern "C" int FAR pascal  CopyStringC(int lenxoverseq, short int *xoverseqnum,  unsigned char *xoverseq);
extern "C" int FAR pascal  CopyStringD(int lenxoverseq, short int *seqnum,int *xdiffpos, unsigned char *xoverseq);
extern "C" double FAR pascal DistanceCalcF(short int seq1, short int seq2, short int seq3,  short int nextno,int lenseq,int beginning,int ending,double ahomol, short int *seqnum,float *dst, float *bkghomol);
extern "C" double FAR pascal SEQBOOT (int nseed, short int bsbootreps, int bsstepwin,short int *scratch, int *weightmod);
extern "C" int FAR pascal SeqWrite(HDC pict,short int nextno,short int fraglen,short int seqlen, short int winleft,const char *seqnum);
extern "C" int FAR pascal FindSubSeq(int *ah,short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, int nextno,int seq1,int seq2,int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,char *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff,short int *validspacer);
extern "C" int FAR pascal FindSubSeqIV(int *ah,short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, int nextno,int seq1,int seq2,int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,char *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff,short int *validspacer, unsigned char *binarray);
extern "C" int FAR pascal MakeBinArray(int Seq1, int LSeq, int NextNo, short int *MaskSeq, short int *SeqNum, unsigned char *BinArray);
extern "C" int FAR pascal MakeBinArray2(int Seq1, int LSeq, int Nextno, short int *Maskseq, short int *SeqNum, unsigned char *BinArray,int *slookupnum, int *slookup, unsigned char *isin, int *tracesub, int *actualsize, int MinSeqSize);

extern "C" int FAR pascal FindSubSeqFaster(int UBIS4, int *ah, short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, int nextno,int seq1,int seq2,int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,char *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff, short int *validspacer, short int ISEQ4);

extern "C" int FAR pascal FindSubSeq2(short int spacerflag,short int outlyer, short int xoverwindow,int lenseq, short int nextno,short int seq1,short int seq2,short int seq3, short int spacerno, short int *seqnum, short int *xoverseqnum,short int *xoverseqnumw,short int *spacerseqs,int *xdiffpos,int *xposdiff, short int *validspacer);
extern "C" int FAR pascal FindSubSeqB(int lenseq, short int nextno, short int seq1,short int seq2,short int seq3,short int *seqnum,int *xdiffpos,int *xposdiff);
extern "C" int FAR pascal FindSubSeqC(int lenseq, short int nextno, short int seq1,short int seq2,short int seq3,short int *seqnum,int *xdiffpos,int *xposdiff);
extern "C" int FAR pascal FindSubSeqD(int lenseq, short int nextno, short int seq1,short int seq2,short int seq3,short int *seqnum,int *xdiffpos,int *xposdiff);

extern "C" double FAR pascal DNADIST(double cvi, double ttratio, short int tbff,short int tmodel, double tafreq, double tcfreq,double tgfreq,double ttfreq, int numsp, int sites, short int *seqnum,int *alias, int *ally, int *weight, int *location, short int *px,short int *xx1, short int *xx2, double *prod, double *prod2, double *prod3, float *dmat);
//double FAR pascal DNADIST         (double cvi, double ttratio, short int tbff,short int tmodel, double tafreq, double tcfreq,double tgfreq,double ttfreq, int numsp, int sites, short int *seqnum,int *alias, int *ally, int *weight, int *location, short int *px,short int *xx1, short int *xx2, double *prod, double *prod2, double *prod3, float *dmat)


extern "C" int FAR pascal MakeV (double cvi,double fracchange, double xv,short int tmodel, int numsp, int sites, int endsite,int *weight,short int *xx1, short int *xx2, short int *px, double *prod, double *prod2, double *prod3, double *dmat);
extern "C" int FAR pascal BootDist(short int bootreps, double cvi, double ttratio, short int tmodel, int numsp, int sites, short int *seqnum,int *alias, int *ally, int *weight, int *location, short int *px,short int *xx1, short int *xx2, double *prod, double *prod2, double *prod3, float *dmat, double *vv, int *num1, int *num2, int *denominator, double *numerator, int *wmod);
//int FAR pascal BootDist         (short int bootreps, double cvi, double ttratio, short int tmodel, int numsp, int sites, short int *seqnum,int *alias, int *ally, int *weight, int *location, short int *px,short int *xx1, short int *xx2, double *prod, double *prod2, double *prod3, float *dmat, double *vv, int *num1, int *num2, int *denominator, double *numerator, int *wmod)
extern "C" int FAR pascal CheckEnds(int LS, int RL, int LSS, int ChF, int CirF, int Seq1, int Seq2, int Seq3, int BPos , int EPos , short int *SeqNum , int *XPD, int *XDP, unsigned char *MissingData);
extern "C" int FAR pascal CalcHits(int WinPP, int LS, int CTest, int BPos2, int EPos2, int UBSN, int UBCM, short int *SeqNum, int *ISeqs, int *CompMat, float *Hits, float *Tots);
extern "C" int FAR pascal GoLeft(int Seq1, int Seq2, int Seq3, int CircularFlag, int startpos, int LS, int UBMD, unsigned char *MissingData);

extern "C" int FAR pascal GoRight(int Seq1, int Seq2, int Seq3, int CircularFlag, int startpos, int LS, int UBMD, unsigned char *MissingData);

extern "C" int FAR pascal NEIGHBOUR(short int njoin, short int jumble,  int nseed, int outgrno, int numsp,  float *x, char *ot, float *coltotals, float *tarray);
//int FAR pascal NEIGHBOUR         (short int njoin, short int jumble,  int nseed, int outgrno, int numsp,  float *x, char *ot, double *coltotals, float *tarray)


extern "C" int FAR pascal NEIGHBOUR2(short int njoin, short int jumble,  int nseed, int outgrno, int numsp,  float *x, char *ot, double *coltotals, float *tarray);
extern "C" int FAR pascal GetColPix(int CurScale, int Y, int Pict, float PosS0, float PosS1, float XAddj, int PosE, int StSX, int X, int UBRM, int UBHM, float Min, float *RegionMat, int *ColPix, int *HeatMap);
extern "C" int FAR pascal GetColPix2(float Band, int *XDP, int *ZDP, int CurScale, float MR, int Y, HDC Pict, float PosS0, float PosS1, float XAddj, int PosE, int StSX, int X, int UBRM, int UBHM, float Min, float *RegionMat, int *ColPix, int *HeatMap);

extern "C" int FAR pascal JCDist(short int bootreps, short int jcflag,short int nextno,int lenseq,short int *seqnum,double *dmat,int *wmod, int *count, int *valid);
extern "C" int FAR pascal MakeSubAlign(int nextno, int lenseq, int winnum, int stepsize, int winsize, short int *tseqnum, short int *seqnum);

extern "C" int FAR pascal SingleToInt(int s1, int s2, short int bootreps, int nextno,float *in, short int *out);
//int FAR pascal          SingleToInt(int s1, int s2, short int bootreps, int nextno,float *in, short int *out){


extern "C" int FAR pascal GetPltVal(short int bootreps, int y, short int *t0, short int *t1, short int *t2, double *pltval);
//extern "C" double FAR pascal TreeToArray (short int nlen2, int nextno, int treelen, short int *sholder, double *tmat, int *rootnode);

extern "C" double FAR pascal TreeToArray (short int nlen2, int nextno, int treelen, char *sholder, float *tmat,int  *nodeorder, int *donenode, int *tempnodeorder, int *rootnode, double *nodelen, double *numdone);
//double FAR pascal TreeToArray          (short int nlen2, int nextno, int treelen, char *sholder, float *tmat,int  *nodeorder, int *donenode, int *tempnodeorder, int *rootnode, double *nodelen, double *numdone){
//double FAR pascal TreeToArray          (short int nlen2, int nextno, int treelen, char *sholder, float *tmat,int  *nodeorder, int *donenode, int *tempnodeorder, int *rootnode, double *nodelen, double *numdone){


extern "C" double FAR pascal TreeToArrayB (short int nlen2, int nextno, int treelen, short int *sholder, float *tmat,int  *nodeorder, int *donenode, int *tempnodeorder, int *rootnode, double *nodelen);
//double FAR pascal TreeToArrayB          (short int nlen2, int nextno, int treelen, short int *sholder, float *tmat,int  *nodeorder, int *donenode, int *tempnodeorder, int *rootnode, double *nodelen){

//extern "C" int FAR pascal FITCH(short int lflag,short int userfitchtree, short int gflag,short int nbranchflag, short int jumblef,  int nseed, int outgrno, int numsp,  double *x, short int *ot);
extern "C" int FAR pascal ScanPositive (int winnum, double bscutoff   , int cocount, int x , int y, int numberofseqs, short int bootreps, int *goona, int *goonb, char *orderarray, float *dsmat);
//int FAR pascal          ScanPositive (int winnum, double bscutoff   , int cocount, int x , int y, int numberofseqs, short int bootreps, int *goona, int *goonb, char *orderarray, float *dstmat)


extern "C" int FAR pascal SpacerFindB(short int Nextno, short int SpacerFlag, double MiDistance, double MaDistance, short int Seq1,short int Seq2,short int Seq3, short int *OL,short int *SN, float *TreeDistance, float *Distance, short int *MaskSeq, short int *SpacerSeqs, short int *ValidSpacer);
//int FAR pascal          SpacerFindB(short int Nextno, short int SpacerFlag, double MiDistance, double MaDistance, short int Seq1,short int Seq2,short int Seq3, short int *OL,short int *SN, float *TreeDistance, float *Distance, short int *MaskSeq, short int *SpacerSeqs, short int *ValidSpacer)

extern "C" int FAR pascal FindNext(int StartPosX,int HighHomol,int MedHomol, int LowHomol, int LenXoverSeq, int xoverwindow,int *XOverHomologyNum);
extern "C" int FAR pascal TreeGroupsX(int NextNo, char *THolder, int TLen, int NLen, char *DoneNode,char *TArray, char *TMatch, float *DLen);
//int FAR pascal TreeGroupsX         (int NextNo, char *THolder, int TLen, int NLen, char *DoneNode,char *TArray, char *TMatch, float *DLen){


extern "C" int FAR pascal MakeSubSeqPerm(int LS, int D, int P1, int P2, short int *PermSeqNum,int *XDiffPos,int *XPosDiff);

extern "C" int FAR pascal MakeRecCMatrix(int LS, int RSize,int ST, int EN, int *SCMatrix, float *RegionMat);
extern "C" int FAR pascal MakeHeatPlot (double MaxN,int UBHM, int CS,HDC pict,int RSize, double XAddj, int *HeatMap, double *RegionMat);
extern "C" int FAR pascal MakeVarMap(int NextNo, int LS, short int *SeqNum, char *VarSiteMap, int *VRPos, int *VXPos, int *ISeqs, int *CompMat);
extern "C" int FAR pascal MakeVarMap2(int NextNo, int LS, int UBVSM, short int *SeqNum, short int *VarSiteMap, int *VRPos, int *VXPos, int *ISeqs, int *CompMat);
extern "C" int FAR pascal FillSets(int UBS, int UBRL, int *RNum, int *RI, int *RList, unsigned char *Sets);
extern "C" int FAR pascal FindBesSeqSF(int Nextno, int *ListToRedo, float  *SMat, float *FMat, int *BestSeqS,int *BestSeqF);
extern "C" int FAR pascal ReAddDists(int Nextno, int *ListToRedo, float *SAMat, float *FAMat,float *SCMat, float *FCMat, int *BestSeqS, int *BestSeqF);

extern "C" int FAR pascal MakeDistanceBakB(int Nextno, int UBDB, int UBD, float *Distance, float *distancebak);
extern "C" int FAR pascal CopyFloatArray(int Nextno, int UBDB, int UBD, float *Distance, float *distancebak);

extern "C" int FAR pascal MakeTots(int Nextno, int UBF, float *Tot, float *FMat, float *SMat, unsigned char *DontUse);
extern "C" int FAR pascal MakeDI(int Nextno, int UBDT, int UBF, float *DI, float *FMat, float *SMat, int *DoneThis);
extern "C" int FAR pascal FinishDists2(int Nextno, float *PermValid, float *PermDiffs, float *TValid, float *TDiffs, float *Distance);
extern "C" int FAR pascal GetCoRec(int X, int PermNextno, int UBD, unsigned char *Daught);


extern "C" int FAR pascal MakeCntHit(int BPos, int EPos, int SWinx, int NextNo, int LenVarSeq, int LS, double *CntHit, unsigned char *VarSiteMap, float *VarSiteSmooth, int *VRPos);
extern "C" int FAR pascal MakeCntHit2(int BPos, int EPos, int SWinx, int NextNo, int LenVarSeq, int LS, int UBVSM, double *CntHit, short int *VarSiteMap, float *VarSiteSmooth, int *VRPos);

extern "C" double FAR pascal FindMaxN(int RSize,  double *RegionMat);
extern "C" float FAR pascal FindMaxNS(int RSize,  float *RegionMat);


extern "C" int FAR pascal XOHomologyB(int seq1,int seq2,int seq3, short int inlyer, int lenseq,int lenxoverseq,short int xoverwindow, double *xoverhomologynum, short int *seqnum,double *avhomol, int *xdiffpos);
extern "C" int FAR pascal XOHomology(short int inlyer,int lenstrainseq,int lenxoverseq,short int xoverwindow, char *xoverseqnumw, int *xoverhomologynum);

extern "C" double FAR pascal ProbCalc(double *fact,int xoverlength,int numincommon,double indprob,int lenxoverseq);
extern "C" double FAR pascal DistanceCalc(short int nextno,int lenseq,short int *seqnum,float *distance,double *avdst);
//double FAR pascal          DistanceCalc(short int nextno,int lenseq,short int *seqnum,float *distance,double *avdst)


extern "C" double FAR pascal DistanceCalc2(short int nextno,int lenseq,short int *seqnum,double *distance,double *avdst);
extern "C" int FAR pascal DrawDiffs(HDC pict, int lenxoverseq, double xfactor,int *xdiffpos);
extern "C" int FAR pascal DrawDiffsB(HDC pict, int lenxoverseq, double xfactor,int *xdiffpos);
extern "C" double FAR pascal CalcChiVals(int criticaldiff,int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals);
extern "C" double FAR pascal CalcChiVals2(int criticaldiff,int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals);
extern "C" double FAR pascal CalcChiVals3(int criticaldiff,int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals);
extern "C" int FAR pascal MakeDeleteArray(int FragSt, int FragEn, int FragCount, int *DeleteArray);

extern "C" double FAR pascal GCGetHiPVal(int lseq, int LenXoverSeq, int *FragCount, double *PVals, int *MaxY, int *MaxX, int *highenough);

extern "C" double FAR pascal GCCalcPVal(int lseq,long LXover, long *FragMaxScore,double *PVals, long *FragCount, double *KMax,double *LL, int *highenough, double *critval);
extern "C" int FAR pascal OptLeftBPMC(int LO, double HiLeft, int TopL, int MaxX, int MaxY, int WinWin, int LenXOverSeq, int LS, char *Scores, char *MDMap);
extern "C" int FAR pascal OptRightBPMC(int RO, double HiRight, int TopR, int MaxX, int MaxY, int WinWin, int LenXOverSeq, int LS, char *Scores, char *MDMap);



extern "C" int FAR pascal CalcKMax(short int GCMissmatchPen,int XOLen,double *MissPen, double *LL, double *KMax, int *NDiff, int *highenough);

extern "C" int FAR pascal GetMaxFragScore(int LenXoverSeq, int lseq, short int CircularFlag, short int GCMissmatchPen,double *MissPen, int *MaxScorePos,int *FragMaxScore,int *FragScore, int *FragCount,int *hiscore);
extern "C" int FAR pascal GetMaxFragScoreB(int LenXoverSeq, int lseq, short int CircularFlag, short int GCMissmatchPen,double *MissPen, int *MaxScorePos,int *FragMaxScore,int *FragScore, int *FragCount,int *hiscore);


extern "C" int FAR pascal MakeAnc(int Nextno, int lseq, int CurPos, int *BranchMap, double *THold, int *Path,unsigned char *Identical, char *Conv, short int *AncSeq,short int *SeqNum);
extern "C" int FAR pascal GetAncDst(int Nextno, int lseq, short int *AncSeq,short int *SeqNum, float *AncDstMat, double *ConDeg );
//int FAR pascal          GetAncDst(int Nextno, int lseq, short int *AncSeq,short int *SeqNum, float *AncDstMat, double *ConDeg ){


extern "C" int FAR pascal FindSubSeqGCA(char gcindelflag,  int LSeq, int seq1, int seq2, int seq3, short int *SeqNum, char *subseq, int *XPosDiff, int *XDiffPos, int *NDiff);
extern "C" int FAR pascal FindSubSeqGCA2(unsigned char *Identical, char gcindelflag,  int LSeq, int seq1, int seq2, int seq3, short int *SeqNum, char *subseq, int *XPosDiff, int *XDiffPos, int *NDiff);

extern "C" int FAR pascal FindLeftEnd(int S1, int S2, int S3, int SLen, int BE, int UBMD,unsigned char *MissingData);
extern "C" int FAR pascal FindRightEnd(int S1, int S2, int S3, int SLen, int BE, int UBMD,unsigned char *MissingData);
//int FAR pascal          FindSubSeqGCA(char gcindelflag,  int LSeq, int seq1, int seq2, int seq3, short int *SeqNum, char *SubSeq, int *XPosDiff, int *XDiffPos, int *NDiff){

extern "C" int FAR pascal GetFrags(short int CircularFlag,int LenXoverSeq,int LSeq, int maxcount, char *SubSeq, int *FragSt, int *FragEn, int *FragScore, int *FragCount);
//int FAR pascal          GetFrags(short int CircularFlag,int LenXoverSeq,int LSeq, int maxcount, char *SubSeq, int *FragSt, int *FragEn, int *FragScore, int *FragCount){


extern "C" double FAR pascal ChiPVal3(double X, int df);

extern "C" int FAR pascal MakeMatrixMC(int LS, int LenXOverSeq, float *A, float *C, char *Scores, float *MatrixMC);

extern "C" double FAR pascal MakeVRand (int numtodo,int nseed, int numperms, int lseq, char *vrandtemplate);
extern "C" int FAR pascal DoSums(int SSNumPerms,int SSNumPerms2,int *PermSScores, int *PermPScores);

extern "C" int FAR pascal Get3Score (char SSGapFlag, int LSeq, short int seq1, short int seq2, short int seq3, short int *SeqNum, short int *SeqScore3);


extern "C" double FAR pascal MakeZValue (int shpos, int numwins, short int numgroups,int ssnumperms, int ssnumperms2, char *dogroup, int *permpscores, double *zpscoreholder);
extern "C" double FAR pascal MakeZValue2 (int shpos, int numwins, short int numgroups,int ssnumperms, int ssnumperms2, char *dogroup, int *permpscores, double *zpscoreholder);
extern "C" double FAR pascal MakeZValue3 (double *sqa, int shpos, int numwins, short int numgroups,int ssnumperms, int ssnumperms2, char *dogroup, int *permpscores, double *zpscoreholder);

extern "C" int FAR pascal DoPerms(int LS,int SSWinLen, int SSNumPerms, char *PScores, char *VRandTemplate, char *VRandConv, int *PermPScores);
extern "C" int FAR pascal DoPermsX(int LS,int SSWinLen, int SSNumPerms, char *PScores, char *VRandTemplate, char *VRandConv, int *PermPScores);

extern "C" int FAR pascal DoPerms2(int LS,int SSWinLen, int SSNumPerms, char *PScores, char *VRandTemplate, char *VRandConv, int *PermPScores);
extern "C" int FAR pascal DoPerms3(int LS,int SSWinLen, int SSNumPerms, int SSNumPerms2, int *PScores, char *VRandTemplate, char *VRandConv, int *PermPScores);

extern "C" int FAR pascal GetPScoresRnd(int X, int SSWinLen, short int Seq1, short int Seq2,short int Seq3,short int oSeq, int slen,int *PScores, char *Seq34Conv, short int *SeqScore3, short int *SeqNum, int *HRndTemplate);
extern "C" int FAR pascal ReSortArray(int Y, int NumWins, int PosAIn, int ReadNo, int BSBootReps, short int *BSFileBuffer, short int *SortArray);

extern "C" int FAR pascal FindMChi(int LenSeq, int LenXoverSeq, int *MaxX,short int *MaxY, double *MChi, double *ChiVals);
extern "C" int FAR pascal FindMChi3(int LenSeq, int LenXoverSeq, int *MaxX,short int *MaxY, double *MChi, double *ChiVals);


extern "C" int FAR pascal SmoothChiVals(int LenXoverSeq, int LenSeq, double *ChiVals, double *SmoothChi);
extern "C" int FAR pascal FindMChi2(int LenSeq, int LenXoverSeq, int *MaxX,short int *MaxY, double *MChi, double *ChiVals);
extern "C" int FAR pascal SmoothChiVals2(int LenXoverSeq, int LenSeq, double *ChiVals, double *SmoothChi);
extern "C" int FAR pascal SmoothChiVals3(int LenXoverSeq, int LenSeq, double *ChiVals, double *SmoothChi);

extern "C" int FAR pascal BSSubSeq (int lenseq, int seq1, int seq2, int seq3,short int *seqnum, int *xposdiff, int *xdiffpos, char *scores);
extern "C" int FAR pascal DoHits (int bpos, int epos, int nextno, int seqd, int seqmi, int seqma,int *hitsperseq,int *numhits);
extern "C" int FAR pascal DoHits2 (int bpos, int epos, int nextno, int seqd, int seqmi, int seqma,int *hitsperseq,int *numhits);
extern "C" int FAR pascal GetPScores4(int X, int SSWinLen, short int Seq1, short int Seq2,short int Seq3,short int oSeq, int slen,char *PScores, char *Seq34Conv, short int *SeqScore3, short int *SeqNum,  short int *SimSeqNum);

extern "C" int FAR pascal AddScores (int bpos, int epos, int nextno, int numtoadd,int seqnumber,int *hitsperseq);
extern "C" int FAR pascal GetPScores(int X, int SSWinLen, short int Seq1, short int Seq2,short int Seq3,short int oSeq, int slen,char *PScores, char *Seq34Conv, short int *SeqScore3, short int *SeqNum);
extern "C" int FAR pascal GetPScores2(int X, int SSWinLen, short int Seq1, short int Seq2,short int Seq3,short int oSeq, int slen,int *PScores, char *Seq34Conv, short int *SeqScore3, short int *SeqNum);
extern "C" int FAR pascal DoChiPerms (double mChi, int WinWin, int LenXoverSeq, int LenR, int MCPerms, int LO, char *MCPScore, char *Scores);
extern "C" int FAR pascal FillMatrix (int LSeq, int Beginning, int Ending, double Dst,  double *RecombMatrix);
extern "C" int FAR pascal FillMatrixB (int LSeq, int Beginning, int Ending, double *Dstma,double *Dstmi,  double *RecombMatrix);

extern "C" int FAR pascal WinScoreCalc(int criticaldiff,int HWindowWidth, int LenXoverSeq,int LenSeq, int Seq1, int Seq2,char *Scores, int *XDiffPos, short int *SeqNum, int *WinScores);
extern "C" int FAR pascal WinScoreCalc4(int criticaldiff,int HWindowWidth, int LenXoverSeq,int LenSeq, int Seq1, int Seq2,char *Scores, int *XDiffPos, short int *SeqNum, int *WinScores);

extern "C" int FAR pascal QuickCheckB (int HP, int LP1, int LP2,int SSStep, int LS,int x, int sswinlen, int *tally, short int *seqscore3);
extern "C" int FAR pascal QuickCheck (int x, int sswinlen, int *tally, short int *seqscore3);

extern "C" int FAR pascal GetPltVal2(short int bootreps, int start, int end, short int *t0, short int *t1, short int *t2, double *pltval);
extern "C" int FAR pascal WinScoreCalc3(int criticaldiff,int HWindowWidth, int LenXoverSeq,int LenSeq, int Seq1, int Seq2,char *Scores, int *XDiffPos, short int *SeqNum, int *WinScores, int *xdiffpos2);

extern "C" int FAR pascal WinScoreCalc2(int criticaldiff,int HWindowWidth, int LenXoverSeq,int LenSeq, int Seq1, int Seq2,char *Scores, int *XDiffPos, short int *SeqNum, int *WinScores);
extern "C" int FAR pascal PlotDraw(HDC pict,int lenxoverseq, short int picheight, double xfactor,int *xdiffpos,  double *xoverhomologynum);
extern "C" int FAR pascal HomologyWin(short int weightedflag,short int lenhsnum,short int beginning,short int ending,short int nextno, double *validsite,double *runningtotal,  short int *homologyseqnum, double *homology,double *bkghomology,double *adjustfactor);
extern "C" int FAR pascal MakeSubSeq(short int nextno,int lenseq,short int *seqnum,short int *rtseqs,double *rtseqcomp);
extern "C" int FAR pascal MakeSubSeqB(short int spacerno,int lenseq,short int nonspacerno,short int *seqnum,short int *rtseqs,short int *rtseqcomp);
extern "C" int FAR pascal MakeSubSeqC(short int nextno,int lenseq,short int *seqnum,short int *rtseqs,char *rtseqcomp,short int *currentxover);
extern "C" int FAR pascal DrawMatrix(HDC pict, short int pwid,short int ypos,short int dwid, short int sqr, unsigned char *picarray);
extern "C" int FAR pascal DrawMatrixB(HDC pict, short int pwid,short int ypos,short int dwid, short int sqr, unsigned char *picarray);
extern "C" int FAR pascal GetSiteHomol(int lseq, short int nextno, short int *seqnum,  short int *idcount,int *seqhomol);
extern "C" int FAR pascal InStrX(short int start, unsigned char *strng, short int target, short int slen);

extern "C" double FAR pascal DistanceCalcB(short int nextno,int lenseq,short int nonspacerno,short int *seqnum,float *distance,float *validsiteno);
extern "C" double FAR pascal DistanceCalcC(short int nextno,int lenseq,int beginning,int ending,short int *seqnum,float *distance,float *validsiteno);
extern "C" double FAR pascal DistanceCalcD(short int nextno,int lenseq,short int *seqnum,float *distance,float *validsiteno,short int *currentxover,float *distanceb);
extern "C" double FAR pascal DistanceCalcE(short int y,int nextno,short int lenseq,int beginning,int ending,short int *seqnum,float *distance);


extern "C" double FAR pascal TreeDist(int nextno, float *treedistance,double *nodelength,short int *treex);
//double FAR pascal          TreeDist(int nextno, float *treedistance,double *nodelength,short int *treex)

extern "C" float FAR pascal ShortestDist(int nextno, int sortedno, float *distancebak,short int *treex,short int *treey);
extern "C" float FAR pascal ShortestDistB(int nextno, int sortedno, float *OldX, int *WinningX, float *distancebak,short int *treex,short int *treey);

//double FAR pascal          ShortestDist(short int nextno, short int sortedno, float *distancebak,short int *treex,short int *treey)

extern "C" double FAR pascal DistanceCalcX(int nextno,int lenseq,float *diffsx,float *validx,short int *seqnum,float *distance,double *avdst);
extern "C" double FAR pascal DistanceCalcY(short int nextno,int lenseq,float *diffsx,float *validx,short int *seqnum,float *distance,double *avdst,double *distmod);
extern "C" double FAR pascal DistanceCalcZ(int nextno,int lenseq,float *diffsx,float *validx,short int *seqnum,float *distance,double *avdst, int *validl, int *countl);

extern "C" double FAR pascal DistanceCalcW(int nextno,int lenseq,float *diffsx,float *validx, short int *seqnum,float *distance,double *avdst, int *involved);
//double FAR pascal          DistanceCalcW(int nextno,int lenseq,float *diffsx,float *validx, short int *seqnum,float *distance,double *avdst, int *involved)

extern "C" double FAR pascal  FinishDists(int lseq, int Nextno, int ub,int BPos3, int EPos3,float *FMat, float *SMat, float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum);
extern "C" double FAR pascal  QuickDist(int lseq, int Nextno, int ub,int BPos3, int EPos3,float *FMat, float *SMat, float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum);

extern "C" double FAR pascal  QuickDist(int lseq, int Nextno, int ub,int BPos3, int EPos3,float *FMat, float *SMat, float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum);
//          double FAR pascal QuickDist(int lseq, int Nextno, int ub,int BPos3, int EPos3,float *FMat, float *SMat, float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum)

extern "C" int FAR pascal MakeTreeArray (int nextno, float *tmat2,float *tmat2bak);
extern "C" int FAR pascal MakeTreeArrayX (int nextno, float *tmat2,float *tmat2bak);
//int FAR pascal MakeTreeArray          (int nextno, float *tmat2,float *tmat2bak){

extern "C" int FAR pascal MakeDistMapX(int Nextno, float *DistMap, float *NJSubDistance, int *WinningX);
extern "C" int FAR pascal UpdateDistMapX(int X, int Z, int Nextno, float *DistMap, float *NJSubDistance, int *WinningX);


//extern "C" int FAR pascal  FindSubSeq(short int lenseq,short int seq1,short int seq2,short int seq3, short int *seqnum, short int *xoverseqnum);

extern "C" double FAR pascal TreeMid(int MaxCurPos,int NumberOfSeqs,double *NumDone, float *TMat2, int *TB, int *NodeOrder, double *MidNode, double *NodeLen);
//double FAR pascal          TreeMid(int MaxCurPos,int NumberOfSeqs,double *NumDone, float *TMat2, int *TB, int *NodeOrder, double *MidNode, double *NodeLen){

extern "C" double FAR pascal UltraTreeDist(double MD, int MaxCurPos,int NumberOfSeqs,float *TMat2, double *NumDone, int *DoneThis, int *AbBe, int *NodeOrder, double *MidNode, double *NodeLen );
//double FAR pascal UltraTreeDist         (double MD, int MaxCurPos,int NumberOfSeqs,float *TMat2, double *NumDone, int *DoneThis, int *AbBe, int *NodeOrder, double *MidNode, double *NodeLen ){

extern "C" double FAR pascal QuickDist2(int lseq, int Nextno, int ub, int BPos3, int EPos3,  float *SubValid, float *SubDiffs, short int *SeqNum, long *iseqs);
extern "C" double FAR pascal MakeRMat(int Nextno, int WinPP, double *RMat, double *LMat, double *PDist, int *Iseqs, float *FMat, float *SMat, int *CompMat, double *Ttx);
//double FAR pascal          MakeRMat(int Nextno, int WinPP, double *RMat, double *LMat, double *PDist, int *Iseqs, float *FMat, float *SMat, int *CompMat, double *Ttx){

extern "C" double FAR pascal CalCR(double tmF, int Nextno, int WinPP, int *Iseqs, int *CompMat, float *RCorr, float *RInv, double *IntVal, double *RMat, float *trcorrx);
extern "C" double FAR pascal MakeLMat(int X, int Nextno,double *LMat, double *PDist, float *SubValidx, float *SubDiffsx, int *Iseqs, int *CompMat, double *AVSN);
//double FAR pascal          MakeLMat(int X, int Nextno,double *LMat, double *PDist, float *SubValidx, float *SubDiffsx, int *Iseqs, int *CompMat, double *AVSN){

extern "C" double FAR pascal MakeEventSeqs (int da, int mip, int map, int EN,int lseq, short int *EventSeq, short int *SeqNum);
extern "C" double FAR pascal DefineEvent(int ShortOutFlag, int LongWindedFlag, int MedHomol, int HighHomol, int LowHomol, int TargetX,int CircularFlag, int XX, int  XOverWindow, int  lenseq, int  LenXoverSeq, int  SeqDaughter, int  SeqMinorP, int *EndFlag, int  *Be, int  *En, int  *NCommon, int  *XOverLength, char *XOverSeqNum, int *XDiffPos, int *XOverHomologyNum);

extern "C" double FAR pascal MakeGoodC(int Nextno, int lenseq, int *GoodC, int *BPosLR, short int *SeqNum);
extern "C" int FAR pascal FindOverlap(int lenseq, int BPos2, int EPos2,int *RSize, int *OLSeq);
extern "C" int FAR pascal MakeTMatch(int WinPP, int *CompMat, int *TMatchX, int *RNum, int *FoundOne, int *SQ, int *Rlist, int *FOX, int *CSeq, double *tMatch, int *invlist);
extern "C" double FAR pascal ttestprob(double t, int df);
extern "C" double FAR pascal StripUnfound(int WinPP, int *RNum, int *Rlist, int *InvList, int *FoundOne, float *RCorr, double *RLScore);
extern "C" double FAR pascal MakeRCompat(int *ISeqs, int *CompMat,int WinPP, int Nextno, int *RCompat,int *RCompatB, int *InPen, int *RCats, int *RNum, int *NRNum, int *GoodC, int *DoneX, int *Rlist, int *NRList,float *FAMat, double *LDist);
//double FAR pascal          MakeRCompat(int *ISeqs, int *CompMat,int WinPP, int Nextno, int *RCompat,int *RCompatB, int *InPen, int *RCats, int *RNum, int *NRNum, int *GoodC, int *DoneX, int *Rlist, int *NRList,float *FAMat, double *LDist){


extern "C" int FAR pascal MakeActualSeqSize(int LS,int Nextno,int WinPP, int *RNum, int *Rlist, int *ActualSeqSize, short int *SeqNum);
extern "C" int FAR pascal MakeTDiffs(int nextno, int xnextno,float *TDiffs, float *TValid, float *PermDiffs, float *PermValid, int *UnInvolved, int *ActualSeqSize);
//int FAR pascal          MakeTDiffs(int nextno, int xnextno,float *TDiffs, float *TValid, float *PermDiffs, float *PermValid, int *UnInvolved, int *ActualSeqSize){

extern "C" int FAR pascal MakePermDiffs(int Nextno, int MinSeqSize,float *TDiffs, float *TValid, float *PermDiffs, float *PermValid, float *Distance);
//int FAR pascal          MakePermDiffs(int Nextno, int MinSeqSize,float *TDiffs, float *TValid, float *PermDiffs, float *PermValid, float *Distance){

extern "C" int FAR pascal ModSN(int Nextno,int LS, int BPos, int EPos, int WinPP, int *RNum, int *Rlist, int *BReaks, short int *SeqNum, unsigned char *missdata);
extern "C" int FAR pascal RebuildSeqNum(int LS, int WinPP, int *RNum, int *BReaks, int *Rlist, short int *SeqNum, short int *tSeqNum);
extern "C" int FAR pascal ModSeqNumY(int BPos, int EPos, int LS, int WinPP, int *RNum, int *BReaks, int *Rlist, short int *SeqNum, short int *tSeqNum, unsigned char *missdata);
extern "C" int FAR pascal MakeTrpScore(int X, int Nextno, float *FAMat,float *SAMat,double *TrpScore, int *NumInGroup, int *Iseqs, int *GroupSeq);
//int FAR pascal          MakeTrpScore(int X, int Nextno, float *FAMat,float *SAMat,double *TrpScore, double *NumInGroup, int *Iseqs, int *GroupSeq){

extern "C" int FAR pascal MakePairs(int Nextno, int Da, int Ma, int Mi, int WinPP, int *RNum, int *Rlist, int *DoPairs);
extern "C" int FAR pascal MakeDoneThis (int Nextno, float *FMat,float *FAMat, float *SAMat, double *LD, int *DoneThis, int *Iseqs);
extern "C" int FAR pascal MakeDoneThis2 (int Nextno, float *FMat,float *FAMat, float *SAMat, int *DoneThis, int *Iseqs);

//int FAR pascal          MakeDoneThis (int Nextno, float *FMat,float *FAMat, float *SAMat, double *LD, int *DoneThis, int *Iseqs){

extern "C" int FAR pascal MakeTrpGroups(int X, int Nextno, int *NumInGroup, int *CompMat, int *Iseqs, int *DoneOne, int *GroupSeq, double *MinDistZ, float *FAMat);
//int FAR pascal          MakeTrpGroups(int X, int Nextno, double *NumInGroup, int *CompMat, int *Iseqs, int *DoneOne, int *GroupSeq, double *MinDistZ, float *FAMat){
 
extern "C" int FAR pascal ModSeqNumB(int BPos, int EPos, int LS, int WinPP, int *RNum, int *BReaks, int *Rlist, short int *SeqNum, short int *tSeqNum);
extern "C" int FAR pascal ModSeqNumA(int Nextno,int LS, int BPos, int EPos, int WinPP, int *RNum, int *Rlist, int *BReaks, short int *SeqNum);
extern "C" int FAR pascal FindMissing(int LS, int Seq1, int Seq2, int Seq3, int Z, int En, unsigned char *MissingData);
extern "C" int FAR pascal CheckSplit(int LS, int Be, int En, int Seq1, int Seq2, int Seq3, int *Split, unsigned char *MissingData);
extern "C" double FAR pascal MakePhPrScore(int Nextno, double tmF, int *TraceInvolvedBak, int *DoneThis, int *Iseqs, double *PhPrScore,  float *FMat, float *SMat, double *tPhPrScore, double *SubPhPrScore, double *SubScore);
//double FAR pascal          MakePhPrScore(int Nextno, double tmF, int *TraceInvolvedBak, int *DoneThis, int *Iseqs, double *PhPrScore,  float *FMat, float *SMat, double *tPhPrScore, double *SubPhPrScore, double *SubScore){

extern "C" int FAR pascal MakeBPosLR(int VSN, int TSN, int LS, int BPos, int EPos, short int *SeqNum, int *Iseqs, int *BPosLR, double *AVSN);
extern "C" int FAR pascal MakeOLSeq(int LS, int BPos, int EPos, int *RSize, int *OLSeq);

extern "C" int FAR pascal AddSeqToUPGMA(int Nextno, int SortedNo, short int *XInstance, float *DistanceBak, short int *TreeX, short int *TreeY, int *Check, short int *NodeYPos);
//int FAR pascal          AddSeqToUPGMA(int Nextno, int SortedNo, short int *XInstance, float *DistanceBak, short int *TreeX, short int *TreeY, int *Check, short int *NodeYPos){

extern "C" int FAR pascal AddSeqToUPGMA2(int Nextno, int SortedNo, short int *XInstance, float *DistanceBak, short int *TreeX, short int *TreeY, int *Check, short int *NodeYPos);
//int FAR pascal          AddSeqToUPGMA(int Nextno, int SortedNo, short int *XInstance, float *DistanceBak, short int *TreeX, short int *TreeY, int *Check, short int *NodeYPos){


extern "C" double FAR pascal MakeRList(int Nextno, int *GoodC,  int *Iseqs,  int *RlistX, int *InvListX, int *RNumX,int *Rlist, int *InvList, int *RNum, float *RInv, float *RCorr, double *PScores, double *tPVal, double *tVal, double *TotP, double *RLScore, char *dontredo, char *acceptab, char *rcorrwarn);
extern "C" int FAR pascal TreeDist2(int Nextno, short int *TreeX, short int *TreeY, float *TreeDistance);
//int FAR pascal          TreeDist2(int Nextno, short int *TreeX, short int *TreeY, float *TreeDistance){

extern "C" int FAR pascal MakeTMatch2(int tWinPP, int WinPP, int *TMatchX, int *SQ, double *tMatch, int *RNum, int *Rlist, int *CompMat);
extern "C" int FAR pascal TestRList(int WinPP, int *A, int *Z, int *FoundOne, int *RNum, int *SQ, int *Rlist);
extern "C" int FAR pascal StripDupInv(int Nextno, float *RCorr, double *RLScore, int *InPen, int *RNum, int *Rlist, int *InvList );
extern "C" int FAR pascal MakeLDist(int Nextno, double *LDist, float *FAMat, int *RNum, int *Rlist);
//int FAR pascal          MakeLDist(int Nextno, double *LDist, float *FAMat, int *RNum, int *Rlist){

extern "C" int FAR pascal MakeRelevant(int Nextno,int *Relevant, int *RNum, int *Rlist);
extern "C" int FAR pascal CopySeqs (int LS, int Nextno, short int *SeqNum, short int *PermSeqNum);
extern "C" int FAR pascal SplitEvent (int xoverwin, int LS, int LenXoverSeq, int SeqDaughter, int SeqMinorP, int BTarget, int ETarget, int *XOverLength, int *NCommon, int *XPosDiff, char *XOverSeqNum);

extern "C" int FAR pascal MakeUninvolved(int WinPP, int Nextno, int *UnInvolved, int *RNum, int *Rlist);
extern "C" int FAR pascal StripUnfound2(int WinPP, int AddNum, int *RNum, int *WinnerPos, int *Rlist, int *BReaks);
extern "C" int FAR pascal CopySeq (int LS, int Nextno, int X, int Y, short int *SeqNum);
extern "C" int FAR pascal DelPVals(short int GCMaxOverlapFrags,int Y, int X, int LS, double *PVals, int *FragCount, int *FragSt, int *FragEn, int *MaxScorePos, int *DeleteArray);
extern "C" double FAR pascal MakeSubProb(int X, int LS, int LenXoverSeq, int BTarget, int ETarget, char *SubSeq, double *LL, double *KMax, double *MissPen, double *critval);
extern "C" int FAR pascal GrowMChiWin(int LO, int RO, int LenXoverSeq, int HWindowWidth, int TWin, int MaxY, int LS, int A, int C, int MaxFailCount, double *MPV, int *WinWin, double *MChi, int *TopL, int *TopR, int *TopLO, int *TopRO, char *Scores);
extern "C" double FAR pascal ChiPVal2(double X);
extern "C" int FAR pascal DestroyPeaks(int MaxY, int LenXoverSeq, int LS, int LO, int RO, double *SmoothChi, double *ChiVals);
extern "C" int FAR pascal FindSide(int TopL, int TopR, int LS, int LO, int RO, int WinWin, int LenXoverSeq, int MaxY, char *Scores, double *HiLeft, double *HiRight);
extern "C" double FAR pascal CalcChiVals4(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals, int *BanWins);
extern "C" int FAR pascal GrowMChiWin2(int LO, int RO, int LenXoverSeq, int HWindowWidth, int TWin, int MaxY, int LS, int A, int C, int MaxFailCount, double *MPV, int *WinWin, double *MChi, int *TopL, int *TopR, int *TopLO, int *TopRO, char *Scores, char *mdmap);
extern "C" int FAR pascal MakeBanWin(int Seq1, int Seq2, int Seq3, int HWindowWidth, int LS, int LenXoverSeq, int *BanWin, char *MDMap, unsigned char *MissingData, int *XPosDiff, int *XDiffPos);
extern "C" int FAR pascal DestroyPeak(int MaxY, int LS, int RO, int LO, int LenXoverSeq, double *LOT, double *SmoothChi, double *ChiVals);
extern "C" int FAR pascal GetAC(int LenXoverSeq, int LS,int MaxY, int MaxX, int TWin, int *A, int *C, char *Scores);
extern "C" double FAR pascal vQuickDist(int lseq, int Nextno, int ub, int BPos3, int EPos3,float *FMat, float *SMat,  float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum, int *iseqs);
//         double FAR pascal vQuickDist(int lseq, int Nextno, int ub, int BPos3, int EPos3,float *FMat, float *SMat,  float *SubValid, float *SubDiffs, float *PermValid, float *PermDiffs, short int *SeqNum, int *iseqs)

extern "C" int FAR pascal FindHiSeqs(int LS, int RS, int RE, int Ac, int Mi, int Ma, short int *SeqNum, float *Dists, float *Valids,float *Diffs);
//int FAR pascal          FindHiSeqs(int LS, int RS, int RE, int Ac, int Mi, int Ma, short int *SeqNum, float *Dists, float *Valids,float *Diffs){

extern "C" int FAR pascal CheckMatrix(int UB, int SCO, int MinSeqSize, int Nextno, int *Valtot, int *ISeqs, float *PermValid, float *SubValid, float *FMat, float *SMat, float *FAMat, float *SAMat);
//int FAR pascal          CheckMatrix(int UB, int SCO, int MinSeqSize, int Nextno, int *Valtot, int *ISeqs, float *PermValid, float *SubValid, float *FMat, float *SMat, float *FAMat, float *SAMat){

extern "C" int FAR pascal FindNextRedo(int Start, char *Relevant2, int *RedoList, int *iseqs, int *relevant);
extern "C" int FAR pascal CleanRedoList(int *Redolistsize, int *RedoList);
extern "C" int FAR pascal MarkRemovals(int Nextno, int WinPP, int Redolistsize, int *RedoList, int *RNum, int *Rlist, int *DoPairs);
extern "C" int FAR pascal ModSeqNumZ(int Nextno,int LS, int BPos, int EPos, int WinPP, int *RNum, int *Rlist, int *BReaks, short int *SeqNum, unsigned char *missdata);
extern "C" double FAR pascal CalcChiVals5(int criticaldiff, int HWindowWidth,int LenXoverSeq, int LenSeq,int *WinScores, double *ChiVals, int *BanWins);
extern "C" int FAR pascal ModSeqNumD(int Nextno, int LS, int FS, int BE,int EN, short int *SeqNum, unsigned char *MissingData);
extern "C" int FAR pascal ModSeqNumE(int NextNo, int LS, int FS, int BE,int EN, short int *SeqNum, unsigned char *MissingData);
extern "C" int FAR pascal ReplaceSeq(int NextNo, int LS, int S1, int S2, short int *SeqNum, unsigned char *MissingData);
extern "C" int  FAR pascal PBar(double *pval);
extern "C" double FAR pascal MakeDst(int lseq, int DA, int Mi, int Ma, int BPos, int EPos, double *VDiffs, short int *SeqNum );
extern "C" double FAR pascal UpdatePlotInfo(double PVal, int prg,int LSeq,int BPos, int EPos, double Dst, int *MaxHits, double *PDistPlt, double *ProbPlt, int *HitPlt, char *RedoPltL);

extern "C" int FAR pascal FindBestRecSignal(char DoneTarget, int NextNo, int UB, double *LowP, char *DoneSeq, int *Trace, short int *PCurrentXOver,XOVERDEFINE *PXOList);
extern "C" int FAR pascal CheckEnds(int LS, int RL, int LSS, int ChF, int CirF, int Seq1, int Seq2, int Seq3, int BPos , int EPos , short int *SeqNum , int *XPD, int *XDP, unsigned char *MissingData);
extern "C" int FAR pascal CopyXOListsX (int UB1, int UB3, int UB2, int UB4,int NextNo, short int *CurrentXover, short int *PCurrentXOver, XOVERDEFINE *PXOList, XOVERDEFINE *XOverList, int *NumRecsI);
extern "C" int FAR pascal FindActualEvents(int LS, int WinPP, int NextNo, int UB, int *RSize, char *Don, int *BPMatch, float *BMatch,double *OKSeq, int *FoundOne, int *SP, int *EP, float *RCorr, int *OLSeq, int *OLSeqB, int *OLSeqE, int *CSeq, int *RNum, int *RList, char *InvS, int *TrS, double *TMatch, XOVERDEFINE *PXOList, short int *PCurrentXOver, int *SQ, char *tDon, int *ISeqs, char *TList, int *CompMat);
//int FAR pascal          FindActualEvents(int LS, int WinPP, int NextNo, int UB, int *RSize, char *Don, int *BPMatch, float *BMatch,double *OKSeq, int *FoundOne, int *SP, int *EP, double *RCorr, int *OLSeq, int *OLSeqB, int *OLSeqE, int *CSeq, int *RNum, int *RList, char *InvS, int *TrS, double *TMatch, XOVERDEFINE *PXOList, short int *PCurrentXOver, int *SQ, char *tDon, int *ISeqs, char *TList, int *CompMat){

extern "C" int FAR pascal MakePValMap(int DN, int LS, int PermNum, short int *Map, float *PValMap);
extern "C" int FAR pascal FillSeqLines(int PermNextno, int NumSeqLines, int Offset1, int Offset2, int Offset4, int RSN1, int Col1, int Col2, int Col3, int Col4, int UBSCR, int UBSL, int UBCD, short int *ColDist, int *SeqLines,unsigned char *SeqColRef);

extern "C" int FAR pascal AddToMap(int A,int S, double Win, int LS,int *APos, short int *Map);
extern "C" int FAR pascal CheckBPOL(int LS, int d, int LSSeq, int NewStart, int RecSize,short int *tSeqNum, int *ns, int *ne, int *XDiffPos);
extern "C" int FAR pascal FindMaxMapVal(int DN, int LS, int PermNum, int *MaxVals, short int *Map);

extern "C" int FAR pascal CheckMissingData(int Seq1, int Seq2, int Seq3, int XB, int XE, int LS, unsigned char *MissingData);
extern "C" int FAR pascal PPRegression(char IncSelf, int X, int ls, int NumberOfSeqs, int NSX, float *PDstMat, float *PPWinScoreT);
//int FAR pascal          PPRegression(char IncSelf, int X, int ls, int NumberOfSeqs, int NSX, float *PDstMat, double *PPWinScoreT){

extern "C" int FAR pascal UpdatePDstMat(int X, int Begin1, int End2, int NumberOfSeqs, int LS, short int *SeqNum, int *XDiffpos, short int *RevSeq, float *PDstMat);
//int FAR pascal          UpdatePDstMat(int X, int Begin1, int End2, int NumberOfSeqs, int LS, short int *SeqNum, int *XDiffpos, short int *RevSeq, float *PDstMat){

extern "C" int FAR pascal MakePDstMat(int NumberOfSeqs,int LS, int LenXOverSeq, int WinLen, int *XDiffpos, short int *RevSeq, short int *SeqNum, float *PDstMat);
//int FAR pascal          MakePDstMat(int NumberOfSeqs,int LS, int LenXOverSeq, int WinLen, int *XDiffpos, short int *RevSeq, short int *SeqNum, float *PDstMat){

extern "C" int FAR pascal MakeDistX (int Seq1, int Seq2,int Seq3,int LS, float *DistanceX, short int *SeqNum);
//int FAR pascal          MakeDistX (int Seq1, int Seq2,int Seq3,int LS, float *DistanceX, short int *SeqNum){

extern "C" int FAR pascal FindMaxZ(int HV, int LV1, int LV2, int LV3, int WinNum, int FHPos, int SHPos, char *SeqMap, char *DoGroupS, char *DoGroupP, double *maxz, double *winp, double *winscore, char *wps, double *ZSScoreHolder, double *ZPScoreHolder);
extern "C" int FAR pascal ShrinkRegionC(int LS, int SSGapFlag, int SSStep, int SSWinLen, int HVX, int Seq1, int Seq2, int Seq3, int EP, int SP, int *TEnd, int *TBegin, short int *SeqNum );

extern "C" int FAR pascal GetSSOL(int LS, int SEventNumber, int nn1,int nn2, int PermNextNo, int NextNo,int SSOutlyerFlag, int LFlag, int *Seq1, int *Seq2, int *Seq3, int *oSeq, float *TreeDistance, float *Distance, unsigned char *MissingData, int *TraceSub);
//int FAR pascal          GetSSOL(int LS, int SEventNumber, int nn1,int nn2, int PermNextNo, int NextNo,int SSOutlyerFlag, int LFlag, int *Seq1, int *Seq2, int *Seq3, int *oSeq, float *TreeDistance, float *Distance, unsigned char *MissingData, int *TraceSub){

extern "C" int FAR pascal BlankSSArrays (int ub1, int ub2, int ub3, int ub4, double *zssh, double *zpsh);
extern "C" double FAR pascal ShrinkRegionBS(int CircularFlag, int seventnumber, int Hi1, int Hi2, int LO, int LS, int *XPosdiff, int *RS, int *RE, short int *SeqNum, unsigned char *MissingData);
extern "C" int FAR pascal MakeScoresBS(int LenXOverSeq, int ScoreP, int LS, int be, int EN,  int *a, int *c, int *XPosdiff, char *Scores);
extern "C" int FAR pascal FindBeginBS(int CircularFlag,  int BSStepSize, int BSStepWin, int MedHomol, int HighHomol, int LowHomol, long numwins, double BSCutOff, int BSBootReps, int PosCount, short int OverlapNum, double *totalprob,int *lastfull, int *probcounter, int *YVal, double *PVal, double *PPVal, char *EraseAll, int *curpos, double *PltVal);
extern "C" int FAR pascal FindEndBS(int Y, double BSCutOff, int BSBootReps,int numwins, int OverlapNum, int MedHomol, int HighHomol, int LowHomol,int gbcc,int *lastfull,int *probcounter, int *curpos, double *totalprob, double *PltVal);
extern "C" int FAR pascal AddToRegionMat(int LS, int ST, int EN, int RSize, float SConvert, float ParDist,float *RegionMat);

extern "C" int FAR pascal FindSubSeqTS(int LS, int Seq1, int Seq2, int Seq3, int *be, int *en, int *be2, int *en2, int *nm, int *nn, int *nk, int *nl, int *XPosdiff, int *XDiffpos, short int *SeqNum, int *XOverSeqNum);
extern "C" int FAR pascal FindSubSeqTS2(int LS, int Seq1, int Seq2, int Seq3, int *be, int *en, int *be2, int *en2, int *nm, int *nn, int *nk, int *nl, int *XPosdiff, int *XDiffpos, short int *SeqNum, int *XOverSeqNum, unsigned char *MissingData);

extern "C" int FAR pascal Fill4DSingArray(int  b1,int b2,int b3,int b4,float fillval,float *array);
extern "C" int FAR pascal FindFormula(int O, int UB, int UB2,double *ssa, double *ss, float *XTable,  double *TTable, double *Ex);
extern "C" float FAR pascal Get3SeqPvalC(int uba, int ubb, float m, float n, float k, float j, float *YTable);
extern "C" float FAR pascal Seq3PVals (int uba, int ubb, float nM, float nN, float nK, float *YTable);

extern "C" int FAR pascal CheckwrapC(int LS, int LenXOverSeq, int NegMod, int CircularFlag, int *nK,int *be, int *en, int *XDiffPos, int *XPosDiff, int *XoverSeqNumTS);

extern "C" int FAR pascal CopyLongArray (int D1, int D2,int LS, int Nextno, int LS2, int Nextno2,int *SeqNum, int *PermSeqNum);
extern "C" int FAR pascal CopyDoubleArray (int D1, int D2,int LS, int Nextno, int LS2, int Nextno2,double *SeqNum, double *PermSeqNum);
//int FAR pascal          CopyDoubleArray (int D1, int D2,int LS, int Nextno, int LS2, int Nextno2,double *SeqNum, double *PermSeqNum){

extern "C" int FAR pascal CopySingleArray (int D1, int D2,int LS, int Nextno, int LS2, int Nextno2,float *SeqNum, float *PermSeqNum);
//int FAR pascal          CopySingleArray (int D1, int D2,int LS, int Nextno, int LS2, int Nextno2,float *SeqNum, float *PermSeqNum){

extern "C" int FAR pascal UpdateDistArrays(int NextNo, int X, int A, int UB1, int UB2, int UB3, int UB4, int UB5, int UB6, float *TreeFMat, float *TreeSMat, float *FMat, float *SMat,float *TreeMatrix, float *Distance);
//int FAR pascal          UpdateDistArrays(int NextNo, int X, int A, int UB1, int UB2, int UB3, int UB4, int UB5, int UB6, float *TreeFMat, float *TreeSMat, float *FMat, float *SMat,float *TreeMatrix, float *Distance){

extern "C" double FAR pascal MakeDistModPar(int Nextno, int UB1, int UB2, float *Tot, float *FMat, float *SMat, float *PermDiffs, float *PermValid);
//double FAR pascal          MakeDistModPar(int Nextno, int UB1, int UB2, double *Tot, float *FMat, float *SMat, float *PermDiffs, float *PermValid){

extern "C" double FAR pascal MakeVScoreMat(float *ScoreMat);
//double FAR pascal          MakeVScoreMat(float *ScoreMat){

extern "C" double FAR pascal MakeWinScoreV(int Seq1, int Seq2,int Seq3,int Seq4,int lseq, int VWin, char *NucMat, short int *SeqNum, float *d, float *VScoreMat, float *WinScoreV);
//double FAR pascal          MakeWinScoreV(int Seq1, int Seq2,int Seq3,int Seq4,int lseq, int VWin, char *NucMat, short int *SeqNum, float *d, float *VScoreMat, float *WinScoreV){

extern "C" double FAR pascal MakeTheta(int plotf, int lseq, double SideB, double SideBs, double OD3, float *WinScoreV, float *rScore, float *Theta, float *VisRDOccupancyStat);
extern "C" double FAR pascal MakePrintPoints(int lseq, int XDist, int YDist, int PicHeight,double XFactor, float *Theta, float *rScore, float *PrintPoints, int *Decompress);
extern "C" int FAR pascal TSeqPerms(int Seq1, int Seq2, int Seq3, int lseq, int *THold, unsigned char *tMissingData, short int *SeqNum, short int *SeqRnd);
extern "C" int FAR pascal CMaxD(int Seq1, int Seq2, int Seq3, int SBP, int EBP, int Nextno, int SLen, short int *SeqNum, short int *SeqnumX, unsigned char *Identical, char *NucMat, char *IncSeq2, char *IncSeq, float *E, float *d, float *VScoreMat, float *AvDist, int *TotCount);
extern "C" int FAR pascal CMaxD2(int incnum,int Seq1, int Seq2, int Seq3, int SBP, int EBP, int Nextno, int SLen, short int *SeqNum, short int *SeqnumX, int *IdenticalR, int *IdenticalF, unsigned char *NucMat,int *IncSeq3, unsigned char *IncSeq2, unsigned char *IncSeq, float *E, float *d, float *VScoreMat, float *AvDist, int *TotCount);
extern "C" int FAR pascal CMaxD3(int incnum, int SBP, int EBP, int Nextno, int SLen, short int *SeqNum, short int *SeqnumX, int *IdenticalR, int *IdenticalF, char *NucMat,int *IncSeq3, char *IncSeq2, int *ISeqs, float *E, float *d, float *VScoreMat, float *AvDist, int *TotCount);


extern "C" int FAR pascal UpdateMatrixRRP(int RSize, float *MatrixRRP, float *MatrixRX, float *MatrixRR);

extern "C" int FAR pascal FillMatrixC(int NDone, int X, int VarNum, int Nextno, char *tCMat, char *BinMat, char *MatrixC);
extern "C" int FAR pascal FillRegionMatX(int LSeq, int RSize, int ST, int EN, int *SCArray, float *PairDist, float *RegionMat);
extern "C" int FAR pascal FillTempDataset (int X, int Y, int Nextno, int LSeq, char *TempDataset, int TempMat) ;
extern "C" int FAR pascal ModMatPicTB(int cAddj, int SY, int SX, float XAD, int PosE0, int PosE1, int UBMP, int UBMC, float *MatPic, char *MatrixC);

extern "C" int FAR pascal ModMatPic(int cAddj, int SY, int SX, float XAD, int PosE0, int PosE1, int UBMP, int UBMC, float *MatPic, char *MatrixC);
extern "C" int FAR pascal MatCToMatPic(int SX, int SY, int PosE0, int PosE1, int UBMP, int UBMC, float *MatPic, char *MatrixC);
extern "C" int FAR pascal MatCToMatPicTB(int SX, int SY, int PosE0, int PosE1, int UBMP, int UBMC, float *MatPic, char *MatrixC);

extern "C" int FAR pascal DoAALineY(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture);
extern "C" int FAR pascal DoAALineYT(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture);
extern "C" int FAR pascal DoAALineXT(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture);
extern "C" int FAR pascal DoAALineX(float C, float M, float Y1, float Y2, float X1, float X2, int UBFP1, int UBFP2, float *FakePicture);



extern "C" int FAR pascal MakeFastLineList(int PC, int ExtraZ, int PHAdj, float dixb, float AmB, int LOffset,int GPrintLen, int PicHeight, float WFactor, int Y, int OriMod1, int UBDC, int OriMod2, int UBLL1, int UBGPP1, int UBGP1, float *CurveArray, float *GPrintMin, float *LineList, int *GPrintPos, float *GPrint, int *Decompress);

extern "C" int FAR pascal DrawRDPPlot(int Y, int LenXoverSeq, int UBL, int RDPLD, int RDPUD, int PicHeight, HDC Pict, double XFactor, int *XDiffpos,  int *XOverHomologyNum);
extern "C" int FAR pascal MakeBackups(int UBuDaught, int SE, int Nextno, int LSeq, unsigned char *MissingData, unsigned char *uMissingData, short int *SeqNum, unsigned char *uSeqNum, int *FFillCol, int *uFFillCol, int *SeqCol, int *uSeqCol,  unsigned char  *Daught,  unsigned char  *uDaught, float *Distance, float *uDistance, float *TreeDistance, float *uTreeDistance, int *TreeTrace, int *uTreeTrace);
//int FAR pascal          MakeBackups(int UBuDaught, int SE, int Nextno, int LSeq, unsigned char *MissingData, unsigned char *uMissingData, short int *SeqNum, unsigned char *uSeqNum, int *FFillCol, int *uFFillCol, int *SeqCol, int *uSeqCol, int *Daught, int *uDaught, float *Distance, float *uDistance, float *TreeDistance, float *uTreeDistance, int *TreeTrace, int *uTreeTrace){

extern "C" int FAR pascal ReplaceWithBackups(int UBuDaught, int SE, int Nextno, int LSeq, unsigned char *MissingData, unsigned char *uMissingData, short int *SeqNum, unsigned char *uSeqNum, int *FFillCol, int *uFFillCol, int *SeqCol, int *uSeqCol, unsigned char *Daught,  unsigned char  *uDaught, float *Distance, float *uDistance, float *TreeDistance, float *uTreeDistance, int *TreeTrace, int *uTreeTrace);
//int FAR pascal          ReplaceWithBackups(int UBuDaught, int SE, int Nextno, int LSeq, unsigned char *MissingData, unsigned char *uMissingData, short int *SeqNum, unsigned char *uSeqNum, int *FFillCol, int *uFFillCol, int *SeqCol, int *uSeqCol, int *Daught, int *uDaught, float *Distance, float *uDistance, float *TreeDistance, float *uTreeDistance, int *TreeTrace, int *uTreeTrace){

extern "C" int FAR pascal ScanNums(int Nextno, unsigned char *GrpMaskSeq, short int *MaskSeq);
extern "C" int far pascal AtomDists(int X,int UB, int TotAmino, double *AtomArray, double *MinDist);
extern "C" double FAR pascal FastDistA(int ISDim, int Nextno, int UBX, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB);
//double FAR pascal          FastDistA(int ISDim, int Nextno, int UBX, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB)

extern "C" double FAR pascal FastSimilarityA(int ISDim, int Nextno, int UBX, double *avdst, float *diffsx,float *validx, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB, short int *redodist);
extern "C" double FAR pascal FastSimilarityI(int ISDim, int Nextno, int UBX, double *avdst, float *diffsx,float *validx, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB, short int *redodist);
extern "C" int FAR pascal FindNextBranch(int TSH, float tTYF, int IStart, int TNum, int TType, int TDLenX, int *OS, char *GoOn, int *XX, float *TreeDraw);
extern "C" double FAR pascal FastSimilarityB(int df, int reps, int ISDim, int Nextno, int UBX,float *Valid, float *Diffs, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB, int *weightmod);


//double FAR pascal          FastSimilarityA(int ISDim, int Nextno, int UBX, double *avdst, float *diffsx,float *validx, short int *XCVal, short int *IntegerSeq, unsigned char *CompressValid, unsigned char *CompressDiffs, float *DistCheckB, short int *redodist);

extern "C" double FAR pascal ViterbiC(int SLen,int NumberAB, int NumberXY, double *OptXY, unsigned char *RecodeB, double *LaticeXY, double *TransitionM2,double *EmissionM2, double *LaticeAB);
extern "C" double FAR pascal ReverseC(int SLen,int NumberAB, int NumberXY, double *ValXY, double *OptXY, unsigned char *RecodeB, double *LaticeXY, double *TransitionM2,double *EmissionM2);
extern "C" double FAR pascal ForwardC(int SLen,int NumberAB, int NumberXY, double *ValXY, double *OptXY, unsigned char *RecodeB, double *LaticeXY, double *TransitionM2,double *EmissionM2);
extern "C" double FAR pascal GetLaticePath(int SLen, int NumberXY, double *LaticeXY, double *LaticeAB, int *LaticePath);
extern "C" double FAR pascal UpdateCounts(int SLen, int NumberABC, int NumberXY,  int *LaticePath, unsigned char *RecodeB, double *TransitionCount, double *StateCount);
extern "C" int FAR pascal MakeNumSeq (int Nextno, int SLen, int UBNS,int StartPosInAlign, int EndPosInAlign, unsigned char *ConvNumSeq, short int *SeqNum, unsigned char *NumSeq);
extern "C" int FAR pascal MakeISeq4 (int Nextno, int UBNS, int UBIS4, short int *SeqCompressor4, short int *ISeq4,  char *NumSeq);
extern "C" int FAR pascal ConvSimToDist(int SLen, int Nextno, int UBDistance, int UBPermvalid,  int UBFubvalid, int UBSubvalid,short int *RedoDist, float *Distance, float *FMat, float *SMat, float *PermValid, float *PermDiffs,   float *Fubvalid, float *Fubdiffs, float *SubValid, float *SubDiffs);
extern "C" int FAR pascal StartBlock(int D, int X, int UBMD, int LSeq, unsigned char *MissingData);
extern "C" int FAR pascal EndBlock(int C, int X, int UBMD, int LSeq, unsigned char *MissingData);
extern "C" int FAR pascal MakeTreeMatrix(int Nextno, int UBFM, int UBD, int UBTM, float *FMat, float *TreeMatrix, float *Distance);
extern "C" int FAR pascal MakeTreeFMat(int Nextno, int UBFM,  int UBTF, float *FMat, float *TreeFMat);
extern "C" int FAR pascal MakeTreeSMat(int Nextno, int UB4, int UBFM,  int UBTS, float *FMat, float *TreeSMat, float *SMat);

extern "C" int FAR pascal FillNuc(int X, int holder, int Nextno, int UBSN, int UBN, unsigned char *NucXX, unsigned char *NucMat2, short int *SeqNum);

extern "C" int FAR pascal MakeAA(int Nextno, int X, int UBSN, int *AA, unsigned char  *NucMat, short int *SeqNum);

extern "C" int FAR pascal MakeSC11(int X, int *y,int UBN11, int UBIS11,short int *ISeq11, short int *SeqCompressor11, unsigned char *Nuc11);
extern "C" int FAR pascal MakeSC12(int X, int *y,int UBN12, int UBIS12,short int *ISeq12, short int *SeqCompressor12, unsigned char *Nuc12);
extern "C" int FAR pascal MakeSC13(int X, int *y,int UBN13, int UBIS13,short int *ISeq13, short int *SeqCompressor13, unsigned char *Nuc13);
extern "C" int FAR pascal MakeSC14(int X, int *y,int UBN14, int UBIS14,short int *ISeq14, short int *SeqCompressor14, unsigned char *Nuc14);
extern "C" int FAR pascal MakeSC04(int X, int *y,int UBN04, int UBIS04,short int *ISeq04, short int *SeqCompressor04, unsigned char *Nuc04);
extern "C" int FAR pascal MakeSC03(int X, int *y,int UBN03, int UBIS03,short int *ISeq03, short int *SeqCompressor03, unsigned char *Nuc03);
extern "C" int FAR pascal MakeSC02(int X, int *y,int UBN02, int UBIS02,short int *ISeq02, short int *SeqCompressor02, unsigned char *Nuc02);

extern "C" int FAR pascal EraseEmpties(int Nextno, int UB, int UBFM, int SCO, int *ISeqs, float *FMat, float *FubValid, float *SMat, float *SubValid);
extern "C" int FAR pascal ClearNodeArrays(int PermNextno,int TType, int UBNF, int UBNMR, int UBNXY1, int UBNXY2, float *NodeMaxRep,  unsigned char *NodeFind, int *NodeXY);


extern "C" int FAR pascal MakeTreeD(int UBTD, int UBND, int UBSB, int NumberOfSeqs, float *LLen, float *TreeD, float  *SeqXPos, short int *NodeDepth, short int *SepBranch);
extern "C" int FAR pascal GetSeqXPos(int UBND1, int UBND2, int CCount, int NumberOfSeqs, short int *NodeDepth, short int *Done, float *NodeXPos, float *LLen, float *SeqXPos, float *NameXPos);
extern "C" int FAR pascal ClearNumTaxa(int NC, int Nextno, int *NumTaxa);

extern "C" int FAR pascal MakeDistanceBak(int UBD, int UBDB, int Nextno, float *Distance, float *DistanceBak);

extern "C" int FAR pascal FillNodeMaxRep(int TType, int PermNextno, int Nextno, int ubnf, int ubtrx, int ubtry, int ubtts, int ubtt, int ubsc, float *NodeMaxRep ,char *NodeFind, short int *TreeRY, short int *TreeRX, float *SeqCoverage, int *TreeTraceSeqs, int *TreeTrace);

extern "C" int FAR pascal MakeSeqCoverageC(int SF, int Nextno, int UBSV, int UBTTS, int UBSC, float *SubValid, float *SeqCoverage, int *TreeTraceSeqs, int *TreeTrace);

extern "C" int FAR pascal ExtraRemovals(int Nextno, int UBF, int UBS, int *ISeqs, int *ExtraRemove, float *FMat, float *SMat);
extern "C" int FAR pascal ExtraRemovals2(int Nextno, int UBF, int UBS, int *ISeqs, int *ExtraRemove, float *FMat, float *SMat);

extern "C" double FAR pascal QuickDist5(int lseq, int Nextno, int ub, int BPos3, int EPos3, float *SMat, float *SubValid, float *SubDiffs, short int *SeqNum);
extern "C" double FAR pascal QuickDist6(int lseq, int Nextno, int ub, int BPos3, int EPos3, int *iseqs, float *SMat, float *SubValid, float *SubDiffs, short int *SeqNum);

extern "C" int FAR pascal MakeNTS(int NT, int SelGrpFlag,int NumSeqs, short int *TDist, unsigned char *GrpM, int *NTS);
extern "C" int FAR pascal MakeAnalysisListX(int UBAL, int MaxNums, int UBNTS, int SelGrpFlag,int NumSeqs, short int *TDist, unsigned char *GrpM, int *NTS, short int *AnalysisList, int *NTS2, int *SeqList);

extern "C" int FAR pascal MakeTrpListLen (int X, int UB1, int *TripListLen, short int *AnalysisList, int *DoubListLen, short int *DoubList, short int *SVx, short int *SDx, short int *AlistTrace, float *Distance);

extern "C" int FAR pascal MakeuBackups(int LSeq, int SE, int UBDaught, int Nextno, char *uMissingData, char *MissingData,char *uSeqNum, short int *SeqNum,int *uFFillCol, int *FFillCol,int *uSeqCol, int *SeqCol, unsigned char  *uDaught,  unsigned char  *Daught, int *uTreeTrace, int *TreeTrace);
extern "C" int FAR pascal ReplaceuBackups(int LSeq, int SE, int UBDaught, int Nextno, char *uMissingData, char *MissingData,char *uSeqNum, short int *SeqNum,int *uFFillCol, int *FFillCol,int *uSeqCol, int *SeqCol, unsigned char  *uDaught,  unsigned char  *Daught, int *uTreeTrace, int *TreeTrace);

extern "C" double FAR pascal SuperDist(int X, int Nextno, int UB14, int UB04, int UB13, int UB03, int UB12, int UB02, int UB11, double *avdst, float *pd, float *pv, float *dist, short int *redodist, int *SeqCatCount, short int *ISeq14, short int *ISeq04, short int *ISeq13, short int *ISeq03, short int *ISeq12, short int *ISeq02, short int *ISeq11, char *CompressValid14, char *CompressDiffs14, char *CompressValid13, char *CompressDiffs13, char *CompressValid12, char *CompressDiffs12, char *CompressValid11, char *CompressDiffs11,  char *CompressDiffs04,  char *CompressDiffs03, char *CompressDiffs02);

extern "C" int FAR pascal SuperDist2(int Nextno, int UB14, int UB04, int UB13, int UB03, int UB12, int UB02, int UB11, int *SeqCatCount, short int *ISeq14, short int *ISeq04, short int *ISeq13, short int *ISeq03, short int *ISeq12, short int *ISeq02, short int *ISeq11, char *CompressValid14, char *CompressDiffs14, char *CompressValid13, char *CompressDiffs13, char *CompressValid12, char *CompressDiffs12, char *CompressValid11, char *CompressDiffs11,  char *CompressDiffs04,  char *CompressDiffs03, char *CompressDiffs02);

extern "C" int FAR pascal CopyDistandFindMinMax(int Nextno, int UBT, int UBD, float *MaxDistSch, float *MinDistSch, float *TDistance, float *Distance);
extern "C" int FAR pascal MakeSeqCatCount (int Nextno, int LSeq, int UBSN1, int UBSCC1, int StartPosInAlign,int EndPosInAlign,  int *SeqCatCount, int *AA, short int *SeqNum, unsigned char *NucMat, short int *Redo);

extern "C" int FAR pascal MakeNucSets(int Nextno, int LSeq,int UBSN1, int UBSCC1, int  StartPosInAlign, int EndPosInAlign,int *AA, unsigned char *NucMatB, unsigned char *Nuc11, unsigned char *Nuc02, unsigned char *Nuc12, unsigned char *Nuc03, unsigned char *Nuc13, unsigned char *Nuc04, unsigned char *Nuc14, int *SeqCatCount, short int *SeqNum, unsigned char *NucMat, unsigned char *NucMat2, unsigned char *SeqCat, unsigned char *SeqSpace);
extern "C" int FAR pascal MakeNucSets3(int UBFLP, int Nextno, int StartPosInAlign, int EndPosInAlign, int ub11,int ub12,int ub13,int ub14,int ub02,int ub03,int ub04, unsigned char *NL, unsigned char *ML, unsigned char *FLP, unsigned char *Nuc11, unsigned char *Nuc02, unsigned char *Nuc12, unsigned char *Nuc03, unsigned char *Nuc13, unsigned char *Nuc04, unsigned char *Nuc14);

extern "C"  int FAR pascal ModFP(int UBFP1, int UBFP2,  float *maxv, float *FakePicture);
extern "C"  int FAR pascal AddFPX(int UBFP1, int StepDir, int IY, int X1, int X2, float TopS, float BotS, float *FakePicture);
extern "C"  int FAR pascal AddFPY(int UBFP1, int StepDir, int IX, int Y1, int Y2, float TopS, float BotS, float *FakePicture);


extern "C" unsigned char FAR pascal FixOverlaps(unsigned char DoneThisOne, int CurBegin, int CurEnd, int CurProg, int X, int Y, int MSX, float LSAdjust,int UBPD, int UBXONC1, int UBXONC2, unsigned char *ProgDo,short int *XOverNoComponent, short int *MaxXONo);
extern "C" int FAR pascal MakeMatrixRRX(int RSize, int UBRRX, int UBRRP, float MaxN, float cov1, float cov2,float *MatrixRRP, float *MatrixRRX);
extern "C" int FAR pascal CopySingleDist(int UB, int UBPVX, int UBPV, float *PermValidx, float *PermValid, float *PermDiffsx, float *PermDiffs);
extern "C" int FAR pascal MakeValTots(int Nextno, int SCO, int UBX, int UBFM, int UBFV, int UBMP, int *ValtotS, int *ValtotF, int *ISeqs, unsigned char *MissPair, float *FubValid, float *SubValid, float *FMat, float *SMat);
extern "C" int FAR pascal MakeSeqCatCount2 (int Nextno, int LSeq, int UBSN1, int UBSCC1, int StartPosInAlign,int EndPosInAlign,  int *SeqCatCount,  int *AA, short int *SeqNum, unsigned char *NucMat,  unsigned char *SeqSpace, unsigned char  *NucMatB, unsigned char  *NucMat2, unsigned char *flp, unsigned char *ml, unsigned char *nl);
extern "C" int FAR pascal FillNucXX(int NXX, int Nextno, int X, int UBNXX, int UBFLP, unsigned char * NucXX, unsigned char *FLP);

extern "C" int FAR pascal ReAddToRList(int Nextno, int UBTRL, int UBRL, int *tRList, int *RList, int *RNum);
extern "C" int FAR pascal CopyEventInfo(int SEventNumber, int Nextno, int UBoD, int UBD, int UBE, int UBOE, int *BestEvent, int *OBE, unsigned char *oD, unsigned char *oMi, unsigned char *oMa, unsigned char *Daught, unsigned char *MinorPar, unsigned char *MajorPar);
extern "C" int FAR pascal DoAABlocks(int xRes, int yRes, int UBPC, int UBIX, int UBID22, int UBID23, int UBID12, int UBID13, int *PCount, int *ImageX, unsigned char *ImageData, unsigned char *ImageData2);

extern "C" int FAR pascal MakeImageDataBO(int R, int G, int B, int UBFP, int UBID1, int UBID2, int UBID3,float *FakePicture, unsigned char *ImageData);
extern "C" int FAR pascal FillObject(int UBFP1, int UBFP2, float *FakePicture, float *FakePicture2, float *FakePicture3);
extern "C" int FAR pascal ReMakeDistance(int LSeq, int Nextno, int UBD,  float *SM,  float *Distance, float *PermValid, float *PermDiffs);
extern "C" int FAR pascal FillColDist(int Col, int X, int tnt, int Nextno, int UBSN, int UBCD,int UBSCR, short int *SeqNum, short int *ColDist, unsigned char *SeqColRef);
extern "C" int FAR pascal FillColDist2(int PCounter, int X, int tnt, int Nextno, int UBSN, short int *SeqNum, short int *ColDist2);

extern "C" int FAR pascal FillSeqLines2(int NumSeqLines, int Offset1, int Offset2, int Offset4, int RSN1, int Col1, int Col2, int Col3, int Col4, int UBSL, short int *ColDist2, int *SeqLines,unsigned char *SeqColRef2, int *ColPos2);
extern "C" int FAR pascal EmptyNodeFind(int PermNextno, int UBNF, int UBNMR, unsigned char *NodeFind, float *NodeMaxRep);

extern "C" int FAR pascal FillVSiteMatC(int Nextno, int PS1, int PS2, int UBSN, int UBSL, int UBVSM, int *SList, int *PermPlantNum, int *VSitesMat, int *OffsetPerm, int *DiffPos, int LSub, short int *SeqNum, unsigned char *WorthDoing);

extern "C" int FAR pascal FindDupFlash(int A, int B, int UBF, int *FlashntNum, int *Flashnt);

extern "C" int FAR pascal P11Draw(int Chunk, int LSeq, int SSB, float MinID, int UBID1, int UBID2, float Interval,short int HeightOfWindow, float StepSizeC, int *Decompress, float *DisplayID, unsigned char *ImageData);
extern "C" int FAR pascal P4Draw(int Chunk, int LSeq, int SSB, float MinID, int UBID1, int UBID2, float IV,short int HeightOfWindow, float StepSizeC, int *Decompress, float *DisplayID, unsigned char *ImageData);
extern "C" int FAR pascal TestPerms(int LSub, int UBCH1, int UBCH2, int UBCR1, int UBVSM1, int UBVSM2, float *HigherMat, float *LowerMat, int *VSitesMatP, int *VSitesMat, float *ChiResult,float *ChiResultP, int *ChiHigher);
extern "C" int FAR pascal TestPerms2(int LSub, int UBCH1, int UBCH2, int UBCR1, int UBVSM1, int UBVSM2, float *HigherMat, float *LowerMat, int *VSitesMatP, int *VSitesMat, float *ChiResult,float *ChiResultP, int *ChiHigher, float *TN);
extern "C" int FAR pascal DoAALineXY(int UBFP1, int UBFP2, int UBLL1, int UBLL2, float *FakePicture, float *LineList);
extern "C" int FAR pascal FillORFWin(int Z, int FrameRef, int SIL, int EIL, int UBOW1, int UBOW2, short int *ORFWin);
extern "C" int FAR pascal GetNumInListC(int Seq1, int Seq2, int Seq3, int *S1S2, int *S2S3);


#endif
