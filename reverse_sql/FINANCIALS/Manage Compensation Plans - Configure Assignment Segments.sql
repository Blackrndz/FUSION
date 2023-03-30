/* ****************************************************************************
 * $Revision: 72749 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-10-23 15:22:46 +0700 (Wed, 23 Oct 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Availability%20Lookups%20-%20Lookup%20Types.sql $:
 * $Id: Manage Availability Lookups - Lookup Types.sql 72749 2019-10-23 08:22:46Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=CMP_PLANS_VL
 
SELECT cmpPLANEO.PLAN_NAME RES_PLAN
,DECODE(cmpPLANEO.ENABLE_ASSIGNMENT_SEGMENTS,'Y','Yes','No') RES_ENABLE_ASSIGNMENT_SEGMENTS
,DECODE(cmpPLANEO.ASG_SEG_RECORD_TYPE_CODE,'Y','Yes','No') RES_RECORD_TYPE
,DECODE(cmpPLANEO.ASG_SEG_SHOW_INELIG_ROWS_FLAG,'Y','Yes','No') RES_SHOW_INELIGIBLE_ROWS
,DECODE(cmpPLANEO.ASG_SEG_SHOW_DETACH_FLAG,'Y','Yes','No') RES_SHOW_DETACH_ICON
,DECODE(cmpCSTME0.ITEM_NAME,'AssignmentNumber_ASEG','Assignment Number', 'CurrencyCode_ASEG','Currency Code', 'Column61_ASEG','Date Column 61', 'Column62_ASEG','Date Column 62', 'Column63_ASEG'
,'Date Column 63','Column64_ASEG','Date Column 64', 'Column65_ASEG','Date Column 65','EligibilityStatus_ASEG','Eligibility Status', 'EndDate_ASEG','End Date','ExternalWorkerDataId_ASEG'
,'External Worker Data ID', 'Job_ASEG','Job', 'LegalEmployer_ASEG','Legal Employer', 'Column1_ASEG','Numeric Column 1', 'Column10_ASEG','Numeric Column 10', 'Column11_ASEG','Numeric Column 11'
,'Column12_ASEG','Numeric Column 12', 'Column13_ASEG','Numeric Column 13', 'Column14_ASEG','Numeric Column 14', 'Column15_ASEG','Numeric Column 15', 'Column16_ASEG','Numeric Column 16', 'Column17_ASEG'
,'Numeric Column 17','Column18_ASEG','Numeric Column 18','Column19_ASEG','Numeric Column 19','Column2_ASEG','Numeric Column 2', 'Column20_ASEG'
,'Numeric Column 20','Column21_ASEG','Numeric Column 21','Column22_ASEG','Numeric Column 22','Column23_ASEG','Numeric Column 23', 'Column24_ASEG','Numeric Column 24'
,'Column25_ASEG','Numeric Column 25','Column26_ASEG','Numeric Column 26','Column27_ASEG','Numeric Column 27','Column28_ASEG','Numeric Column 28','Column29_ASEG'
,'Numeric Column 29','Column3_ASEG','Numeric Column 3','Column30_ASEG','Numeric Column 30', 'Column31_ASEG','Numeric Column 31','Column32_ASEG','Numeric Column 32','Column33_ASEG'
,'Numeric Column 33', 'Column34_ASEG','Numeric Column 34', 'Column35_ASEG','Numeric Column 35', 'Column36_ASEG','Numeric Column 36', 'Column37_ASEG','Numeric Column 37', 'Column38_ASEG'
,'Numeric Column 38', 'Column39_ASEG','Numeric Column 39', 'Column4_ASEG','Numeric Column 4', 'Column40_ASEG','Numeric Column 40', 'Column41_ASEG','Numeric Column 41', 'Column42_ASEG','Numeric Column 42'
,'Column43_ASEG','Numeric Column 43','Column44_ASEG','Numeric Column 44', 'Column45_ASEG','Numeric Column 45', 'Column46_ASEG','Numeric Column 46', 'Column47_ASEG','Numeric Column 47', 'Column48_ASEG'
,'Numeric Column 48', 'Column49_ASEG','Numeric Column 49', 'Column5_ASEG','Numeric Column 5', 'Column50_ASEG','Numeric Column 50', 'Column6_ASEG','Numeric Column 6', 'Column7_ASEG','Numeric Column 7'
,'Column8_ASEG','Numeric Column 8', 'Column9_ASEG','Numeric Column 9', 'PersonName_ASEG','Person Name', 'PersonNumber_ASEG','Person Number','RecordType_ASEG','Record Type', 'SequenceNumber_ASEG'
,'Sequence Number', 'StartDate_ASEG','Start Date', 'Column51_ASEG','Text Column 51','Column52_ASEG','Text Column 52','Column53_ASEG','Text Column 53','Column54_ASEG','Text Column 54','Column55_ASEG'
,'Text Column 55', 'Column56_ASEG','Text Column 56', 'Column57_ASEG','Text Column 57','Column58_ASEG','Text Column 58','Column59_ASEG','Text Column 59','Column60_ASEG','Text Column 60','WorkerNumber_ASEG','Worker Number') RES_COLUMN
,DECODE(cmpCSTME0.DISPLAY_FLAG,'Y','Yes','No')  RES_ENABLE
,cmpCSTME0.DISPLAY_NAME RES_DISPLAY_NAME
,cmpCSTME0.ORDER_NUM RES_DEFAULT_SEQUENCE
,NULL RES_PROPERTIES
,NULL RES_TOTALING_COLUMN



,cmpCSTME0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpCSTME0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpCSTME0.CREATED_BY RSC_CREATED_BY
,cmpCSTME0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_PLANS_VL cmpPLANEO
,CMP_CSTM_REGION_ITEMS_VL cmpCSTME0

WHERE cmpPLANEO.PLAN_ID = cmpCSTME0.CUSTOM_KEY
AND cmpPLANEO.COMP_TYPE = 'CWB'
AND cmpCSTME0.REGION_NAME = 'WRKSHT_ASSIGN_SEG_REG'
ORDER BY PLAN_NAME,RES_COLUMN