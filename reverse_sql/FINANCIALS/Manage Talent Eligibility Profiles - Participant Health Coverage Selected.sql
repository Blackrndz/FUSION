/* ****************************************************************************
* $Revision: 55345 $:
* $Author: wuttipong.thongvises $:
* $Date: 2016-05-23 12:42:33 +0700 (Mon, 23 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Server%20Configurations%20-%20Manage%20Data%20Quality%20Server%20Configurations.sql $:
* $Id: Manage Server Configurations - Manage Data Quality Server Configurations.sql 55345 2016-05-23 05:42:33Z
wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT benELIGYEO.NAME RES_NAME
,benELIGHLTHCVGEO.ORDR_NUM RES_SEQUENCE
,(SELECT a.NAME||' - '||b.name 
	FROM BEN_PL_TYP_F a
	,BEN_OPT_F b 
	WHERE a.PL_TYP_ID = benPLTYPOPTYEO.PL_TYP_ID
	AND b.OPT_ID = benPLTYPOPTYEO.OPT_ID
	AND benPLTYPOPTYEO.EFFECTIVE_END_DATE BETWEEN a.EFFECTIVE_START_DATE AND NVL(a.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	AND a.EFFECTIVE_END_DATE BETWEEN b.EFFECTIVE_START_DATE AND NVL(b.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	) RES_PLAN_TYPE_AND_OPTION_NAME
,(SELECT NAME 
	FROM BEN_PL_F 
	WHERE PL_ID = benOIPLEO.PL_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	) RES_PLAN_NAME
,DECODE(benELIGHLTHCVGEO.EXCLD_FLAG,'Y','Yes','No') RES_EXCLUDE
,TO_CHAR(benELIGHLTHCVGEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(benELIGHLTHCVGEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,benELIGHLTHCVGEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benELIGHLTHCVGEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benELIGHLTHCVGEO.CREATED_BY  RSC_CREATED_BY
,benELIGHLTHCVGEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ELIGY_PRFL benELIGYEO
,BEN_ELIG_HLTH_CVG_PRTE benELIGHLTHCVGEO
,BEN_PL_TYP_OPT_TYP_F benPLTYPOPTYEO
,BEN_OIPL_F benOIPLEO
WHERE SYSDATE BETWEEN benELIGYEO.START_DATE AND NVL(benELIGYEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND benELIGYEO.ELIGY_PRFL_ID = benELIGHLTHCVGEO.ELIGY_PRFL_ID 
AND benELIGYEO.END_DATE BETWEEN benELIGHLTHCVGEO.START_DATE AND NVL(benELIGHLTHCVGEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND benELIGHLTHCVGEO.PL_TYP_OPT_TYP_ID = benPLTYPOPTYEO.PL_TYP_OPT_TYP_ID
AND benELIGHLTHCVGEO.END_DATE BETWEEN benPLTYPOPTYEO.EFFECTIVE_START_DATE AND NVL(benPLTYPOPTYEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND benELIGHLTHCVGEO.OIPL_ID = benOIPLEO.OIPL_ID
AND benPLTYPOPTYEO.EFFECTIVE_END_DATE BETWEEN benOIPLEO.EFFECTIVE_START_DATE AND NVL(benOIPLEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY benELIGYEO.NAME
,benELIGHLTHCVGEO.ORDR_NUM