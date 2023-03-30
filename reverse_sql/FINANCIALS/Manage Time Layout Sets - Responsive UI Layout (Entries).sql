/* ****************************************************************************
 * $Revision: 71972 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-05-07 10:16:43 +0700 (Tue, 07 May 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Time%20Layout%20Sets%20-%20Time%20Entry%20Layout%20(Entry%20Level%20Details).sql $:
 * $Id: Manage Time Layout Sets - Time Entry Layout (Entry Level Details).sql 71972 2019-05-07 03:16:43Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HXT_TCLAY_V

SELECT RES_LAYOUT_NAME
,RES_TIME_CARD_TYPE
,RES_DEFAULT_VIEW

,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM 
(SELECT DISTINCT hxtTCLAYEO.NAME RES_LAYOUT_NAME
,(CASE WHEN hxtTCLATVEO.TCLAY_TYPE LIKE '%Indiv'
	THEN 'Worker'
	ELSE 'Manager' END) RES_TIME_CARD_TYPE
,DECODE(matrixE0.TCLAYFLD_ATTRIBUTE_CHAR14,'ORA_HWM_VIEWBY_ALL','Reported details by entry date'
,'ORA_HWM_VIEWBY_SUMMARY','Reported summary by entry date'
,'ORA_HWM_VIEWBY_CALCULATED','Calculated details by earned date'
,'ORA_HWM_VIEWBY_CAL_SUM','Calculated summary by earned date') RES_DEFAULT_VIEW

,matrixE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,matrixE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,matrixE0.CREATED_BY RSC_CREATED_BY
,matrixE0.CREATION_DATE RSC_CREATION_DATE
	
FROM HXT_TCLAYST_VL hxtTCLAYEO   
,HXT_TCLAY_B hxtTCLATVEO
,(SELECT * FROM HXT_TCLAYFLD_DEFNS_VL WHERE TCLAYFLD_ATTRIBUTE_CATEGORY IN 'MATRIX_PARAMS') matrixE0


WHERE hxtTCLAYEO.TCLAYST_ID =  hxtTCLATVEO.TCLAYST_ID
AND hxtTCLATVEO.TCLAY_ID = matrixE0.TCLAY_ID
AND hxtTCLATVEO.TCLAY_TYPE LIKE 'Responsive UI%'
)

ORDER BY RES_LAYOUT_NAME,RES_TIME_CARD_TYPE


