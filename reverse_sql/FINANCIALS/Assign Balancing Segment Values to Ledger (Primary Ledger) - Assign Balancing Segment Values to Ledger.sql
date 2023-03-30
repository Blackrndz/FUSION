/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Assign%20Balancing%20Segment%20Values%20to%20Ledger%20(Primary%20Ledger)%20-%20Assign%20Balancing%20Segment%20Values%20to%20Ledger $:
 * $Id: Assign Balancing Segment Values to Ledger (Primary Ledger) - Assign Balancing Segment Values to Ledger.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select QRSLT.NAME1  RES_PRIMARY_LEDGER 
, QRSLT.SEGMENT_VALUE RES_SEGMENT_VALUE
,QRSLT.DESCRIPTION1 RES_DESCRIPTION
,TO_CHAR(START_DATE,'DD-Mon-YYYY')  RES_START_DATE
,TO_CHAR(END_DATE,'DD-Mon-YYYY') RES_END_DATE
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,QRSLT.LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
from (SELECT	
LedgerBSVAssignmentEO.END_DATE
,LedgerBSVAssignmentEO.CREATED_BY
,LedgerBSVAssignmentEO.CREATION_DATE
,LedgerBSVAssignmentEO.LAST_UPDATE_DATE
,LedgerBSVAssignmentEO.LAST_UPDATED_BY
,LedgerBSVAssignmentEO.SEGMENT_VALUE
,LedgerBSVAssignmentEO.START_DATE
,LedgerBSVAssignmentEO.LEDGER_ID
,LedgerBSVAssignmentEO.LEGAL_ENTITY_ID
,ValueSetValuePEO.DESCRIPTION        AS DESCRIPTION1
,GlLedgers.NAME AS NAME1
FROM GL_LEDGER_NORM_SEG_VALS LedgerBSVAssignmentEO
,FND_KF_LABELED_SEGMENTS KeyFlexfieldLabeledSegmentPE1
,FND_KF_SEGMENT_INSTANCES KeyFlexfieldSegmentInstanceP1
,FND_KF_STR_INSTANCES_VL KeyFlexfieldStructureInstanc1
,FND_VS_VALUES_VL ValueSetValuePEO
,GL_LEDGERS GlLedgers
WHERE KeyFlexfieldLabeledSegmentPE1.SEGMENT_CODE            = KeyFlexfieldSegmentInstanceP1.SEGMENT_CODE
AND KeyFlexfieldSegmentInstanceP1.VALUE_SET_ID              = ValueSetValuePEO.VALUE_SET_ID
AND KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_ID     = KeyFlexfieldSegmentInstanceP1.STRUCTURE_INSTANCE_ID
AND KeyFlexfieldStructureInstanc1.STRUCTURE_ID              = KeyFlexfieldLabeledSegmentPE1.STRUCTURE_ID
AND KeyFlexfieldStructureInstanc1.STRUCTURE_INSTANCE_NUMBER = GlLedgers.CHART_OF_ACCOUNTS_ID
AND KeyFlexfieldStructureInstanc1.KEY_FLEXFIELD_CODE        = 'GL#'
AND KeyFlexfieldLabeledSegmentPE1.SEGMENT_LABEL_CODE        = 'GL_BALANCING'
AND LedgerBSVAssignmentEO.LEDGER_ID                         = GlLedgers.LEDGER_ID
AND LedgerBSVAssignmentEO.SEGMENT_VALUE                     = ValueSetValuePEO.VALUE
and LedgerBSVAssignmentEO.SLA_SEQUENCING_FLAG               = 'N' 
AND(LedgerBSVAssignmentEO.STATUS_CODE                      IS NULL
or LEDGERBSVASSIGNMENTEO.STATUS_CODE                       != 'D')
and GLLEDGERS.LEDGER_CATEGORY_CODE								  ='PRIMARY'
) QRSLT  
ORDER BY QRSLT.NAME1,QRSLT.SEGMENT_VALUE