/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Reporting%20Groups%20-%20Reporting%20Group.sql $:
 * $Id: Manage Benefit Reporting Groups - Reporting Group.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT benRPTGGRPEO.NAME RES_NAME
,benRPTGGRPEO.RPG_DESC RES_DESCRIPTION
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_CODE = benRPTGGRPEO.RPTG_PRPS_CD 
	AND LOOKUP_TYPE = 'BEN_RPTG_PRPS' 
	AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY'))
	)  RES_USAGE
,DECODE(benRPTGGRPEO.GLOBAL_FLAG,'Y','Yes','No') RES_GLOBAL
,benRPTGGRPEO.LAST_UPDATED_BY 			RSC_LAST_UPDATED_BY
,benRPTGGRPEO.LAST_UPDATE_DATE 			RSC_LAST_UPDATE_DATE
,benRPTGGRPEO.CREATED_BY 				RSC_CREATED_BY
,benRPTGGRPEO.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,benRPTGGRPEO.LEGISLATION_CODE RSC_COUNTRY_ID
FROM BEN_RPTG_GRP_VL benRPTGGRPEO