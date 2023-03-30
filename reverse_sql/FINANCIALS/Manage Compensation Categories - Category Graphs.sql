/* ****************************************************************************
* $Revision: 72658 $:
* $Author: tanawat.wongjan $:
* $Date: 2019-10-01 15:00:45 +0700 (Tue, 01 Oct 2019) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20SCM%20Common%20Value%20Sets%20-%20Manage%20SCM%20Common%20Value%20Sets.sql $:
* $Id: Manage SCM Common Value Sets - Manage SCM Common Value Sets.sql 55804 2016-06-09 04:17:45Z wuttipong.thongvises
$:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CMP_TCS_CAT_VL

SELECT compCatsE0.NAME RES_CATEGORY_NAME
,DECODE(compCatsE0.HIDE_CHART_RN_FLAG,'Y','Yes','No') RES_DO_NOT_DISPLAY_GRAPHS
,compCatsE0.CHART1_TITLE RES_GRAPH_TITLE_FIRST_GRAPH
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'CMP_TCS_GRAPH_TYPE'
    AND LOOKUP_CODE = compCatsE0.CHART1_TYPE_CD
    ) RES_GRAPH_TYPE_FIRST_GRAPH
,DECODE(selfConsE0.INCLUDE_IN_CHART1_FLAG,'Y','Yes','No') RES_GRAPH_ITEMS_FIRST_GRAPH_YO --Graph Items - First Graph - Your Contribution
,DECODE(companyConsE0.INCLUDE_IN_CHART1_FLAG,'Y','Yes','No') RES_GRAPH_ITEMS_FIRST_GRAPH_CO --Graph Items - First Graph - Company Contribution

,'' RES_GRAPH_ITEMS_FIRST_GRAPH_US --Graph Items - First Graph - User-Defined Column 3
,'' RES_GRAPH_ITEMS_FIRST_GRAPH__0 --Graph Items - First Graph - User-Defined Column 4
,'' RES_GRAPH_ITEMS_FIRST_GRAPH__1 -- raph Items - First Graph - User-Defined Column 5

,compCatsE0.CHART2_TITLE RES_GRAPH_TITLE_SECOND_GRAPH
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'CMP_TCS_GRAPH_TYPE'
    AND LOOKUP_CODE = compCatsE0.CHART2_TYPE_CD
    ) RES_GRAPH_TYPE_SECOND_GRAPH
,DECODE(selfConsE0.INCLUDE_IN_CHART2_FLAG,'Y','Yes','No') RES_GRAPH_ITEMS_SECOND_GRAPH_Y --Graph Items - Second Graph - Your Contribution
,DECODE(companyConsE0.INCLUDE_IN_CHART2_FLAG,'Y','Yes','No') RES_GRAPH_ITEMS_SECOND_GRAPH_C --Graph Items - Second Graph - Company Contribution

,'' RES_GRAPH_ITEMS_SECOND_GRAPH_U --Graph Items - Second Graph - User-Defined Column 3
,'' RES_GRAPH_ITEMS_SECOND_GRAPH_2 --Graph Items - Second Graph - User-Defined Column 4
,'' RES_GRAPH_ITEMS_SECOND_GRAPH_3 --Graph Items - Second Graph - User-Defined Column 5

,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'ERC_TOTSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS_FI --Nonmonetary Graph Items - First Graph - Total Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'GRNTSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS__4 --Nonmonetary Graph Items - First Graph - Original Shares Granted
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS__5 --Nonmonetary Graph Items - First Graph - Vested Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTEXSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS__6 --Nonmonetary Graph Items - First Graph - Exercised
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTUNEXSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS__7 --Nonmonetary Graph Items - First Graph - Exercisable
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'UNVESTSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS__8 --Nonmonetary Graph Items - First Graph - Unvested Shares
	

,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'ESTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_FIRST --Monetary Graph Items - First Graph - Estimated value
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'ESTMKTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_FIR_9 --Monetary Graph Items - First Graph - Estimated Market Value of Total Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTESTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_FI_10 --Monetary Graph Items - First Graph - Estimated Value of Vested Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTESTMKTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_FI_11 --Monetary Graph Items - First Graph - Estimated Market Value of Vested Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTESTUNEXVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_FI_12 --Monetary Graph Items - First Graph - Estimated Value of Exercisable Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTESTUNEXMKTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_FI_13 --Monetary Graph Items - First Graph - Estimated Market Value of Exercisable Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'UNVESTESTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_FI_14 --Monetary Graph Items - First Graph - Estimated Value of Unvested Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'UNVESTESTMKTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_FI_15 --Monetary Graph Items - First Graph - Estimated Market Value of Unvested Shares


,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'ERC_TOTSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS_SE --Nonmonetary Graph Items - Second Graph - Total Shares
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'GRNTSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS_16 --Nonmonetary Graph Items - Second Graph - Original Shares Granted
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS_17 --Nonmonetary Graph Items - Second Graph - Vested Shares
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTEXSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS_18 --Nonmonetary Graph Items - Second Graph - Exercised
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTUNEXSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS_19 --Nonmonetary Graph Items - Second Graph - Exercisable
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'UNVESTSHARES'
    AND CONTRIBUTOR_TYPE_CD = 'NNMNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_NONMONETARY_GRAPH_ITEMS_20 --Nonmonetary Graph Items - Second Graph - Unvested Shares
	

,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'ESTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_SECON --Monetary Graph Items - Second Graph - Estimated value
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'ESTMKTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_SE_21 --Monetary Graph Items - Second Graph - Estimated Market Value of Total Shares
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTESTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_SE_22 --Monetary Graph Items - Second Graph - Estimated Value of Vested Shares
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTESTMKTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_SE_23 --Monetary Graph Items - Second Graph - Estimated Market Value of Vested Shares
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTESTUNEXVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_SE_24 --Monetary Graph Items - Second Graph - Estimated Value of Exercisable Shares
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'VESTESTUNEXMKTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_SE_25 --Monetary Graph Items - Second Graph - Estimated Market Value of Exercisable Shares
,(SELECT DECODE(INCLUDE_IN_CHART2_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'UNVESTESTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_SE_26 --Monetary Graph Items - Second Graph - Estimated Value of Unvested Shares
,(SELECT DECODE(INCLUDE_IN_CHART1_FLAG,'Y','Yes','No')
    FROM CMP_TCS_COL_IN_CAT
	WHERE COLUMN_TYPE_CD = 'UNVESTESTMKTVAL'
    AND CONTRIBUTOR_TYPE_CD = 'MNTRY'
	AND CAT_ID = compCatsE0.CAT_ID
	) RES_MONETARY_GRAPH_ITEMS_SE_27 --Monetary Graph Items - Second Graph - Estimated Market Value of Unvested Shares

,compCatsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,compCatsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,compCatsE0.CREATED_BY RSC_CREATED_BY
,compCatsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_TCS_CAT_VL compCatsE0
,(SELECT *
    FROM CMP_TCS_COL_IN_CAT
    WHERE COLUMN_TYPE_CD = 'EEC_CNTRB'
    AND CONTRIBUTOR_TYPE_CD = 'EECNTRB'
    ) selfConsE0
,(SELECT *
    FROM CMP_TCS_COL_IN_CAT
    WHERE COLUMN_TYPE_CD = 'ERC_CNTRB'
    AND CONTRIBUTOR_TYPE_CD = 'CMPYCNTRB'
    ) companyConsE0
WHERE compCatsE0.CAT_TYPE_CD NOT LIKE '%SECTION'
AND compCatsE0.CAT_ID = selfConsE0.CAT_ID(+)
AND compCatsE0.CAT_ID = companyConsE0.CAT_ID(+)
ORDER BY compCatsE0.NAME