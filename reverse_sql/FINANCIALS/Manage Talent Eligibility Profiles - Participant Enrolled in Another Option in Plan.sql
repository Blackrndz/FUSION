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
,benELIGENRLDANTHROIPLEO.ORDR_NUM RES_SEQUENCE
,(SELECT benP.NAME||'-'||benO.NAME 
	FROM BEN_OPT_F benO
	,BEN_PL_F benP 
	WHERE benO.OPT_ID = benOIPLEO.OPT_ID 
	AND benP.PL_ID = benOIPLEO.PL_ID
	AND SYSDATE BETWEEN benP.EFFECTIVE_START_DATE AND NVL(benP.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	AND SYSDATE BETWEEN benO.EFFECTIVE_START_DATE AND NVL(benO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	) RES_OPTION_IN_PLAN
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LANGUAGE = USERENV('LANG') 
	AND LOOKUP_TYPE = 'BEN_ENRL_DET_DT' 
	AND LOOKUP_CODE = benELIGENRLDANTHROIPLEO.ENRL_DET_DT_CD 
	) RES_DATE_DETERMINATION_RULE
,DECODE(benELIGENRLDANTHROIPLEO.EXCLD_FLAG,'Y','Yes','No') RES_EXCLUDE
,TO_CHAR(benELIGENRLDANTHROIPLEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(benELIGENRLDANTHROIPLEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,benELIGENRLDANTHROIPLEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benELIGENRLDANTHROIPLEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benELIGENRLDANTHROIPLEO.CREATED_BY  RSC_CREATED_BY
,benELIGENRLDANTHROIPLEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ELIGY_PRFL benELIGYEO
,BEN_ELIG_ENRLD_ANTHR_OIPL benELIGENRLDANTHROIPLEO
,BEN_OIPL_F benOIPLEO
WHERE SYSDATE BETWEEN benELIGYEO.START_DATE AND NVL(benELIGYEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND benELIGYEO.ELIGY_PRFL_ID = benELIGENRLDANTHROIPLEO.ELIGY_PRFL_ID 
AND benELIGYEO.END_DATE BETWEEN benELIGENRLDANTHROIPLEO.START_DATE AND NVL(benELIGENRLDANTHROIPLEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND benELIGENRLDANTHROIPLEO.OIPL_ID = benOIPLEO.OIPL_ID
AND benELIGENRLDANTHROIPLEO.END_DATE BETWEEN benOIPLEO.EFFECTIVE_START_DATE AND NVL(benOIPLEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY benELIGYEO.NAME
,benELIGENRLDANTHROIPLEO.ORDR_NUM